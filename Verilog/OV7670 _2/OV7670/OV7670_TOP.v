module OV7670_TOP
(
	//
	SYS_CLK,RST_N,
	//0V7670 input
	OV_DATA,OV_VSYNC,
	//0V7670 output
	OV_SCL,OV_SDA,OV_RRST,OV_RCLK,OV_WEN,OV_WRRST,
	//UART
	TX
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
output 				TX;
//-------------------------------------------------------
//-- 
//-------------------------------------------------------
wire clk_40m;
wire global_clk_40m;

wire init_en;
wire init_done ;

wire wr_frame;
wire run_en;
wire r_idle;

wire read_en;
wire rd_frame;

wire tx_cache_wrfull ;
wire [7:0] tx_cache_data;
wire tx_cache_wrclk;
wire tx_cache_wrreq;

//-------------------------------------------------------
//-- 
//-------------------------------------------------------
PLL_IP	PLL_IP_inst (
	.inclk0 ( SYS_CLK ),
	.c0 ( global_clk_40m )
	);
	
ov_read_clk	ov_read_clk_inst (
	.inclk ( global_clk_40m ),
	.outclk ( clk_40m )
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
	.READ_EN(1'b1),
	.OV_DATA(OV_DATA),
	.TX_CACHE_WRFULL(tx_cache_wrfull),
	//
	.RD_FRAME(rd_frame),
	.OV_RRST(OV_RRST),
	.OV_RCLK(OV_RCLK),
	.TX_CACHE_DATA(tx_cache_data),
	.TX_CACHE_WRCLK(tx_cache_wrclk),
	.TX_CACHE_WRREQ(tx_cache_wrreq)
);
//-------------------------------------------------------
//-- 
//-------------------------------------------------------
UART_TOP uart_top_inst1
(
	//输入
	.SYS_CLK(SYS_CLK),
	.RST_N(RST_N),
	.WRREQ(tx_cache_wrreq),
	.WRCLK(tx_cache_wrclk),
	.FIFO_DATA(tx_cache_data),
	//输出
	.TXD(TX),
	.WRFULL(tx_cache_wrfull)
);


endmodule

