/*
 * Copyright (c) 2004, Free Software Foundation,
 *                     Derek Price,
 *                     & Ximbiot <http://ximbiot.com>.
 * 
 * You may distribute under the terms of the GNU General Public License as
 * specified in the README file that comes with the CVS source distribution.
 *
 * This module uses the hash.c module to implement a stack.
 */

#include "cvs.h"
#include <assert.h>



void
push (stack, elem)
    List *stack;
    void *elem;
{
    Node *p = getnode();
    p->data = elem;
    addnode(stack, p);
}



void *pop (stack)
    List *stack;
{
    void *elem;

    if (isempty (stack)) return NULL;

    elem = stack->list->prev->data;
    stack->list->prev->data = NULL;
    delnode (stack->list->prev);
    return elem;
}



void
unshift (stack, elem)
    List *stack;
    void *elem;
{
    Node *p = getnode();
    p->data = elem;
    addnode_at_front(stack, p);
}



void *shift (stack)
    List *stack;
{
    void *elem;

    if (isempty (stack)) return NULL;

    elem = stack->list->next->data;
    stack->list->next->data = NULL;
    delnode (stack->list->next);
    return elem;
}

int
isempty (stack)
    List *stack;
{
    if (stack->list == stack->list->next)
	return 1;
    return 0;
}
