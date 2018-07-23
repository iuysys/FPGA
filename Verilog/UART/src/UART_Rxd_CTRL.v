module UART_Rxd_CTRL(
input 							SYS_CLK			,
input							RST_N			,

input							rx_busy			,


output		reg					w_req			,
output							w_clk			


);

//-------------------------------------------------------
//-- 
//-------------------------------------------------------
reg								rx_busy_edge_now	;
reg								rx_busy_edge_pre	;

wire							flag_receive_data	;

//-------------------------------------------------------
//-- 
//-------------------------------------------------------
assign	w_clk = ~SYS_CLK ;


//-------------------------------------------------------
//-- 
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
//-- 
//-------------------------------------------------------
always@(posedge SYS_CLK or negedge RST_N) begin
	if(!RST_N) begin
		w_req <= 1'b0 ;
	end
	else if(flag_receive_data && !w_req) begin
		w_req <= 1'b1 ;
	end
	else begin
		w_req <= 1'b0 ;
	end

end


endmodule



















































