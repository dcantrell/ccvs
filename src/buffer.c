/* Code for the buffer data structure.  */

#include "cvs.h"
#include "buffer.h"

#ifdef SERVER_SUPPORT

#if HAVE_FCNTL_H
#include <fcntl.h>
#endif

#ifndef O_NONBLOCK
#define O_NONBLOCK O_NDELAY
#endif

/* EWOULDBLOCK is not defined by POSIX, but some BSD systems will
   return it, rather than EAGAIN, for nonblocking writes.  */
#ifdef EWOULDBLOCK
#define blocking_error(err) ((err) == EWOULDBLOCK || (err) == EAGAIN)
#else
#define blocking_error(err) ((err) == EAGAIN)
#endif

/* Linked list of available buffer_data structures.  */
static struct buffer_data *free_buffer_data;

/* Local functions.  */
static void allocate_buffer_datas PROTO((void));
static inline struct buffer_data *get_buffer_data PROTO((void));

/* Allocate more buffer_data structures.  */

static void
allocate_buffer_datas ()
{
    struct buffer_data *alc;
    char *space;
    int i;

    /* Allocate buffer_data structures in blocks of 16.  */
#define ALLOC_COUNT (16)

    alc = ((struct buffer_data *)
	   malloc (ALLOC_COUNT * sizeof (struct buffer_data)));
    space = (char *) valloc (ALLOC_COUNT * BUFFER_DATA_SIZE);
    if (alc == NULL || space == NULL)
	return;
    for (i = 0; i < ALLOC_COUNT; i++, alc++, space += BUFFER_DATA_SIZE)
    {
	alc->next = free_buffer_data;
	free_buffer_data = alc;
	alc->text = space;
    }	  
}

/* Get a new buffer_data structure.  */

static inline struct buffer_data *
get_buffer_data ()
{
    struct buffer_data *ret;

    if (free_buffer_data == NULL)
    {
	allocate_buffer_datas ();
	if (free_buffer_data == NULL)
	    return NULL;
    }

    ret = free_buffer_data;
    free_buffer_data = ret->next;
    return ret;
}

/* See whether a buffer is empty.  */

int
buf_empty_p (buf)
    struct buffer *buf;
{
    struct buffer_data *data;

    for (data = buf->data; data != NULL; data = data->next)
	if (data->size > 0)
	    return 0;
    return 1;
}

#ifdef SERVER_FLOWCONTROL
/*
 * Count how much data is stored in the buffer..
 * Note that each buffer is a malloc'ed chunk BUFFER_DATA_SIZE.
 */

int
buf_count_mem (buf)
    struct buffer *buf;
{
    struct buffer_data *data;
    int mem = 0;

    for (data = buf->data; data != NULL; data = data->next)
	mem += BUFFER_DATA_SIZE;

    return mem;
}
#endif /* SERVER_FLOWCONTROL */

/* Add data DATA of length LEN to BUF.  */

void
buf_output (buf, data, len)
    struct buffer *buf;
    const char *data;
    int len;
{
    if (buf->data != NULL
	&& (((buf->last->text + BUFFER_DATA_SIZE)
	     - (buf->last->bufp + buf->last->size))
	    >= len))
    {
	memcpy (buf->last->bufp + buf->last->size, data, len);
	buf->last->size += len;
	return;
    }

    while (1)
    {
	struct buffer_data *newdata;

	newdata = get_buffer_data ();
	if (newdata == NULL)
	{
	    (*buf->memory_error) (buf);
	    return;
	}

	if (buf->data == NULL)
	    buf->data = newdata;
	else
	    buf->last->next = newdata;
	newdata->next = NULL;
	buf->last = newdata;

	newdata->bufp = newdata->text;

	if (len <= BUFFER_DATA_SIZE)
	{
	    newdata->size = len;
	    memcpy (newdata->text, data, len);
	    return;
	}

	newdata->size = BUFFER_DATA_SIZE;
	memcpy (newdata->text, data, BUFFER_DATA_SIZE);

	data += BUFFER_DATA_SIZE;
	len -= BUFFER_DATA_SIZE;
    }

    /*NOTREACHED*/
}

/* Add a '\0' terminated string to BUF.  */

void
buf_output0 (buf, string)
    struct buffer *buf;
    const char *string;
{
    buf_output (buf, string, strlen (string));
}

/* Add a single character to BUF.  */

inline void
buf_append_char (buf, ch)
    struct buffer *buf;
    int ch;
{
    if (buf->data != NULL
	&& (buf->last->text + BUFFER_DATA_SIZE
	    != buf->last->bufp + buf->last->size))
    {
	*(buf->last->bufp + buf->last->size) = ch;
	++buf->last->size;
    }
    else
    {
	char b;

	b = ch;
	buf_output (buf, &b, 1);
    }
}

/*
 * Send all the output we've been saving up.  Returns 0 for success or
 * errno code.  If the buffer has been set to be nonblocking, this
 * will just write until the write would block.
 */

int
buf_send_output (buf)
     struct buffer *buf;
{
    if (! buf->output)
	abort ();

    while (buf->data != NULL)
    {
	struct buffer_data *data;

	data = buf->data;
	while (data->size > 0)
	{
	    int nbytes;

	    nbytes = write (buf->fd, data->bufp, data->size);
	    if (nbytes <= 0)
	    {
		int status;

		if (buf->nonblocking
		    && (nbytes == 0
			|| blocking_error (errno)))
		{
		    /*
		     * A nonblocking write failed to write any data.
		     * Just return.
		     */
		    return 0;
		}

		/*
		 * An error, or EOF.  Throw away all the data and
		 * return.
		 */
		if (nbytes == 0)
		    status = EIO;
		else
		    status = errno;

		buf->last->next = free_buffer_data;
		free_buffer_data = buf->data;
		buf->data = NULL;
		buf->last = NULL;

		return status;
	    }

	    data->size -= nbytes;
	    data->bufp += nbytes;
	}

	buf->data = data->next;
	data->next = free_buffer_data;
	free_buffer_data = data;
    }

    buf->last = NULL;

    return 0;
}

int
set_nonblock (buf)
     struct buffer *buf;
{
    int flags;

    if (buf->nonblocking)
	return 0;
    flags = fcntl (buf->fd, F_GETFL, 0);
    if (flags < 0)
	return errno;
    if (fcntl (buf->fd, F_SETFL, flags | O_NONBLOCK) < 0)
	return errno;
    buf->nonblocking = 1;
    return 0;
}

/*
 * Set buffer BUF to blocking I/O.  Returns 0 for success or errno
 * code.
 */

int
set_block (buf)
     struct buffer *buf;
{
    int flags;

    if (! buf->nonblocking)
	return 0;
    flags = fcntl (buf->fd, F_GETFL, 0);
    if (flags < 0)
	return errno;
    if (fcntl (buf->fd, F_SETFL, flags & ~O_NONBLOCK) < 0)
	return errno;
    buf->nonblocking = 0;
    return 0;
}

/*
 * Send a character count and some output.  Returns errno code or 0 for
 * success.
 *
 * Sending the count in binary is OK since this is only used on a pipe
 * within the same system.
 */

int
buf_send_counted (buf)
     struct buffer *buf;
{
    int size;
    struct buffer_data *data;

    if (! buf->output)
	abort ();

    size = 0;
    for (data = buf->data; data != NULL; data = data->next)
	size += data->size;

    data = get_buffer_data ();
    if (data == NULL)
    {
	(*buf->memory_error) (buf);
	return ENOMEM;
    }

    data->next = buf->data;
    buf->data = data;
    if (buf->last == NULL)
	buf->last = data;

    data->bufp = data->text;
    data->size = sizeof (int);

    *((int *) data->text) = size;

    return buf_send_output (buf);
}

/* Append a list of buffer_data structures to an buffer.  */

inline void
buf_append_data (buf, data, last)
     struct buffer *buf;
     struct buffer_data *data;
     struct buffer_data *last;
{
    if (data != NULL)
    {
	if (buf->data == NULL)
	    buf->data = data;
	else
	    buf->last->next = data;
	buf->last = last;
    }
}

/*
 * Copy the contents of file F into buffer_data structures.  We can't
 * copy directly into an buffer, because we want to handle failure and
 * succeess differently.  Returns 0 on success, or -2 if out of
 * memory, or a status code on error.  Since the caller happens to
 * know the size of the file, it is passed in as SIZE.  On success,
 * this function sets *RETP and *LASTP, which may be passed to
 * buf_append_data.
 */

int
buf_read_file (f, size, retp, lastp)
    FILE *f;
    long size;
    struct buffer_data **retp;
    struct buffer_data **lastp;
{
    int status;

    *retp = NULL;
    *lastp = NULL;

    while (size > 0)
    {
	struct buffer_data *data;
	int get;

	data = get_buffer_data ();
	if (data == NULL)
	{
	    status = -2;
	    goto error_return;
	}

	if (*retp == NULL)
	    *retp = data;
	else
	    (*lastp)->next = data;
	data->next = NULL;
	*lastp = data;

	data->bufp = data->text;
	data->size = 0;

	if (size > BUFFER_DATA_SIZE)
	    get = BUFFER_DATA_SIZE;
	else
	    get = size;

	errno = EIO;
	if (fread (data->text, get, 1, f) != 1)
	{
	    status = errno;
	    goto error_return;
	}

	data->size += get;
	size -= get;
    }

    return 0;

  error_return:
    if (*retp != NULL)
    {
	(*lastp)->next = free_buffer_data;
	free_buffer_data = *retp;
    }
    return status;
}

/*
 * Copy the contents of file F into buffer_data structures.  We can't
 * copy directly into an buffer, because we want to handle failure and
 * succeess differently.  Returns 0 on success, or -2 if out of
 * memory, or a status code on error.  On success, this function sets
 * *RETP and *LASTP, which may be passed to buf_append_data.
 */

int
buf_read_file_to_eof (f, retp, lastp)
     FILE *f;
     struct buffer_data **retp;
     struct buffer_data **lastp;
{
    int status;

    *retp = NULL;
    *lastp = NULL;

    while (!feof (f))
    {
	struct buffer_data *data;
	int get, nread;

	data = get_buffer_data ();
	if (data == NULL)
	{
	    status = -2;
	    goto error_return;
	}

	if (*retp == NULL)
	    *retp = data;
	else
	    (*lastp)->next = data;
	data->next = NULL;
	*lastp = data;

	data->bufp = data->text;
	data->size = 0;

	get = BUFFER_DATA_SIZE;

	errno = EIO;
	nread = fread (data->text, 1, get, f);
	if (nread == 0 && !feof (f))
	{
	    status = errno;
	    goto error_return;
	}

	data->size = nread;
    }

    return 0;

  error_return:
    if (*retp != NULL)
    {
	(*lastp)->next = free_buffer_data;
	free_buffer_data = *retp;
    }
    return status;
}

/* Return the number of bytes in a chain of buffer_data structures.  */

int
buf_chain_length (buf)
     struct buffer_data *buf;
{
    int size = 0;
    while (buf)
    {
	size += buf->size;
	buf = buf->next;
    }
    return size;
}

/*
 * Read an arbitrary amount of data from a file descriptor into an
 * input buffer.  The file descriptor will be in nonblocking mode, and
 * we just grab what we can.  Return 0 on success, or -1 on end of
 * file, or -2 if out of memory, or an error code.  If COUNTP is not
 * NULL, *COUNTP is set to the number of bytes read.
 */

int
buf_input_data (buf, countp)
     struct buffer *buf;
     int *countp;
{
    if (buf->output)
	abort ();

    if (countp != NULL)
	*countp = 0;

    while (1)
    {
	int get;
	int nbytes;

	if (buf->data == NULL
	    || (buf->last->bufp + buf->last->size
		== buf->last->text + BUFFER_DATA_SIZE))
	{
	    struct buffer_data *data;

	    data = get_buffer_data ();
	    if (data == NULL)
	    {
		(*buf->memory_error) (buf);
		return -2;
	    }

	    if (buf->data == NULL)
		buf->data = data;
	    else
		buf->last->next = data;
	    data->next = NULL;
	    buf->last = data;

	    data->bufp = data->text;
	    data->size = 0;
	}

	get = ((buf->last->text + BUFFER_DATA_SIZE)
	       - (buf->last->bufp + buf->last->size));
	nbytes = read (buf->fd, buf->last->bufp + buf->last->size, get);
	if (nbytes <= 0)
	{
	    if (nbytes == 0)
	    {
		/*
		 * This assumes that we are using POSIX or BSD style
		 * nonblocking I/O.  On System V we will get a zero
		 * return if there is no data, even when not at EOF.
		 */
		return -1;
	    }

	    if (blocking_error (errno))
	      return 0;

	    return errno;
	}

	buf->last->size += nbytes;
	if (countp != NULL)
	    *countp += nbytes;
    }

    /*NOTREACHED*/
}

/*
 * Copy lines from an input buffer to an output buffer.  This copies
 * all complete lines (characters up to a newline) from INBUF to
 * OUTBUF.  Each line in OUTBUF is preceded by the character COMMAND
 * and a space.
 */

void
buf_copy_lines (outbuf, inbuf, command)
     struct buffer *outbuf;
     struct buffer *inbuf;
     int command;
{
    if (! outbuf->output || inbuf->output)
	abort ();

    while (1)
    {
	struct buffer_data *data;
	struct buffer_data *nldata;
	char *nl;
	int len;

	/* See if there is a newline in INBUF.  */
	nldata = NULL;
	nl = NULL;
	for (data = inbuf->data; data != NULL; data = data->next)
	{
	    nl = memchr (data->bufp, '\n', data->size);
	    if (nl != NULL)
	    {
		nldata = data;
		break;
	    }
	}

	if (nldata == NULL)
	{
	    /* There are no more lines in INBUF.  */
	    return;
	}

	/* Put in the command.  */
	buf_append_char (outbuf, command);
	buf_append_char (outbuf, ' ');

	if (inbuf->data != nldata)
	{
	    /*
	     * Simply move over all the buffers up to the one containing
	     * the newline.
	     */
	    for (data = inbuf->data; data->next != nldata; data = data->next)
		;
	    data->next = NULL;
	    buf_append_data (outbuf, inbuf->data, data);
	    inbuf->data = nldata;
	}

	/*
	 * If the newline is at the very end of the buffer, just move
	 * the buffer onto OUTBUF.  Otherwise we must copy the data.
	 */
	len = nl + 1 - nldata->bufp;
	if (len == nldata->size)
	{
	    inbuf->data = nldata->next;
	    if (inbuf->data == NULL)
		inbuf->last = NULL;

	    nldata->next = NULL;
	    buf_append_data (outbuf, nldata, nldata);
	}
	else
	{
	    buf_output (outbuf, nldata->bufp, len);
	    nldata->bufp += len;
	    nldata->size -= len;
	}
    }
}

/*
 * Copy counted data from one buffer to another.  The count is an
 * integer, host size, host byte order (it is only used across a
 * pipe).  If there is enough data, it should be moved over.  If there
 * is not enough data, it should remain on the original buffer.  This
 * returns the number of bytes it needs to see in order to actually
 * copy something over.
 */

int
buf_copy_counted (outbuf, inbuf)
     struct buffer *outbuf;
     struct buffer *inbuf;
{
    if (! outbuf->output || inbuf->output)
	abort ();

    while (1)
    {
	struct buffer_data *data;
	int need;
	union
	{
	    char intbuf[sizeof (int)];
	    int i;
	} u;
	char *intp;
	int count;
	struct buffer_data *start;
	int startoff;
	struct buffer_data *stop;
	int stopwant;

	/* See if we have enough bytes to figure out the count.  */
	need = sizeof (int);
	intp = u.intbuf;
	for (data = inbuf->data; data != NULL; data = data->next)
	{
	    if (data->size >= need)
	    {
		memcpy (intp, data->bufp, need);
		break;
	    }
	    memcpy (intp, data->bufp, data->size);
	    intp += data->size;
	    need -= data->size;
	}
	if (data == NULL)
	{
	    /* We don't have enough bytes to form an integer.  */
	    return need;
	}

	count = u.i;
	start = data;
	startoff = need;

	/*
	 * We have an integer in COUNT.  We have gotten all the data
	 * from INBUF in all buffers before START, and we have gotten
	 * STARTOFF bytes from START.  See if we have enough bytes
	 * remaining in INBUF.
	 */
	need = count - (start->size - startoff);
	if (need <= 0)
	{
	    stop = start;
	    stopwant = count;
	}
	else
	{
	    for (data = start->next; data != NULL; data = data->next)
	    {
		if (need <= data->size)
		    break;
		need -= data->size;
	    }
	    if (data == NULL)
	    {
		/* We don't have enough bytes.  */
		return need;
	    }
	    stop = data;
	    stopwant = need;
	}

	/*
	 * We have enough bytes.  Free any buffers in INBUF before
	 * START, and remove STARTOFF bytes from START, so that we can
	 * forget about STARTOFF.
	 */
	start->bufp += startoff;
	start->size -= startoff;

	if (start->size == 0)
	    start = start->next;

	if (stop->size == stopwant)
	{
	    stop = stop->next;
	    stopwant = 0;
	}

	while (inbuf->data != start)
	{
	    data = inbuf->data;
	    inbuf->data = data->next;
	    data->next = free_buffer_data;
	    free_buffer_data = data;
	}

	/*
	 * We want to copy over the bytes from START through STOP.  We
	 * only want STOPWANT bytes from STOP.
	 */

	if (start != stop)
	{
	    /* Attach the buffers from START through STOP to OUTBUF.  */
	    for (data = start; data->next != stop; data = data->next)
		;
	    inbuf->data = stop;
	    data->next = NULL;
	    buf_append_data (outbuf, start, data);
	}

	if (stopwant > 0)
	{
	    buf_output (outbuf, stop->bufp, stopwant);
	    stop->bufp += stopwant;
	    stop->size -= stopwant;
	}
    }

    /*NOTREACHED*/
}

#endif /* SERVER_SUPPORT */
