#ifndef SAVE_CWD_H
#define SAVE_CWD_H 1

#include "PROTO.h"

struct saved_cwd
  {
    int desc;
    char *name;
  };

int save_cwd PROTO((struct saved_cwd *cwd));
int restore_cwd PROTO((const struct saved_cwd *cwd, const char *dest));
void free_cwd PROTO((struct saved_cwd *cwd));

#endif /* SAVE_CWD_H */
