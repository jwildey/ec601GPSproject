module GPS(CLOCK_50,
			  LED_GREEN,
			  LED_RED,
			  PUSH_BTNS,
			  SWITCHES);
		 
	input CLOCK_50;
	output [7:0]  LED_GREEN;
	output [17:0] LED_RED;
	input  [3:0]  PUSH_BTNS;
	input  [17:0] SWITCHES;

	// NIOS CPU
	nios_cpu u0(
		.clk_clk (CLOCK_50),
		.led_green_export (LED_GREEN),
		.led_red_export (LED_RED),
		.push_btns_export (PUSH_BTNS),
		.reset_reset_n (1'b1),
		.switches_export (SWITCHES)
		);
	
	// CA Code Generator
//	cacode ca(
//		.rst (1'b1),
//      .clk (CLOCK_50),
//      .T0 (4'b0001),
//		.T1 (4'b0001),
//      .rd (1'b1),
//      .chip (1'b1),
//      .g1 (10'b0000000001), 
//		.g2 (10'b0000000001)
//		);

endmodule