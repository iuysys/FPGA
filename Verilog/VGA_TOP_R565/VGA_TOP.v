module VGA_TOP(
	//输入
	CLK,RST_N,
	//输出端口
	VSYNC,HSYNC,DATA_OUT,CLK_OUT

);

//---------------------------------------------------------------------------
//--	外部端口声明
//---------------------------------------------------------------------------
input CLK;
input RST_N;

output VSYNC;
output HSYNC;
output [15:0] DATA_OUT ;
output CLK_OUT;
//output [15:0] a;

//---------------------------------------------------------------------------
//--	内部部端口声明
//---------------------------------------------------------------------------
wire CLK_40M;
wire [15:0] P_DATA;
wire [15:0] P_ADD;

//---------------------------------------------------------------------------
PLL_IP	PLL_IP_inst (
	.inclk0 ( CLK ),
	.c0 ( CLK_40M )
	);
assign CLK_OUT = CLK_40M ;
//---------------------------------------------------------------------------
VGA VGA_inst
(
	//输入端口
	.CLK_40M(CLK_40M),
	.RST_N(RST_N),
	.DATA_IN(P_DATA),
	//输出端口
	.VSYNC(VSYNC),
	.HSYNC(HSYNC),
	.ADDRESS(P_ADD),
	.DATA_OUT(DATA_OUT)
);
//---------------------------------------------------------------------------
ROM_IP	ROM_IP_inst (
	.address ( P_ADD ),
	.clock ( CLK_40M ),
	.q ( P_DATA )
	);
	
//assign a = P_ADD;
	
endmodule
