module CLK_DIV_EVEN (
input 				CLK_IN			,
input 				RST_N			,
                                    
output 	reg			CLK_DIV			
);



//--------------------------------------------------------
//-- 内部信号
//--------------------------------------------------------
reg [5:0] count;
//--------------------------------------------------------
//-- 参数定义
//--------------------------------------------------------
localparam N = 50 ;			//N=输入/输出/2

//--------------------------------------------------------
//-- 计数
//--------------------------------------------------------
always@(posedge CLK_IN or negedge RST_N)
begin
	if(!RST_N)
	begin
		count <= 'b0;
		CLK_DIV <= 'b0 ;
	end
	else if(count == (N - 1))
	begin
		count <= 'b0;
		CLK_DIV <= ~ CLK_DIV ;
	end
	else
		count <= count + 1'b1 ;
end


endmodule











