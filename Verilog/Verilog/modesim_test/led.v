
module led(
	input clk,
	output wire [3:0]led_out
);

clk_div_1 
	#(
		.CLK_IN(200),
		.CLOCK_OUT(2)
	) 
	div1_1
	(
	.clk(clk),
	.clk_div(led_out[0])
	);



	
endmodule