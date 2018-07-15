module OV7670_VGA
(
	//input 
	CLK,RST_N,OV_DATA_IN,OV_VSYNC,
	//output
	SDA,SCL,OV_WRST,OV_RRST,OV_RCLK,OV_WEN,VGA_CLK,HSYNC,VSYNC,VGA_DATA
);
//-------------------------------------------------------
//-- 
//-------------------------------------------------------
input CLK ;
input RST_N ;
input [7:0] OV_DATA_IN ;
input OV_VSYNC ;
//input [3:0] OV_CONF ;					//OV配置控制信号



output SDA ;
output SCL ;
output OV_WRST ;
output OV_RRST ;
output OV_RCLK ;
output OV_WEN  ;


output VGA_CLK ;
output [15:0] VGA_DATA ;
output HSYNC ;
output VSYNC ;
//-------------------------------------------------------
//-- 
//-------------------------------------------------------
wire CLK_80M ;
wire CLK_40M ;

wire fifo_vga_data;
wire fifo_enpty_sig ;
wire vga_read_sig ;

//-------------------------------------------------------
//-- 
//-------------------------------------------------------


//-------------------------------------------------------
//-- 
//-------------------------------------------------------
PLL_IP	PLL_IP_inst (
	.inclk0 ( CLK ),
	.c0 ( CLK_80M ),
	.c1 ( CLK_40M )
	);

OV7670 OV1
(
	//input 
	.CLK(CLK_80M),
	.RST_N(RST_N),
	.OV_DATA_IN(OV_DATA_IN),
	.OV_VSYNC(OV_VSYNC),
	.FIFO_RCLK(CLK_40M),
	.FIFO_RDREQ(vga_read_sig),
	//output
	.FIFO_DATA_OUT(fifo_vga_data),
	.SDA(SDA),
	.SCL(SCL),
	.OV_WRST(OV_WRST),
	.OV_RRST(OV_RRST),
	.OV_RCLK(OV_RCLK),
	.OV_WEN(OV_WEN),
	.FIFO_EMPTY(fifo_enpty_sig)
	//control signal input
//	OV_CONF,
	//control signal output
//	OV_READY
);

//-------------------------------------------------------
//-- 
//-------------------------------------------------------

//-------------------------------------------------------
//-- 
//-------------------------------------------------------
VGA VGA1
(
	//输入端口
	.CLK_40M(CLK_40M),
	.RST_N(RST_N),
	.DATA_IN(fifo_vga_data),
	//输出端口
	.VSYNC(VSYNC),
	.HSYNC(HSYNC),
	.ADDRESS(),
	.DATA_OUT(VGA_DATA),
	.EN(vga_read_sig)
);

assign VGA_CLK = CLK_40M ;




















endmodule
