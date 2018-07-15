

module clk_div_1
#(
	parameter CLK_IN = 20000000,			//???????
	parameter CLOCK_OUT = 1				//LCD????
)
(
	input clk,
	output clk_div
);


//parameter CLK_IN = 20000000;			//???????
//parameter CLOCK_OUT = 1;				//LCD????

reg [31:0] CLK_COUNT =(CLK_IN/CLOCK_OUT/2);		//?????
reg [31:0] count;
reg clktemp;
always@(posedge clk)
begin
	if(count >= CLK_COUNT)
	begin
		count <= 32'b0;
		clktemp <= !clktemp;
	end
	else
		count <= count + 1'b1;
end
assign clk_div = clktemp ;	

endmodule