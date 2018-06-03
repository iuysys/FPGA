module UART_RX
(
	//system input
	SYS_CLK,RST_N,RX,
	//system ouput
	D,RX_DONE
);
//-------------------------------------------------------
//-- 
//-------------------------------------------------------
input 							SYS_CLK;
input								RST_N;
input								RX;						

output	reg		[7:0]		D;							//接收字节数据
output 	reg 					RX_DONE;					//单字节接收完成信号


//-------------------------------------------------------
//-- 内部信号定义
//-------------------------------------------------------
reg 		[1:0]					STATE;
wire 								rx_start;				//起始信号
reg 								n_edge_now;				//当前RX状态
reg								n_edge_pre;				//前一个RX状态
reg 								collect_sig;			//信号采集标志
reg 		[3:0]					bit_cnt;					//位计数
reg 		[15:0]				baud_count;				//波特率计数器
//-------------------------------------------------------
//-- 常量定义
//-------------------------------------------------------
localparam IDLE = 2'D0,RECEIVE = 2'D1;											//状态机状态
localparam BAUD = 256000 ;															//波特率
localparam SYS_CLK_PERIOD = 50 ;													//系统时钟周期
localparam BAUD_CNT_END = 1_000_000_000 / BAUD / SYS_CLK_PERIOD ;		//波特率计数值


//-------------------------------------------------------
//-- RX起始信号检测
//-------------------------------------------------------
always @(posedge SYS_CLK or negedge RST_N )
begin
	if(!RST_N)
	begin
		n_edge_now <= 1'b0 ;
		n_edge_pre <= 1'b0 ;
	end
	else if(STATE == IDLE )
	begin
		n_edge_now <= RX ;
		n_edge_pre <= n_edge_now ;
	end
	else
	begin
		n_edge_now <= 1'b0 ;
		n_edge_pre <= 1'b0 ;
	end
end
//-- 组合逻辑输出
assign rx_start = ( n_edge_now == 1'b0 && n_edge_pre == 1'b1) ? 1'b1 : 1'b0 ;
//-------------------------------------------------------
//-- 状态机
//-------------------------------------------------------
always @(posedge SYS_CLK or negedge RST_N )
begin
	if(!RST_N)
	begin
		STATE <= IDLE ;
	end
	else 
	begin
		case(STATE)
			IDLE :
			begin
				if(rx_start)
				begin
					STATE <= RECEIVE ;
				end
				else
				begin
					STATE <= IDLE ;
				end
			end
			RECEIVE :
			begin
				if(bit_cnt == 4'd10)
				begin
					STATE <= IDLE ;
				end
				else
				begin
					STATE <= RECEIVE ;
				end
			end
		endcase
	end
end
//------------------------------------------------------
//-- 波特率发生器
//------------------------------------------------------
always@(posedge SYS_CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		baud_count <= 16'b0 ;
		collect_sig <= 1'b0 ;
		bit_cnt <= 4'b0 ;
	end
	else if(STATE == RECEIVE )
	begin
		if(baud_count > BAUD_CNT_END )
		begin
			baud_count <= 16'b0 ;
		end
		else if(baud_count == (BAUD_CNT_END >> 1 ))
		begin
			collect_sig <= 1'b1 ;
			bit_cnt <= bit_cnt + 1'b1 ;
			baud_count <= baud_count + 1'b1 ;
		end
		else
		begin
			collect_sig <= 1'b0 ;
			baud_count <= baud_count + 1'b1 ;
		end
	end
	else 
	begin
		collect_sig <= 1'b0 ;
		baud_count <= 16'b0;
		bit_cnt <= 4'b0 ;
	end
end
//------------------------------------------------------
//-- 采值
//------------------------------------------------------
always@(posedge collect_sig or negedge RST_N)
begin
	if(!RST_N)
	begin
		D <= 8'b0 ;
		RX_DONE <= 1'B0 ;
	end
	else if(collect_sig)
	begin
		case(bit_cnt)
			2 :
				D[0] <= RX ;
			3 :
				D[1] <= RX ;
			4 :
				D[2] <= RX ;
			5 :
				D[3] <= RX ;
			6 :
				D[4] <= RX ;
			7 :
				D[5] <= RX ;
			8 :
				D[6] <= RX ;
			9 :
			begin
				D[7] <= RX ;
				RX_DONE <= 1'B1 ;
			end
			10 :
				RX_DONE <= 1'B0 ;
			default :
				RX_DONE <= 1'B0 ;
		endcase
	end
end
endmodule
