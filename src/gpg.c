/* gpgsplit.c - An OpenPGP signature packet splitting tool
 * Copyright (C) 2001, 2002, 2003 Free Software Foundation, Inc.
 *
 * This file is part of of CVS
 * (derived from gpgsplit.c distributed with GnuPG).
 *
 * GnuPG is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * GnuPG is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301,
 * USA.
 */

#ifdef HAVE_CONFIG_H
# include <config.h>
#endif /* HAVE_CONFIG_H */

/* Verify interface.  */
#include "gpg.h"

/* ANSI C Headers.  */
#include <assert.h>
#include <stdint.h>
#include <string.h>

/* GNULIB Headers.  */
#include "error.h"



typedef enum {
	PKT_NONE	   =0,
	PKT_PUBKEY_ENC	   =1, /* public key encrypted packet */
	PKT_SIGNATURE	   =2, /* secret key encrypted packet */
	PKT_SYMKEY_ENC	   =3, /* session key packet (OpenPGP)*/
	PKT_ONEPASS_SIG    =4, /* one pass sig packet (OpenPGP)*/
	PKT_SECRET_KEY	   =5, /* secret key */
	PKT_PUBLIC_KEY	   =6, /* public key */
	PKT_SECRET_SUBKEY  =7, /* secret subkey (OpenPGP) */
	PKT_COMPRESSED	   =8, /* compressed data packet */
	PKT_ENCRYPTED	   =9, /* conventional encrypted data */
	PKT_MARKER	  =10, /* marker packet (OpenPGP) */
	PKT_PLAINTEXT	  =11, /* plaintext data with filename and mode */
	PKT_RING_TRUST	  =12, /* keyring trust packet */
	PKT_USER_ID	  =13, /* user id packet */
	PKT_PUBLIC_SUBKEY =14, /* public subkey (OpenPGP) */
	PKT_OLD_COMMENT   =16, /* comment packet from an OpenPGP draft */
	PKT_ATTRIBUTE     =17, /* PGP's attribute packet */
	PKT_ENCRYPTED_MDC =18, /* integrity protected encrypted data */
	PKT_MDC 	  =19, /* manipulation detection code packet */
	PKT_COMMENT	  =61, /* new comment packet (private) */
        PKT_GPG_CONTROL   =63  /* internal control packet */
} pkttype_t;



static const char *
pkttype_to_string (int pkttype)
{
  const char *s;

  switch (pkttype)
    {
    case PKT_PUBKEY_ENC    : s = "pk_enc"; break;
    case PKT_SIGNATURE     : s = "sig"; break;
    case PKT_SYMKEY_ENC    : s = "sym_enc"; break;
    case PKT_ONEPASS_SIG   : s = "onepass_sig"; break;
    case PKT_SECRET_KEY    : s = "secret_key"; break;
    case PKT_PUBLIC_KEY    : s = "public_key"; break;
    case PKT_SECRET_SUBKEY : s = "secret_subkey"; break;
    case PKT_COMPRESSED    : s = "compressed";
      break;
    case PKT_ENCRYPTED     : s = "encrypted"; break;
    case PKT_MARKER	   : s = "marker"; break;
    case PKT_PLAINTEXT     : s = "plaintext"; break;
    case PKT_RING_TRUST    : s = "ring_trust"; break;
    case PKT_USER_ID       : s = "user_id"; break;
    case PKT_PUBLIC_SUBKEY : s = "public_subkey"; break;
    case PKT_OLD_COMMENT   : s = "old_comment"; break;
    case PKT_ATTRIBUTE     : s = "attribute"; break;
    case PKT_ENCRYPTED_MDC : s = "encrypted_mdc"; break;
    case PKT_MDC 	   : s = "mdc"; break;
    case PKT_COMMENT       : s = "comment"; break;
    case PKT_GPG_CONTROL   : s = "gpg_control"; break;
    default                : s = "unknown"; break;
    }
  return s;
}



static int
read_u8 (struct buffer *bpin, uint8_t *rn)
{
  char *tmp;
  size_t got;
  int rc;

  if ((rc = buf_read_data (bpin, 1, &tmp, &got)) < 0)
    return rc;
  assert (got == 1);
  *rn = *tmp;
  return 0;
}



static int
read_u16 (struct buffer *bpin, uint16_t *rn)
{
  uint8_t tmp;
  int rc;

  if ((rc = read_u8 (bpin, &tmp)))
    return rc;
  *rn = tmp << 8;
  if ((rc = read_u8 (bpin, &tmp)))
    return rc;
  *rn |= tmp;
  return 0;
}



static int
read_u32 (struct buffer *bpin, uint32_t *rn)
{
  uint16_t tmp;
  int rc;

  if ((rc = read_u16 (bpin, &tmp)))
    return rc;
  *rn = tmp << 16;
  if ((rc = read_u16 (bpin, &tmp)))
    return rc;
  *rn |= tmp;
  return 0;
}



/* hdr must point to a buffer large enough to hold all header bytes */
static int
write_part (struct buffer *bpin, struct buffer *bpout, unsigned long pktlen,
            int pkttype, int partial, uint8_t *hdr, size_t hdrlen)
{
  char *tmp;
  int rc;

  while (partial)
    {
      uint16_t partlen;
      
      assert (partial == 2);
      /* old gnupg */
      assert (!pktlen);
      if ((rc = read_u16 (bpin, &partlen)))
	return rc;
      hdr[hdrlen++] = partlen >> 8;
      hdr[hdrlen++] = partlen;
      buf_output (bpout, (char *)hdr, hdrlen);
      hdrlen = 0;
      if (!partlen)
	partial = 0; /* end of packet */
      while (partlen)
	{
	  size_t got;
	  if ((rc = buf_read_data (bpin, partlen, &tmp, &got)) < 0)
	    return rc;
	  assert (got);  /* Blocking buffers cannot return 0 bytes.  */
	  buf_output (bpout, tmp, got);
	  partlen -= got;
	}
    }

  if (hdrlen)
    buf_output (bpout, (char *)hdr, hdrlen);
  
  /* standard packet or last segment of partial length encoded packet */
  while (pktlen)
    {
      size_t got;
      if ((rc = buf_read_data (bpin, pktlen, &tmp, &got)) < 0)
	return rc;
      assert (got);  /* Blocking buffers cannot return 0 bytes.  */
      buf_output (bpout, tmp, got);
      pktlen -= got;
    }

  return 0;
}



/* Read a single signature packet header from BPIN.
 *
 * RETURNS
 *   0		On success.
 *   -1		If EOF is encountered before a full packet is read.
 *   -2		On memory allocation errors from buf_read_data().
 */
int
parse_header (struct buffer *bpin, int *pkttype, uint32_t *pktlen,
    	      int *partial, uint8_t *header, int *header_len)
{
  int ctb;
  int header_idx = 0;
  int lenbytes;
  int rc;
  uint8_t c;

  *pktlen = 0;
  *partial = 0;

  if ((rc = read_u8 (bpin, &c)))
    return rc;

  ctb = c;

  header[header_idx++] = ctb;
  
  if (!(ctb & 0x80))
    {
      error (0, 0, "invalid CTB %02x\n", ctb );
      return 1;
    }
  if ( (ctb & 0x40) )
    {
      /* new CTB */
      *pkttype =  (ctb & 0x3f);

      if ((rc = read_u8 (bpin, &c)))
	return rc;

      header[header_idx++] = c;

      if ( c < 192 )
        *pktlen = c;
      else if ( c < 224 )
        {
          *pktlen = (c - 192) * 256;
	  if ((rc = read_u8 (bpin, &c)))
	    return rc;
          header[header_idx++] = c;
          *pktlen += c + 192;
	}
      else if ( c == 255 ) 
        {
	  if ((rc = read_u32 (bpin, pktlen)))
	    return rc;
          header[header_idx++] = *pktlen >> 24;
          header[header_idx++] = *pktlen >> 16;
          header[header_idx++] = *pktlen >> 8;
          header[header_idx++] = *pktlen; 
	}
      else
        { /* partial body length */
          *pktlen = c;
          *partial = 1;
	}
    }
  else
    {
      *pkttype = (ctb>>2)&0xf;

      lenbytes = ((ctb&3)==3)? 0 : (1<<(ctb & 3));
      if (!lenbytes )
	{
	  *pktlen = 0; /* don't know the value */
	  *partial = 2; /* the old GnuPG partial length encoding */
	}
      else
	{
	  for (; lenbytes; lenbytes--) 
	    {
	      *pktlen <<= 8;
	      if ((rc = read_u8 (bpin, &c)))
		return rc;
	      header[header_idx++] = c;
	      
	      *pktlen |= c;
	    }
	}
    }

  *header_len = header_idx;
  return 0;
}



/* Read a single signature packet from BPIN, copying it to BPOUT.
 *
 * RETURNS
 *   0		On success.
 *   -1		If EOF is encountered before a full packet is read.
 *   -2		On memory allocation errors from buf_read_data().
 *
 * ERRORS
 *   Aside from the error returns above, buf_output() can call its memory
 *   failure function on memory allocation failures, which could exit.
 */
int
read_signature (struct buffer *bpin, struct buffer *bpout)
{
  int pkttype;
  uint32_t pktlen;
  int partial;
  uint8_t header[20];
  int header_len = sizeof header;
  int rc;

  if ((rc = parse_header (bpin, &pkttype, &pktlen, &partial, header,
			  &header_len)))
    return rc;

  if (pkttype != PKT_SIGNATURE)
    error (1, 0, "Inavlid OpenPGP packet type (%s)",
	   pkttype_to_string (pkttype));

  return write_part (bpin, bpout, pktlen, pkttype, partial,
                     header, header_len);
}



struct openpgp_signature
{
  uint64_t sigid;
};

/* Parse a single signature packet from BPIN, populating structure at SPOUT.
 *
 * RETURNS
 *   0		On success.
 *   -1		If EOF is encountered before a full packet is read.
 *   -2		On memory allocation errors from buf_read_data().
 *
 * ERRORS
 *   Aside from the error returns above, buf_output() can call its memory
 *   failure function on memory allocation failures, which could exit.
 */
int
parse_signature (struct buffer *bpin, struct openpgp_signature *spout)
{
  int pkttype;
  uint32_t pktlen;
  int partial;
  uint8_t header[20];
  int header_len = sizeof header;
  int rc;
  uint8_t c;

  if ((rc = parse_header (bpin, &pkttype, &pktlen, &partial, header,
			  &header_len)))
    return rc;

  if (pkttype != PKT_SIGNATURE)
    error (1, 0, "Inavlid OpenPGP packet type (%s)",
	   pkttype_to_string (pkttype));

  if ((rc = read_u8 (bpin, &c)))
    return rc;


  return 0;
}
