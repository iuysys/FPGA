module test_pll(
	input clk,
	output led1,
	output led2,
	output led4
);

pll	pll_inst (
	.inclk0 ( clk ),
	.c0 ( led1 ),
	.c1 ( led2 )
	);
	
endmodule