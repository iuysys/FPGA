module UART_RX_TOP
(
	//system input
	SYS_CLK,RST_N,RX,RD_REQ,RD_CLK,
	//system output
	EMPTY_SIG,D
);
//-------------------------------------------------------
//-- 
//-------------------------------------------------------
input 								SYS_CLK;
input									RST_N;
input									RX;
input									RD_REQ;					//读缓存区请求
input									RD_CLK;					//读缓存区时钟

output								EMPTY_SIG;				//缓存区空标志
output				[7:0]			D;							//fifo输出数据
//-------------------------------------------------------
//-- 
//-------------------------------------------------------
reg					[1:0]			STATE;					//状态机寄存器
wire 									rx_done;					//接收模块接收完单字节信号
wire 									receive;
reg									p_edge_now;
reg									p_edge_pre;
reg 					[1:0]			step_cnt ;
reg 									wr_req ;					//缓存区写请求
wire 									wr_clk ;					//缓存区写时钟
wire									wr_full ;				//缓存区满信号
wire 					[7:0]			rx_data;					//接收模块接收的数据
//-------------------------------------------------------
//-- 
//-------------------------------------------------------
localparam IDLE = 2'B0 ,WRITE = 2'B1 ;					//空闲状态,写缓存区状态


//-------------------------------------------------------
//-- 
//-------------------------------------------------------
always @(negedge SYS_CLK or negedge RST_N )
begin
	if(!RST_N)
	begin
		p_edge_now <= 1'b0 ;
		p_edge_pre <= 1'b0 ;
	end
	else
	begin
		p_edge_now <= rx_done ;
		p_edge_pre <= p_edge_now ;
	end
end
//-- 组合逻辑输出
assign receive = ( p_edge_now == 1'b1 && p_edge_pre == 1'b0) ? 1'b1 : 1'b0 ;
//-------------------------------------------------------
//-- 
//-------------------------------------------------------
always @(posedge SYS_CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		STATE <= IDLE ;
		step_cnt <= 2'b0 ;
		wr_req <= 1'b0 ;
	end
	else
	begin
		case(STATE)
			IDLE :
			begin
				if(receive)
				begin
					STATE <= WRITE ;
				end
				else
				begin
					STATE <= IDLE ;
				end
			end
			WRITE :
			begin
				case(step_cnt)
					0 :
					begin
						if(!wr_full)
						begin
							wr_req <= 1'b1 ;
							step_cnt <= step_cnt + 1'b1 ;
						end
					end
					1 :
					begin
						wr_req <= 1'b0 ;
						step_cnt <= 2'b0 ;
						STATE <= IDLE ;
					end
				endcase
			end
		endcase
	
	end
end
assign wr_clk = (wr_req == 1'b1) ? ~SYS_CLK : 1'b1 ;
//-------------------------------------------------------
//-- 
//-------------------------------------------------------
UART_RX UART_RX_inst1
(
	//system input
	.SYS_CLK(SYS_CLK),
	.RST_N(RST_N),
	.RX(RX),
	//system ouput
	.D(rx_data),
	.RX_DONE(rx_done)
);
//-------------------------------------------------------
//-- 
//-------------------------------------------------------
UART_RX_FIFO	UART_RX_FIFO_inst (
	.data ( rx_data ),
	.rdclk ( RD_CLK ),
	.rdreq ( RD_REQ ),
	.wrclk ( wr_clk ),
	.wrreq ( wr_req ),
	.q ( D ),
	.rdempty ( EMPTY_SIG ),
	.wrfull ( wr_full )
	);





endmodule
