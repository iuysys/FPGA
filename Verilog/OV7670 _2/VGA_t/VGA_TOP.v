module VGA_TOP
(
	//输入端口
	SYS_CLK,RST_N,DATA_IN,CACHE_RD_EN,
	//输出端口
	VGA_VSYNC,VGA_HSYNC,VGA_DATA,CACHE_RREQ,CACHE_RCLK,VGA_CLK
); 

input 				SYS_CLK;					//时钟的端口
input 				RST_N;					//复位的端口,低电平复位
input		[15:0]	DATA_IN;					//VGA输入数据端口
input 				CACHE_RD_EN;
output 				VGA_VSYNC;					//VGA垂直同步端口
output 				VGA_HSYNC;					//VGA水平同步端口			
output  	[15:0]	VGA_DATA;					//VGA数据端口
output				CACHE_RREQ ;
output				CACHE_RCLK ;
output 				VGA_CLK;



wire clk_40m;

pll	pll_inst (
	.inclk0 ( SYS_CLK),
	.c0 ( clk_40m )
	);
	
	
assign VGA_CLK = clk_40m ;



VGA VGA_inst1
(
	//输入端口
	.CLK_40M(clk_40m),
	.RST_N(RST_N),
	.DATA_IN(),
	.CACHE_RD_EN(1'B1),
	//输出端口
	.VSYNC(VGA_VSYNC),
	.HSYNC(VGA_HSYNC),
	.DATA_OUT(VGA_DATA),
	.CACHE_RREQ(),
	.CACHE_RCLK()
);


endmodule
