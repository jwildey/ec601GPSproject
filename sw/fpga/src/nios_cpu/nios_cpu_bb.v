
module nios_cpu (
	clk_clk,
	led_green_export,
	led_red_export,
	reset_reset_n,
	switches_export,
	push_btns_export);	

	input		clk_clk;
	output	[7:0]	led_green_export;
	output	[17:0]	led_red_export;
	input		reset_reset_n;
	input	[17:0]	switches_export;
	input	[3:0]	push_btns_export;
endmodule
