`timescale 1ns / 100ps
//---------------------------------------------------
//-- 
`include "F:/FPGA/Verilog/SDRAM_V2/src/sdram_para.v"

module SDRAM_tb();




//---------------------------------------------------
//-- 
//---------------------------------------------------
reg										clk			;
reg										rst_n		;
			
			
wire									SDRAM_CLK	;
wire									SDRAM_CKE	;
wire									SDRAM_CS	;
wire									SDRAM_RAS	;
wire									SDRAM_CAS	;
wire									SDRAM_WE	;
wire				[`BANKSIZE-1:0]		SDRAM_BANK	;
wire				[`DATASIZE-1:0]		SDRAM_DQ	;
wire				[`DQMSIZE-1:0]		SDRAM_DQM	;
wire				[`ROWSIZE-1:0]		SDRAM_ADDR	;	
wire									sdram_clk_in	;

wire									w_fifo_wreq	;
reg										w_fifo_wclk	;
reg					[15:0]				sys_w_data	;

wire									r_fifo_rreq	;
reg										r_fifo_rclk	;
wire				[15:0]				sys_r_data	;

wire				[10:0]				r_fifo_rusedw;
wire				[10:0]				w_fifo_wusedw;

// time 									wait_time	;

//---------------------------------------------------
//-- 
//---------------------------------------------------
initial begin
	clk = 1'b1 ;
	rst_n = 1'b1 ;
	w_fifo_wclk = 'b0 ;
	r_fifo_rclk = 'b0 ;
	// wait_time = $time ;
	#50 rst_n = 1'B0 ;
	#100 rst_n = 1'B1 ;
end 
//---------------------------------------------------
//-- 
always #5 clk = ~ clk ;
assign sdram_clk_in = ~clk; 
//---------------------------------------------------
//-- 

always begin
	#20 w_fifo_wclk = 'b1 ;
	#20 w_fifo_wclk = 'b0 ;
end

always @ (posedge w_fifo_wclk or negedge rst_n) begin
    if(!rst_n) begin
    	sys_w_data <= 'b0 ;
    end
    else if(w_fifo_wusedw < `BURST_LENGTH )begin
    	sys_w_data <= 16'haf ;
    end
end
assign w_fifo_wreq = (w_fifo_wusedw < `BURST_LENGTH) ? 'b1 : 'b0 ;

//---------------------------------------------------
//-- 
always begin
	#12 r_fifo_rclk = 'b1 ;
	#12 r_fifo_rclk = 'b0 ;
end

assign r_fifo_rreq = (r_fifo_rusedw > `BURST_LENGTH) ? 'b1 : 'b0 ;


sdram_2port_top		sdram_2port_top_inst(
.clk				(clk					),
.rst_n				(rst_n					),
.sdram_clk_in		(sdram_clk_in			),

//write fifo interface
.w_fifo_wreq		(w_fifo_wreq			),
.w_fifo_wclk		(w_fifo_wclk			),
.sys_w_data			(sys_w_data				),
.w_fifo_wusedw		(w_fifo_wusedw			),
//read fifo interface
.r_fifo_rreq		(r_fifo_rreq			),
.r_fifo_rclk		(r_fifo_rclk			),
.sys_r_data			(sys_r_data				),
.r_fifo_rusedw		(r_fifo_rusedw			),
//sdram interface		
.SDRAM_CLK			(SDRAM_CLK				),
.SDRAM_CKE			(SDRAM_CKE				),
.SDRAM_CS			(SDRAM_CS				),
.SDRAM_RAS			(SDRAM_RAS				),
.SDRAM_CAS			(SDRAM_CAS				),
.SDRAM_WE			(SDRAM_WE				),
.SDRAM_BANK			(SDRAM_BANK				),
.SDRAM_DQ 			(SDRAM_DQ 				),
.SDRAM_DQM			(SDRAM_DQM				),
.SDRAM_ADDR			(SDRAM_ADDR				)


);
//---------------------------------------------------
//-- 
sdram_model_plus sdram_model_plus_inst(
.Dq		(SDRAM_DQ			), 
.Addr	(SDRAM_ADDR			), 
.Ba		(SDRAM_BANK			), 
.Clk	(SDRAM_CLK			), 
.Cke	(SDRAM_CKE			), 
.Cs_n	(SDRAM_CS			), 
.Ras_n	(SDRAM_RAS			), 
.Cas_n	(SDRAM_CAS			), 
.We_n	(SDRAM_WE			), 
.Dqm	(SDRAM_DQM			),
.Debug  (1'b1				)
);



endmodule