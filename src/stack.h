/*
 * Copyright (c) 2004, Free Software Foundation,
 *                     Derek Price,
 *                     & Ximbiot <http://ximbiot.com>.
 * 
 * You may distribute under the terms of the GNU General Public License as
 * specified in the README file that comes with the CVS source distribution.
 */

void push PROTO((List *_stack, void *_elem));
void *pop PROTO((List *_stack));
void unshift PROTO((List *_stack, void *_elem));
void *shift PROTO((List *_stack));
int isempty PROTO((List *_stack));
