#ifndef _getline_h_
#define _getline_h_ 1

#include <stdio.h>

#include "PROTO.h"

#define GETLINE_NO_LIMIT -1

int
  getline PROTO ((char **_lineptr, size_t *_n, FILE *_stream));
int
  getline_safe PROTO ((char **_lineptr, size_t *_n, FILE *_stream,
                         int limit));
int
  getstr PROTO ((char **_lineptr, size_t *_n, FILE *_stream,
		   int _terminator, int _offset, int limit));

#endif /* _getline_h_ */
