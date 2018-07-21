module CLK_DIV_EVEN (
input 				CLK_IN			,
input 				RST_N			,
                                    
output 	reg			CLK_DIV			
);



//--------------------------------------------------------
//-- 内部信号
//--------------------------------------------------------
reg [3:0] count;
//--------------------------------------------------------
//-- 参数定义
//--------------------------------------------------------
localparam N = 5 ;			//N=输入/输出/2

//--------------------------------------------------------
//-- 计数
//--------------------------------------------------------
always@(posedge CLK_IN or negedge RST_N)
begin
	if(!RST_N)
	begin
		count <= 4'b0;
	end
	else if(count == (N - 1))
	begin
		count <= 4'b0;
	end
	else
		count <= count + 1'b1 ;
end
//--------------------------------------------------------
//-- 时钟输出
//--------------------------------------------------------
always@(posedge CLK_IN or negedge RST_N)
begin
	if(!RST_N)
		CLK_DIV <= 1'b0;
	else if(count == (N - 1) )
		CLK_DIV <= ~ CLK_DIV ;
	
end

endmodule











