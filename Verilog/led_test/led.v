
module led(
	input clk,
	output [3:0]led_out
);


clk_div 
	#(
		.CLK_IN(200),
		.CLOCK_OUT(2)
	) 
	div1_1
	(
	.clk(clk),
	.clk_div(led_out)
	);
	
clk_div 
	#(
		.CLK_IN(200),
		.CLOCK_OUT(2)
	) 
	div1_2
	(
	.clk(clk),
	.clk_div(led_out[1])
	);
	
clk_div 
	#(
		.CLK_IN(200),
		.CLOCK_OUT(4)
	) 
	div1_3
	(
	.clk(clk),
	.clk_div(led_out[2])
	);
	
	
clk_div 
	#(
		.CLK_IN(200),
		.CLOCK_OUT(8)
	) 
	div1_4
	(
	.clk(clk),
	.clk_div(led_out[3])
	);
	
endmodule