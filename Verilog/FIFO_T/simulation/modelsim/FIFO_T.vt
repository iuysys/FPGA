// Copyright (C) 1991-2013 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License 
// Subscription Agreement, Altera MegaCore Function License 
// Agreement, or other applicable license agreement, including, 
// without limitation, that your use is for the sole purpose of 
// programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the 
// applicable agreement for further details.

// *****************************************************************************
// This file contains a Verilog test bench template that is freely editable to  
// suit user's needs .Comments are provided in each section to help the user    
// fill out necessary details.                                                  
// *****************************************************************************
// Generated on "03/08/2018 13:42:16"
                                                                                
// Verilog Test Bench template for design : FIFO_T
// 
// Simulation tool : ModelSim-Altera (Verilog)
// 

`timescale 1 ps/ 1 ps
module FIFO_T_vlg_tst();
// constants                                           
// general purpose registers
//reg eachvec;
// test vector input registers
reg CLK;
reg RDREQ;
reg RST_N;
reg WRREQ;
// wires                                               
wire [7:0]  DATA_OUT;
wire EMPTY;
wire FULL;

// assign statements (if any)                          
FIFO_T i1 (
// port map - connection between master ports and signals/registers   
	.CLK(CLK),
	.DATA_OUT(DATA_OUT),
	.EMPTY(EMPTY),
	.FULL(FULL),
	.RDREQ(RDREQ),
	.RST_N(RST_N),
	.WRREQ(WRREQ)
);
initial                                                
begin                                                  
// code that executes only once                        
// insert code here --> begin                          
	CLK = 1'B0;
	RST_N =1'B1; 
	RDREQ = 1'B0;
	WRREQ = 1'B0;
	#100 RST_N = 1'B0; 
	#10 RST_N = 1'B1; 
// --> end                                             
$display("Running testbench");                       
end                                                    
always                                                 
// optional sensitivity list                           
// @(event1 or event2 or .... eventn)                  
begin                                                  
// code executes for every event on sensitivity list   
// insert code here --> begin                          
   #1 CLK <= ~CLK;
	#2 WRREQ <= ~ WRREQ;
	#4	RDREQ <= ~RDREQ;
	
//@eachvec;                                              
// --> end                                             
end  

always@(posedge CLK)
begin
	
end









                                            
endmodule

