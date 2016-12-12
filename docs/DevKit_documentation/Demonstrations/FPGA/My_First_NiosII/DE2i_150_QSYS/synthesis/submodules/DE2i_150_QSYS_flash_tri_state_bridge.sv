// (C) 2001-2012 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// $Id: //acds/rel/12.1/ip/merlin/altera_tristate_conduit_bridge/altera_tristate_conduit_bridge.sv.terp#1 $
// $Revision: #1 $
// $Date: 2012/08/12 $
// $Author: swbranch $

//Defined Terp Parameters


			    

`timescale 1 ns / 1 ns
  				      
module DE2i_150_QSYS_flash_tri_state_bridge (
     input  logic clk
    ,input  logic reset
    ,input  logic request
    ,output logic grant
    ,input  logic[ 0 :0 ] tcs_fl_we_n
    ,output  wire [ 0 :0 ] fl_we_n
    ,output logic[ 15 :0 ] tcs_fs_data_in
    ,input  logic[ 15 :0 ] tcs_fs_data
    ,input  logic tcs_fs_data_outen
    ,inout  wire [ 15 :0 ]  fs_data
    ,input  logic[ 25 :0 ] tcs_fs_addr
    ,output  wire [ 25 :0 ] fs_addr
    ,input  logic[ 0 :0 ] tcs_fl_read_n
    ,output  wire [ 0 :0 ] fl_read_n
    ,input  logic[ 0 :0 ] tcs_fl_cs_n
    ,output  wire [ 0 :0 ] fl_cs_n
		     
   );
   reg grant_reg;
   assign grant = grant_reg;
   
   always@(posedge clk) begin
      if(reset)
	grant_reg <= 0;
      else
	grant_reg <= request;      
   end
   


 // ** Output Pin fl_we_n 
 
    reg                       fl_we_nen_reg;     
  
    always@(posedge clk) begin
	 if( reset ) begin
	   fl_we_nen_reg <= 'b0;
	 end
	 else begin
	   fl_we_nen_reg <= 'b1;
	 end
     end		     
   
 
    reg [ 0 : 0 ] fl_we_n_reg;   

     always@(posedge clk) begin
	 fl_we_n_reg   <= tcs_fl_we_n[ 0 : 0 ];
      end
          
 
    assign 	fl_we_n[ 0 : 0 ] = fl_we_nen_reg ? fl_we_n_reg : 'z ;
        


 // ** Bidirectional Pin fs_data 
   
    reg                       fs_data_outen_reg;
  
    always@(posedge clk) begin
	 fs_data_outen_reg <= tcs_fs_data_outen;
     end
  
  
    reg [ 15 : 0 ] fs_data_reg;   

     always@(posedge clk) begin
	 fs_data_reg   <= tcs_fs_data[ 15 : 0 ];
      end
         
  
    assign 	fs_data[ 15 : 0 ] = fs_data_outen_reg ? fs_data_reg : 'z ;
       
  
    reg [ 15 : 0 ] 	fs_data_in_reg;
								    
    always@(posedge clk) begin
	 fs_data_in_reg <= fs_data[ 15 : 0 ];
    end
    
  
    assign      tcs_fs_data_in[ 15 : 0 ] = fs_data_in_reg[ 15 : 0 ];
        


 // ** Output Pin fs_addr 
 
    reg                       fs_addren_reg;     
  
    always@(posedge clk) begin
	 if( reset ) begin
	   fs_addren_reg <= 'b0;
	 end
	 else begin
	   fs_addren_reg <= 'b1;
	 end
     end		     
   
 
    reg [ 25 : 0 ] fs_addr_reg;   

     always@(posedge clk) begin
	 fs_addr_reg   <= tcs_fs_addr[ 25 : 0 ];
      end
          
 
    assign 	fs_addr[ 25 : 0 ] = fs_addren_reg ? fs_addr_reg : 'z ;
        


 // ** Output Pin fl_read_n 
 
    reg                       fl_read_nen_reg;     
  
    always@(posedge clk) begin
	 if( reset ) begin
	   fl_read_nen_reg <= 'b0;
	 end
	 else begin
	   fl_read_nen_reg <= 'b1;
	 end
     end		     
   
 
    reg [ 0 : 0 ] fl_read_n_reg;   

     always@(posedge clk) begin
	 fl_read_n_reg   <= tcs_fl_read_n[ 0 : 0 ];
      end
          
 
    assign 	fl_read_n[ 0 : 0 ] = fl_read_nen_reg ? fl_read_n_reg : 'z ;
        


 // ** Output Pin fl_cs_n 
 
    reg                       fl_cs_nen_reg;     
  
    always@(posedge clk) begin
	 if( reset ) begin
	   fl_cs_nen_reg <= 'b0;
	 end
	 else begin
	   fl_cs_nen_reg <= 'b1;
	 end
     end		     
   
 
    reg [ 0 : 0 ] fl_cs_n_reg;   

     always@(posedge clk) begin
	 fl_cs_n_reg   <= tcs_fl_cs_n[ 0 : 0 ];
      end
          
 
    assign 	fl_cs_n[ 0 : 0 ] = fl_cs_nen_reg ? fl_cs_n_reg : 'z ;
        

endmodule


