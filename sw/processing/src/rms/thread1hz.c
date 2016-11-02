/**
 *  Global Positioning System
 *
 *  \file       thread1hz.c
 *  \brief      This modules contains the 1hz thread behavior
 *  \author     Josh Wildey
 *
 *  This module setups the 1Hz execution thread.
 *
 *  $Id$
 */

#include <pthread.h>

void RmsThread1Hz_Func(void)
{
	printf("This is the 1Hz Thread\n");
}

void RmsThread1Hz_Init(void)
{

}
