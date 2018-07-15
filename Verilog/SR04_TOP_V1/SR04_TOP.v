
module SR04_TOP(
	input clk,
	input RST_N,
	input key,
	output trig,
	input echo,
//	output [2:0] smg_sel,
//	output [7:0] smg_data,
	output 	[15:0] distance
);

//wire [15:0] distance;
wire clk_1M;

//clk_div 
//#(
//	.CLK_IN (20_000_000),			//接入的时钟频率
//	.CLK_OUT (1_000_000)				//LCD工作频率
//)
//clk1
//(
//	.clk(clk),
//	.clk_div(clk_1M)
//);

//
//clk_div 
//#(
//	.CLK_IN (20_000_000),			//接入的时钟频率
//	.CLK_OUT (1000)				//LCD工作频率
//)
//clk2
//(
//	.clk(clk),
//	.clk_div(clk_1k)
//);


SR04 u1_SR04(
	.CLK(clk),
	.RST_N(RST_N),
	.START(key),
	.TRIG(trig),
	.ECHO(echo),
	.distance(distance)
);

//u16_smg u16_smg1(
//	.clk(clk_1k),
//	.data(distance),
//	.smg_sel(smg_sel),
//	.smg_duan(smg_data)
//);

endmodule