/* CVS client logging buffer.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.  */

#include <config.h>

#include <stdio.h>

#include "cvs.h"
#include "buffer.h"

#if defined CLIENT_SUPPORT || defined SERVER_SUPPORT

/* We want to be able to log data sent between us and the server.  We
   do it using log buffers.  Each log buffer has another buffer which
   handles the actual I/O, and a file to log information to.

   This structure is the closure field of a log buffer.  */

struct log_buffer
{
    /* The underlying buffer.  */
    struct buffer *buf;
    /* The file to log information to.  */
    FILE *log;
    /* Whether errors writing to the log file should be fatal or not.  */
    bool fatal_errors;
};

static int log_buffer_input (void *, char *, int, int, int *);
static int log_buffer_output (void *, const char *, int, int *);
static int log_buffer_flush (void *);
static int log_buffer_block (void *, int);
static int log_buffer_get_fd (void *);
static int log_buffer_shutdown (struct buffer *);

/* Create a log buffer.  */

struct buffer *
log_buffer_initialize (struct buffer *buf, FILE *fp, bool fatal_errors,
                       bool input, void (*memory) (struct buffer *))
{
    struct log_buffer *n = xmalloc (sizeof *n);
    struct buffer *retbuf;

    n->buf = buf;
    n->log = fp;
    n->fatal_errors = fatal_errors;
    retbuf = buf_initialize (0, 0,
                             input ? log_buffer_input : NULL,
			     input ? NULL : log_buffer_output,
			     input ? NULL : log_buffer_flush,
			     log_buffer_block, log_buffer_get_fd,
			     log_buffer_shutdown, memory, n);

    if (!buf_empty_p (buf))
    {
	/* If our buffer already had data, log it & copy it.  This can happen,
	 * for instance, with a pserver, where we deliberately do not
         * instantiate the log buffer until after authentication so that auth
         * data does not get logged.
	 */
	struct buffer_data *data;
	for (data = buf->data; data = data->next; data != NULL)
	{
	    if (data->size)
	    {
		if (fwrite (data->bufp, 1, data->size, fp) != data->size)
		    error (fatal_errors, errno, "writing to log file");
		fflush (fp);
	    }
	}
	buf_append_buffer (retbuf, buf);
    }
    return retbuf;
}



/* The input function for a log buffer.  */
static int
log_buffer_input (void *closure, char *data, int need, int size, int *got)
{
    struct log_buffer *lb = closure;
    int status;
    size_t n_to_write;

    if (lb->buf->input == NULL)
	abort ();

    status = (*lb->buf->input) (lb->buf->closure, data, need, size, got);
    if (status != 0)
	return status;

    if (lb->log && *got > 0)
    {
	n_to_write = *got;
	if (fwrite (data, 1, n_to_write, lb->log) != n_to_write)
	    error (lb->fatal_errors, errno, "writing to log file");
	fflush (lb->log);
    }

    return 0;
}



/* The output function for a log buffer.  */
static int
log_buffer_output (void *closure, const char *data, int have, int *wrote)
{
    struct log_buffer *lb = closure;
    int status;
    size_t n_to_write;

    if (lb->buf->output == NULL)
	abort ();

    status = (*lb->buf->output) (lb->buf->closure, data, have, wrote);
    if (status != 0)
	return status;

    if (lb->log && *wrote > 0)
    {
	n_to_write = *wrote;
	if (fwrite (data, 1, n_to_write, lb->log) != n_to_write)
	    error (lb->fatal_errors, errno, "writing to log file");
	fflush (lb->log);
    }

    return 0;
}

/* The flush function for a log buffer.  */

static int
log_buffer_flush (void *closure)
{
    struct log_buffer *lb = closure;

    assert (lb->buf->flush);

    /* We don't really have to flush the log file here, but doing it
     * will let tail -f on the log file show what is sent to the
     * network as it is sent.
     */
    if (lb->log && (fflush (lb->log) || fsync (fileno (lb->log))))
        error (0, errno, "flushing log file");

    return (*lb->buf->flush) (lb->buf->closure);
}



/* The block function for a log buffer.  */
static int
log_buffer_block (void *closure, int block)
{
    struct log_buffer *lb = closure;

    if (block)
	return set_block (lb->buf);
    else
	return set_nonblock (lb->buf);
}



/* Disable logging without shutting down the next buffer in the chain.
 *
 * For an input buffer, this function also truncates the log before any unread
 * data based on BUF->LAST_INDEX & BUF->LAST_COUNT.
 */
void
log_buffer_disable (struct buffer *buf)
{
    struct log_buffer *lb = buf->closure;

    if (lb->log)
    {
	fflush (lb->log);
	fsync (fileno (lb->log));
	SIG_beginCrSect();
	if (fclose (lb->log) < 0)
	    error (0, errno, "closing log file");
	lb->log = NULL;
	SIG_endCrSect();
    }
}



/* Return the file descriptor of our log, flushing the stream first.
 */
int
log_buffer_get_log_fd (struct buffer *buf)
{
    struct log_buffer *lb = buf->closure;
    assert (lb->log);
    if (fflush (lb->log) == EOF)
	error (1, errno, "Failed to flush log stream");
    return fileno (lb->log);
}



/* Return the file descriptor underlying any child buffers.  */
static int
log_buffer_get_fd (void *closure)
{
    struct log_buffer *lb = closure;
    return buf_get_fd (lb->buf);
}



/* The shutdown function for a log buffer.  */
static int
log_buffer_shutdown (struct buffer *buf)
{
    struct log_buffer *lb = buf->closure;
    int retval;

    log_buffer_disable (buf);
    return buf_shutdown (lb->buf);
}



void
setup_logfiles (char *var, struct buffer **to_server_p,
                struct buffer **from_server_p)
{
  char *log = getenv (var);

  /* Set up logfiles, if any.
   *
   * We do this _after_ authentication on purpose.  Wouldn't really like to
   * worry about logging passwords...
   */
  if (log)
    {
      int len = strlen (log);
      char *buf = xmalloc (len + 5);
      char *p;
      FILE *fp;

      strcpy (buf, log);
      p = buf + len;

      /* Open logfiles in binary mode so that they reflect
	 exactly what was transmitted and received (that is
	 more important than that they be maximally
	 convenient to view).  */
      /* Note that if we create several connections in a single CVS client
	 (currently used by update.c), then the last set of logfiles will
	 overwrite the others.  There is currently no way around this.  */
      strcpy (p, ".in");
      fp = open_file (buf, "wb");
      if (fp == NULL)
	error (0, errno, "opening to-server logfile %s", buf);
      else
	*to_server_p = log_buffer_initialize (*to_server_p, fp, false, false,
					      NULL);

      strcpy (p, ".out");
      fp = open_file (buf, "wb");
      if (fp == NULL)
	error (0, errno, "opening from-server logfile %s", buf);
      else
	*from_server_p = log_buffer_initialize (*from_server_p, fp, false,
                                                true, NULL);

      free (buf);
    }
}

#endif /* CLIENT_SUPPORT || SERVER_SUPPORT */
