/* We roll our own popen()/pclose() in OS/2.
   Thanks, Glenn Gribble! */

FILE *popen (char *cmd, char *mode);
int pclose (FILE *stream);
