module ROM_MOD(
	//输入
	CLK,ADD,
	//输出
	OUT_DATA
);

//--------------------------------------
//-- 
//--------------------------------------
input CLK;
input [13:0] ADD;
output [15:0] OUT_DATA;



ROM_IP	ROM_IP_inst (
	.address ( ADD ),
	.clock ( CLK),
	.q ( OUT_DATA )
	);

endmodule


