module SR04_TOP
(
	//输入
	CLK,RST_N,KEY,ECHO,
	//输出
	SEL,DUAN,TRIG
);
//-----------------------------------------------------
//	--	外部信号
//-----------------------------------------------------
input CLK;
input RST_N;
input KEY;
input ECHO;

output TRIG;
output [2:0] SEL;
output [7:0] DUAN;

//-----------------------------------------------------
//	--	内部信号
//-----------------------------------------------------
wire [15:0] distance ;
wire CLK_1M,CLK_1K;

CLK_DIV_EVEN #(
	//偶分频系数=输入/输出/2
	.N(10)
)DIV1
(
	//输入
	.CLK(CLK),
	.RST_N(RST_N),
	//输出
	.CLK_OUT(CLK_1M)
);

CLK_DIV_EVEN #(
	//偶分频系数=输入/输出/2
	.N(10) 
)DIV2
(
	//输入
	.CLK(CLK),
	.RST_N(RST_N),
	//输出
	.CLK_OUT(CLK_1K)
);

SMG SMG1(
	//输入
	.CLK(CLK_1K),
	.RST_N(RST_N),
	.DATA(distance),
	//输出
	.SEL(SEL),
	.DUAN(DUAN)
	
);

SR04 SR04_U1(
	//输入
	.CLK(CLK_1M),
	.RST_N(RST_N),
	.START(KEY),
	.ECHO(ECHO),
	//输出
	.TRIG(TRIG),
	.DISTANCE(distance)
	
);

endmodule



