#serial 3

AC_DEFUN([gl_BISON],
[
  # getdate.y works with bison only.
  AM_MISSING_PROG(YACC, bison -y)
  AC_ARG_VAR(YACC,
[The `Yet Another C Compiler' implementation to use.  Defaults to `bison -y'.
Values other than `bison -y' will most likely break on most systems.])
  AC_ARG_VAR(YFLAGS,
[YFLAGS contains the list arguments that will be passed by default to Bison.
This script will default YFLAGS to the empty string to avoid a default value of
`-d' given by some make applications.])
])
