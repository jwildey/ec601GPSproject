/**
 *  Global Positioning System
 *  Main Code Entry Point
 *  Document No.:
 *
 *  \file       gps_main.c
 *  \brief      This modules contains the main entry point for the software
 *  \author     Josh Wildey
 *
 *  This module contains the main entry point for the Global Positioning
 *  System (GPS).
 *
 *  $Id$
 */



//#include "gps_types.h"
#include "gps_cfg.h"
#include "rms/scheduler.h"

int main(int argc, char** argv)
{

	printf("Hello Word My name is project Green\n");

	//CfgLoad();
	RmsSchedulerInit();

	/* Loop Forever */
	RmsSchedulerRun();


	return 0;
}
