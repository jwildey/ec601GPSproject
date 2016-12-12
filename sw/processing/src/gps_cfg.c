/*
 * gps_cfg.c
 *
 * Author: Josh Wildey
 */

#include <stdlib.h>
#include <libconfig.h>
#include <string.h>

//#include "gps_types.h"

/** The device configuration settings */
static config_t cfg;

static void CfgLoadInterfaces(void)
{

}

static void CfgLoadApplication(void)
{

}


void CfgLoad(void)
{
	   int err_line;
	   config_init(&cfg);

	   /* Read the configuration file. If there is an error, report it */
	   if (config_read_file(&cfg, "gps.cfg") == CONFIG_TRUE)
	   {
	      CfgLoadInterfaces();
	      CfgLoadApplication();
	   }
	   else
	   {
	      err_line = config_error_line(&cfg);
	      fprintf(stderr, "hardware.cfg:%d - %s\n", err_line,
	            config_error_text(&cfg));
	   }

}
