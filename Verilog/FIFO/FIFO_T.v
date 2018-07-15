module FIFO_T(
	//输入
	CLK,RST_N,WRREQ,RDREQ,
	//输出
	DATA_OUT,EMPTY,FULL
);
//-------------------------------------
//-- 
//-------------------------------------
input CLK;
input RST_N;
input RDREQ;
input WRREQ;

output [7:0] DATA_OUT;
output EMPTY;
output FULL;

//-------------------------------------
//-- 
//-------------------------------------



//wire EMPTY;
//wire FULL;

reg [7:0] test_n;
wire [7:0] test;

always@(posedge CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		test_n <= 8'b0;
	end
	else if(test_n == 7)
	begin
		test_n <= 8'b0 ;
	end
	else
	begin
		test_n <= test_n + 1'b1;
	end
end

assign test = test_n;

FIFO_IP	FIFO_IP_inst (
	.clock ( CLK ),
	.data ( test ),
	.rdreq ( RDREQ ),
	.wrreq ( WRREQ),
	.empty ( EMPTY ),
	.full ( FULL ),
	.q ( DATA_OUT )
	);

endmodule
