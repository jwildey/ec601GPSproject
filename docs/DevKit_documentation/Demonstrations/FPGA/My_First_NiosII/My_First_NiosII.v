module My_First_NiosII(
    ////////////CLOCK//////////
    CLOCK_50,
    ////////////FLASH//////
	 FL_CE_N,
	 FL_OE_N,
	 FL_RESET_N,
	 FL_RY,
	 FL_WE_N,
	 FL_WP_N,
	 /////////Data and Address bus shared by Flash ////////
	 FS_ADDR,
	 FS_DQ,
	 //////LED//////
    LED	 
);
input          CLOCK_50;
output  			FL_CE_N;
output 			FL_OE_N;
output 			FL_RESET_N;
inout				FL_RY;
output 			FL_WE_N;
output 			FL_WP_N;
output  [26:0] FS_ADDR;
inout   [15:0]	FS_DQ;
output  [7:0]  LED;
DE2i_150_QSYS  u0(
							.clk_clk  (CLOCK_50),
							.reset_reset_n  (1'b1),
							.flash_tri_state_bridge_out_fs_addr(FS_ADDR), 
							.flash_tri_state_bridge_out_fl_we_n(FL_WE_N),  
							.flash_tri_state_bridge_out_fl_read_n(FL_OE_N),  
							.flash_tri_state_bridge_out_fs_data(FS_DQ),    
							.flash_tri_state_bridge_out_fl_cs_n(FL_CE_N),
							.led_export (LED),
					   );  
//Flash Config
assign FL_RESET_N = 1'b1;
assign FL_WP_N 	= 1'b1;
endmodule
