/*
 * main.c
 *
 *  Created on: Dec 10, 2016
 *      Author: Josh
 */

#include <stdio.h>
#include <unistd.h>
#include "system.h"
#include "alt_types.h"
#include "altera_avalon_pio_regs.h"
#include "sys/alt_sys_init.h"
#include "sys/alt_irq.h"
#include "io.h"

void pushBtnIsr(void* isr_context)
{
	int pushBtnIn, ledOut;
	pushBtnIn = IORD_ALTERA_AVALON_PIO_DATA(PUSH_BTNS_BASE);
	ledOut    = IORD_ALTERA_AVALON_PIO_DATA(LED_GREEN_BASE);
	if (pushBtnIn == 0x01)
	{
		ledOut = ledOut << 1;
		IOWR_ALTERA_AVALON_PIO_DATA(LED_GREEN_BASE, ledOut);
	}
	printf("Interrupt Captured!!");
}

int main ()
{
	int in, out;
	int result;

	IOWR_ALTERA_AVALON_PIO_DATA(LED_GREEN_BASE, 0x01);

	// register the push button irq to be serviced by pushBtnIsr() function
	alt_irq_init(NULL);  // Initialize interrupt requests
//	result = alt_ic_irq_enable(0,PUSH_BTNS_IRQ);
//	printf("Result from IRQ Enable: %d\n", result);
	result = alt_ic_isr_register(0,PUSH_BTNS_IRQ, pushBtnIsr, NULL, NULL);
	printf("Result from IRQ Register: %d\n", result);

	while (1)
	{
		in = IORD_ALTERA_AVALON_PIO_DATA(SWITCHES_BASE);
		out = in;
		IOWR_ALTERA_AVALON_PIO_DATA(LED_RED_BASE, out);
		usleep(250000); // sleep for .25 s
//		printf("Hello from GPS NIOS CPU!\n");
	}

	return 0;
}

