/*
 * Trivially encode strings to protect them from innocent eyes (i.e.,
 * inadvertent password compromises, like a network administrator
 * who's watching packets for legitimate reasons and accidentally sees
 * the password protocol go by).
 * 
 * This is NOT secure encryption.
 *
 * It would be tempting to encode the password according to username
 * and repository, so that the same password would encode to a
 * different string when used with different usernames and/or
 * repositories.  However, then users would not be able to cut and
 * paste passwords around.  They're not supposed to anyway, but we all
 * know they will, and there's no reason to make it harder for them if
 * we're not trying to provide real security anyway.
 */

#include "cvs.h"

#if defined(AUTH_CLIENT_SUPPORT) || defined(AUTH_SERVER_SUPPORT)

/* Encode the string in place. */
void
scramble (char *str)
{
  /* does nothing yet */
}

/* Decode the string in place. */
void
descramble (char *str)
{
  /* does nothing yet */
}

#endif /* (AUTH_CLIENT_SUPPORT || AUTH_SERVER_SUPPORT) from top of file */
