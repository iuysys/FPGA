module UART_Rxd_CTRL(
input 							SYS_CLK			,
input							RST_N			,

input		[7:0]				rx_data_in		,
input							rx_busy			,


output		reg					w_req			,
output							w_clk			,			
output		reg		[15:0]		rx_data_out			

);


//-------------------------------------------------------
//-- 
//-------------------------------------------------------
reg								rx_busy_edge_now	;
reg								rx_busy_edge_pre	;

wire							flag_receive_data	;
reg								bit_flag			;

//-------------------------------------------------------
//-- 
//-------------------------------------------------------
assign	w_clk = ~SYS_CLK ;


//-------------------------------------------------------
//-- 捕获rx_busy的下降沿
//-------------------------------------------------------
always@(posedge SYS_CLK or negedge RST_N) begin
	if(!RST_N) begin
		rx_busy_edge_now <= 1'b0 ;
		rx_busy_edge_pre <= 1'b0 ;
	end
	else begin
		rx_busy_edge_now <= rx_busy ;
		rx_busy_edge_pre <= rx_busy_edge_now ;
	end

end

assign	flag_receive_data = (rx_busy_edge_now == 1'b0 && rx_busy_edge_pre == 1'b1) ? 1'b1 : 1'b0 ;
//-------------------------------------------------------
//-- 组合数据并输出
//-------------------------------------------------------
always@(posedge SYS_CLK or negedge RST_N) begin
	if(!RST_N) begin
		w_req <= 1'b0 ;
		rx_data_out <= 'b0 ;
	end
	else if(flag_receive_data) begin
		if(!bit_flag) begin
			bit_flag <= ~ bit_flag ;
			rx_data_out[7:0] <= rx_data_in ; 		//锁存低位数据
		end
		else begin
			bit_flag <= ~bit_flag ;
			w_req <= 'b1 ;							
			rx_data_out[15:8] <= rx_data_in ;		//锁存低位数据
		end
	end
	else begin
		w_req <= 1'b0 ;
	end

end


endmodule



















































