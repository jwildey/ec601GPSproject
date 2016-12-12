/**
 *  Global Positioning System
 *
 *  \file       scheduler.c
 *  \brief      This modules contains the GPS scheduler behavior.
 *  \author     Josh Wildey
 *
 *  This modules contains the GPS scheduler behavior and sets up and schedules
 *  the threads of execution.
 *
 *  $Id$
 */

#include "thread1000hz.h"
#include "thread100hz.h"
#include "thread10hz.h"
#include "thread1hz.h"

int nRmsSchedulerClock;

void RmsSchedulerInit(void)
{
	nRmsSchedulerClock = 0;

	RmsThread1000Hz_Init();
	RmsThread100Hz_Init();
	RmsThread10Hz_Init();
	RmsThread1Hz_Init();
}


void RmsSchedulerRun(void)
{


#ifdef THREAD_SINGLE
	while (1 == 1)
	{
		RmsThread1000Hz_Func();

		if ( (nRmsSchedulerClock % 10) == 0)
		{
			RmsThread100Hz_Func();
		}
		if ( (nRmsSchedulerClock % 100) == 0)
		{
			RmsThread10Hz_Func();
		}
		if ( (nRmsSchedulerClock % 1000) == 0)
		{
			RmsThread1Hz_Func();
		}

		nRmsSchedulerClock++;

	}
#endif

}
