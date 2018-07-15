module VGA_PHOTO_TOP
(
	//输入端口
	CLK,RST_N,
	//输出端口
	VGA_HSYNC,VGA_VSYNC,VGA_DATA
);

//---------------------------------------------------------------------------
//--	外部端口声明
//---------------------------------------------------------------------------
input CLK;
input RST_N;
output 				VGA_HSYNC;
output 				VGA_VSYNC;
output	[7:0]		VGA_DATA;
//---------------------------------------------------------------------------
//--	内部端口声明
//---------------------------------------------------------------------------
wire					CLK_40M;
wire [15:0]x,y;
wire [7:0] data;

PLL_mod	PLL_mod_inst (
	.inclk0 ( CLK ),
	.c0 ( CLK_40M )
	);
	
	
vga_driver vga_d1
(
	//输入端口
	.CLK_40M(CLK_40M),
	.RST_N(RST_N),
	.VGA_DATA_IN(),
	.VGA_X(),
	.VGA_Y(),
	//输出端口
	.VSYNC(VGA_VSYNC),
	.HSYNC(VGA_HSYNC),
	.VGA_DATA_OUT(VGA_DATA)
);	



vga_control vga_c1
(
	.CLK(CLK_40M),
	.RST_N(RST_N),
	.DATA_OUT(),
	.VGA_X(),
	.VGA_Y()
);

ROM_MOD	ROM_MOD_inst (
	.address ( address_sig ),
	.clock ( CLK_40M ),
	.q ( q_sig )
	);

endmodule
