
`timescale 1ns / 1ps
//---------------------------------------------------
//-- 
`include "F:/FPGA/Verilog/OV7670_SDRAM_VGA/src/sdram_v2/sdram_para.v"

module OV7670_SDRAM_VGA(
input  									sys_clk			,
input									rst_n			,
	
//ov7670 interface
input					[7:0]			OV_data			,	
input									OV_vsync		,
output									OV_wrst			,
output									OV_rrst			,
output									OV_oe			,	
output									OV_wen			,	
output									OV_rclk			,

output									SCCB_SDA		,
output									SCCB_SCL		,


//vga interface	
output									vga_blank		,
output									vga_sync		,

output									vga_clk			,						
output									vga_hsync 		,
output									vga_vsync		,
output					[15:0]			vga_rgb_out		,	

//sdram interface		
output									SDRAM_CLK		,
output									SDRAM_CKE		,
output									SDRAM_CS		,
output									SDRAM_RAS		,
output									SDRAM_CAS		,
output									SDRAM_WE		,
output				[`BANKSIZE-1:0]		SDRAM_BANK		,
inout				[`DATASIZE-1:0]		SDRAM_DQ 		,
output				[`DQMSIZE-1:0]		SDRAM_DQM		,
output				[`ROWSIZE-1:0]		SDRAM_ADDR		


);



//---------------------------------------------------
//-- 
//---------------------------------------------------
wire									sys_w_req		;	
wire									sys_w_clk		;	
wire				[15:0]				sys_w_data		;

wire									sdram_ctrl_clk	;
wire									sdram_clk_out	;
wire									vga_ctrl_clk	;

wire									vga_r_en		;
wire									vga_r_req		;
wire									vga_r_clk		;
wire				[15:0]				vga_r_data_in	;
wire 				[10:0]				r_fifo_rusedw	;
wire 				[10:0]				w_fifo_wusedw	;


wire 									vga_display_en	;
wire 				[9:0]				vga_x_pos		;
wire 				[9:0]				vga_y_pos		;
wire 				[15:0]				vga_r_data_out	;


//---------------------------------------------------
//-- 
//---------------------------------------------------
OV7670_top	OV7670_top_inst(
.S_CLK			(sys_clk					),
.RST_N			(rst_n						),
           
.SCCB_SDA		(SCCB_SDA					),
.SCCB_SCL		(SCCB_SCL					),

.OV_data		(OV_data					),
.OV_vsync		(OV_vsync					),			
.OV_wrst		(OV_wrst					),
.OV_rrst		(OV_rrst					),
.OV_oe			(OV_oe						),
.OV_wen			(OV_wen						),
.OV_rclk		(OV_rclk					),

.w_usedw		(w_fifo_wusedw				),
.w_req			(sys_w_req					),
.w_clk			(sys_w_clk					),
.w_data			(sys_w_data					)	
);

//---------------------------------------------------
//-- 
sdram_pll sdram_pll_inst(
.inclk0			(sys_clk					),
.c0				(sdram_ctrl_clk				),	
.c1				(sdram_clk_out				),
.c2				(vga_ctrl_clk				)
);



sdram_2port_top	sdram_2port_top_inst(
.clk			(sdram_ctrl_clk				),
.rst_n			(rst_n						),
.sdram_clk_in	(sdram_clk_out				),

//write fifo interface
.w_fifo_wreq	(sys_w_req					),
.w_fifo_wclk	(sys_w_clk					),
.sys_w_data		(sys_w_data					),
.w_fifo_wusedw	(w_fifo_wusedw				),
//read fifo interface
.r_fifo_rreq	(vga_r_req					),
.r_fifo_rclk	(vga_r_clk					),
.sys_r_data		(vga_r_data_in				),
.r_fifo_rusedw	(r_fifo_rusedw				),
//sdram interface		
.SDRAM_CLK		(SDRAM_CLK					),
.SDRAM_CKE		(SDRAM_CKE					),
.SDRAM_CS		(SDRAM_CS					),
.SDRAM_RAS		(SDRAM_RAS					),
.SDRAM_CAS		(SDRAM_CAS					),
.SDRAM_WE		(SDRAM_WE					),
.SDRAM_BANK		(SDRAM_BANK					),
.SDRAM_DQ 		(SDRAM_DQ 					),
.SDRAM_DQM		(SDRAM_DQM					),
.SDRAM_ADDR		(SDRAM_ADDR					)


);


VGA_CTRL	VGA_CTRL_inst(
.clk			(vga_ctrl_clk				),
.rst_n			(rst_n						),

.r_fifo_usedw	(r_fifo_rusedw				),
.vga_r_req		(vga_r_req					),
.vga_r_clk		(vga_r_clk					),
.vga_r_data_in	(vga_r_data_in				),

.vga_display_en	(vga_display_en				),
.vga_x_pos		(vga_x_pos					),
.vga_y_pos		(vga_y_pos					),

.vga_r_data_out	(vga_r_data_out				)	
);



VGA_driver		VGA_driver_inst(
.clk				(vga_ctrl_clk			),
.rst_n				(rst_n					),

.vga_rgb_in			(vga_r_data_out			),

.vga_display_en		(vga_display_en			),		//处于显示区

.vga_x_pos			(vga_x_pos				),
.vga_y_pos			(vga_y_pos				),



.vga_blank			(vga_blank				),
.vga_sync			(vga_sync				),
.vga_clk			(vga_clk				),						
.vga_hsync 			(vga_hsync 				),
.vga_vsync			(vga_vsync				),
.vga_rgb_out		(vga_rgb_out			)	
);


endmodule