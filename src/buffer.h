/* Declarations concerning the buffer data structure.  */

#ifdef SERVER_SUPPORT

/*
 * We must read data from a child process and send it across the
 * network.  We do not want to block on writing to the network, so we
 * store the data from the child process in memory.  A BUFFER
 * structure holds the status of one communication, and uses a linked
 * list of buffer_data structures to hold data.
 */

struct buffer
{
    /* Data.  */
    struct buffer_data *data;

    /* Last buffer on data chain.  */
    struct buffer_data *last;

    /* File descriptor to write to or read from.  */
    int fd;

    /* Nonzero if this is an output buffer (sanity check).  */
    int output;

    /* Nonzero if the file descriptor is in nonblocking mode.  */
    int nonblocking;

    /* Function to call if we can't allocate memory.  */
    void (*memory_error) PROTO((struct buffer *));
};

/* Data is stored in lists of these structures.  */

struct buffer_data
{
    /* Next buffer in linked list.  */
    struct buffer_data *next;

    /*
     * A pointer into the data area pointed to by the text field.  This
     * is where to find data that has not yet been written out.
     */
    char *bufp;

    /* The number of data bytes found at BUFP.  */
    int size;

    /*
     * Actual buffer.  This never changes after the structure is
     * allocated.  The buffer is BUFFER_DATA_SIZE bytes.
     */
    char *text;
};

/* The size we allocate for each buffer_data structure.  */
#define BUFFER_DATA_SIZE (4096)

extern int buf_empty_p PROTO((struct buffer *));
extern void buf_output PROTO((struct buffer *, const char *, int));
extern void buf_output0 PROTO((struct buffer *, const char *));
extern void buf_append_char PROTO((struct buffer *, int));
extern int buf_send_output PROTO((struct buffer *));
extern int set_nonblock PROTO((struct buffer *));
extern int set_block PROTO((struct buffer *));
extern int buf_send_counted PROTO((struct buffer *));
extern void buf_append_data PROTO((struct buffer *,
				   struct buffer_data *,
				   struct buffer_data *));
extern int buf_read_file PROTO((FILE *, long, struct buffer_data **,
				struct buffer_data **));
extern int buf_read_file_to_eof PROTO((FILE *, struct buffer_data **,
				       struct buffer_data **));
extern int buf_input_data PROTO((struct buffer *, int *));
extern void buf_copy_lines PROTO((struct buffer *, struct buffer *, int));
extern int buf_copy_counted PROTO((struct buffer *, struct buffer *));
extern int buf_chain_length PROTO((struct buffer_data *));

#ifdef SERVER_FLOWCONTROL
extern int buf_count_mem PROTO((struct buffer *));
#endif /* SERVER_FLOWCONTROL */

#endif /* SERVER_SUPPORT */
