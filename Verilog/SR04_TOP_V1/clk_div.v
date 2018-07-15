

module clk_div
#(
	parameter CLK_IN = 20000000,			//接入的时钟频率
	parameter CLK_OUT = 1000				//LCD工作频率
)
(
	input clk,
	output clk_div
);

reg [31:0] CLK_COUNT =(CLK_IN/CLK_OUT/2);		//分频计数值
reg [31:0] count=32'b0;
reg clktemp=1'b0;
always@(posedge clk)
begin
	if(count >= CLK_COUNT)
	begin
		count = 32'b0;
		clktemp = !clktemp;
	end
	else
		count = count + 1'b1;
end
assign clk_div = clktemp ;	

endmodule