#serial 3

AC_DEFUN([gl_BISON],
[
  # getdate.y works with bison only.
  AM_MISSING_PROG(YACC, bison -y)
])
