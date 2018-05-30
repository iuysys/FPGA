module CLK_DIV_ODD #(
	//奇分频系数= ((输入/输出)-1)/2
	parameter N = 2 
)
(
	//输入
	CLK,RST_N,
	//输出
	CLK_OUT
);

//--------------------------------------------------------
//-- 外部信号
//--------------------------------------------------------
input CLK;
input RST_N;
output CLK_OUT;


//--------------------------------------------------------
//-- 内部信号
//--------------------------------------------------------

reg 				clk_A;			//时钟信号A
reg 				clk_B;			//时钟信号B

reg 	[15:0] 	count ;			//计数器
//--------------------------------------------------------
//-- 计数
//--------------------------------------------------------
always@(posedge CLK or negedge RST_N)
begin
	if(!RST_N)
		count <= 16'b0;
	else if(count == (N << 1))
		count <= 16'b0;
	else
		count <= count + 1'b1 ;
end
//--------------------------------------------------------
//-- A时钟
//--------------------------------------------------------
always@(posedge CLK or negedge RST_N)
begin
	if(!RST_N)
		clk_A <= 1'b0;
	else if(count == N - 1)
		clk_A <= ~clk_A ;
	else if(count == (N << 1))
		clk_A <= ~clk_A ;
end
//--------------------------------------------------------
//-- B时钟
//--------------------------------------------------------
always@(negedge CLK or negedge RST_N)
begin
	if(!RST_N)
		clk_B <= 1'b0;
	else if(count == N - 1)
		clk_B <= ~clk_B ;
	else if(count == (N << 1))
		clk_B <= ~clk_B ;
end
//--------------------------------------------------------
//-- 输出奇分频时钟
//--------------------------------------------------------
assign CLK_OUT = clk_A & clk_B ;

endmodule



















