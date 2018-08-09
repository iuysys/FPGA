`timescale 1ns / 100ps
//---------------------------------------------------
//-- 
`include "F:/FPGA/Verilog/OV7670_SDRAM_VGA/src/sdram_v2/sdram_para.v"
//---------------------------------------------------
//-- 
module OV7670_SDRAM_VGA_tb();

reg  									sys_clk			;
reg										rst_n			;
	
//ov7670 interface
wire					[7:0]			OV_data			;	
reg										OV_vsync		;
wire									OV_wrst			;
wire									OV_rrst			;
wire									OV_oe			;	
wire									OV_wen			;	
wire									OV_rclk			;

wire									SCCB_SDA		;
wire									SCCB_SCL		;


//vga interface	
wire									vga_blank		;
wire									vga_sync		;

wire									vga_clk			;						
wire									vga_hsync 		;
wire									vga_vsync		;
wire					[15:0]			vga_rgb_out		;	

//sdram interface		
wire									SDRAM_CLK		;
wire									SDRAM_CKE		;
wire									SDRAM_CS		;
wire									SDRAM_RAS		;
wire									SDRAM_CAS		;
wire									SDRAM_WE		;
wire				[`BANKSIZE-1:0]		SDRAM_BANK		;
wire				[`DATASIZE-1:0]		SDRAM_DQ 		;
wire				[`DQMSIZE-1:0]		SDRAM_DQM		;
wire				[`ROWSIZE-1:0]		SDRAM_ADDR		;

//---------------------------------------------------
//-- 
initial begin
	sys_clk = 1'b1 ;
	rst_n = 1'b1 ;
	OV_vsync = 1'b0 ;
	#50 rst_n = 1'B0 ;
	#100 rst_n = 1'B1 ;
end 
//---------------------------------------------------
//-- 
always #25 sys_clk = ~ sys_clk ;
//---------------------------------------------------
//-- 
//---------------------------------------------------
//-- 模拟ov7670数据
//---------------------------------------------------
//-- 帧同步信号
always begin
	#3_000 OV_vsync = 1'b1 ;
	#50_ 	OV_vsync = 1'b0 ;
end	
//---------------------------------------------------
//--
assign OV_data = 8'haf ;

//---------------------------------------------------
//-- 
OV7670_SDRAM_VGA	OV7670_SDRAM_VGA_inst(
.sys_clk		(sys_clk					),
.rst_n			(rst_n						),
	
//ov7670 interface
.OV_data		(OV_data					),	
.OV_vsync		(OV_vsync					),
.OV_wrst		(OV_wrst					),
.OV_rrst		(OV_rrst					),
.OV_oe			(OV_oe						),	
.OV_wen			(OV_wen						),	
.OV_rclk		(OV_rclk					),
.SCCB_SDA		(SCCB_SDA					),
.SCCB_SCL		(SCCB_SCL					),


//vga interface	
.vga_blank		(vga_blank					),
.vga_sync		(vga_sync					),

.vga_clk		(vga_clk					),						
.vga_hsync 		(vga_hsync 					),
.vga_vsync		(vga_vsync					),
.vga_rgb_out	(vga_rgb_out				),	

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

//---------------------------------------------------
//-- 
sdram_model_plus 	sdram_model_plus_inst(
.Dq				(SDRAM_DQ			), 
.Addr			(SDRAM_ADDR			), 
.Ba				(SDRAM_BANK			), 
.Clk			(SDRAM_CLK			), 
.Cke			(SDRAM_CKE			), 
.Cs_n			(SDRAM_CS			), 
.Ras_n			(SDRAM_RAS			), 
.Cas_n			(SDRAM_CAS			), 
.We_n			(SDRAM_WE			), 
.Dqm			(SDRAM_DQM			),
.Debug			(1'b1				)
);

endmodule