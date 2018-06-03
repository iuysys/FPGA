module CLK_DIV_EVEN #(
	//偶分频系数=输入/输出/2
	parameter N = 10 
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

reg CLK_OUT;
//--------------------------------------------------------
//-- 内部信号
//--------------------------------------------------------
reg [15:0] count;

//--------------------------------------------------------
//-- 计数
//--------------------------------------------------------
always@(posedge CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		count <= 16'b0;
	end
	else if(count == (N - 1))
	begin
		count <= 16'b0;
	end
	else
		count <= count + 1'b1 ;
end
//--------------------------------------------------------
//-- 时钟输出
//--------------------------------------------------------
always@(posedge CLK or negedge RST_N)
begin
	if(!RST_N)
		CLK_OUT <= 1'b0;
	else if(count == (N - 1) )
		CLK_OUT <= ~ CLK_OUT ;
	
end

endmodule











