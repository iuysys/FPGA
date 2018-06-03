module OV7670_TOP
(
	//
	SYS_CLK,RST_N,
	//0V7670 input
	OV_DATA,OV_VSYNC,
	//0V7670 output
	OV_SCL,OV_SDA,OV_RRST,OV_RCLK,OV_WEN,OV_WRRST,
	//VGA output
	VGA_HSYNC,VGA_VSYNC,VGA_CLK,VGA_DATA
);

//-------------------------------------------------------
//-- 
//-------------------------------------------------------
input 				SYS_CLK;
input					RST_N;
input		[7:0]		OV_DATA;
input					OV_VSYNC;

output				OV_SDA;
output				OV_SCL;
output				OV_RRST;
output				OV_RCLK;
output				OV_WEN;
output				OV_WRRST;

output				VGA_HSYNC;
output				VGA_VSYNC;
output				VGA_CLK;
output	[15:0]		VGA_DATA;
//-------------------------------------------------------
//-- 
//-------------------------------------------------------
wire clk_40m;

wire init_en;
wire init_done ;

wire wr_frame;
wire run_en;
wire r_idle;

wire read_en;
wire rd_frame;

wire vga_rd_en;
wire cache_rclk;
wire cache_rreq;
wire [15:0] cache_data;

//-------------------------------------------------------
//-- 
//-------------------------------------------------------

PLL_IP	PLL_IP_inst (
	.inclk0 ( SYS_CLK ),
	.c0 ( clk_40m ),
	.c1 ( VGA_CLK )
	);
	
//-------------------------------------------------------
//-- 
//-------------------------------------------------------
ov7670_control ov7670_control_inst
(
	//system input
	.SYS_CLK(SYS_CLK),
	.RST_N(RST_N),
	.WR_FRAME(wr_frame),
	.RD_FRAME(rd_frame),
	.INIT_DONE(init_done),
	//system output
	.RUN_EN(run_en),
	.READ_EN(read_en),
	.INIT_EN(init_en),
	.R_IDLE(r_idle)
);
//-------------------------------------------------------
//-- 
//-------------------------------------------------------
I2C_control I2C_control_inst1
(
	//input
	.CLK(SYS_CLK),
	.RST_N(RST_N),
	.START(init_en),
	//output
	.SDA(OV_SDA),
	.SCL(OV_SCL),
	.DONE(init_done)
);

//-------------------------------------------------------
//-- 
//-------------------------------------------------------
ov7670_run ov7670_run_inst1
(
	//system input
	.SYS_CLK(SYS_CLK),
	.RST_N(RST_N),
	.RUN_EN(run_en),
	.OV_VSYNC(OV_VSYNC),
	.R_IDLE(r_idle),
	//
	.OV_WRRST(OV_WRRST),
	.OV_WEN(OV_WEN),
	.WR_FRAME(wr_frame)
);
//-------------------------------------------------------
//-- 
//-------------------------------------------------------
ov7670_read ov7670_read_inst1
(
	//
	.CLK_40M(clk_40m),
	.RST_N(RST_N),
	.READ_EN(read_en),
	.OV_DATA(OV_DATA),
	.CACHE_RCLK(cache_rclk),
	.CACHE_RREQ(cache_rreq),
	//
	.RD_FRAME(rd_frame),
	.OV_RRST(OV_RRST),
	.OV_RCLK(OV_RCLK),
	.CACHE_RD_EN(vga_rd_en),
	.CACHE_DATA(cache_data)
);
//-------------------------------------------------------
//-- 
//-------------------------------------------------------
//VGA VGA_inst1
//(
//	//输入端口
//	.CLK_40M(clk_40m),
//	.RST_N(RST_N),
//	.DATA_IN(cache_data),
//	.CACHE_RD_EN(vga_rd_en),//vga_rd_en
//	//输出端口
//	.VSYNC(VGA_VSYNC),
//	.HSYNC(VGA_HSYNC),
//	.DATA_OUT(VGA_DATA),
//	.CACHE_RREQ(cache_rreq),
//	.CACHE_RCLK(cache_rclk)
//);

endmodule

