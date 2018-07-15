module UART_Txd(
input						SYS_CLK	,					//输入系统时钟
input 						RST_N	,					//复位
input			[7:0] 		data_in	,					//写入数据
input 						tx_req	,					//发送请求
	
output	reg					Txd		,					//发送引脚
output	reg					tx_busy						//发送模块忙,锁存数据后输出高
);

//------------------------------------------------------
//-- 内部端口
//------------------------------------------------------

reg 	[15:0] 	baud_count			;				//波特率计数器
reg 	[3:0] 	bit_cnt				;				//发送位计数
reg 	[7:0]	step_cnt			;				//步骤计数器
		
reg 	[1:0] 	STATE				;				//发送器的状态
reg 	[1:0] 	STATE_n				;				//发送器的状态
		
reg		[7:0]	tx_data 			;				//TX脚将要发送的数据寄存器

//------------------------------------------------------
//-- 参数定义
//------------------------------------------------------
`define BAUD  256000 														//波特率
`define SYS_CLK_PERIOD  50 													//SYS_CLK时钟周期
`define BAUD_CNT_END  1_000_000_000 / `BAUD / `SYS_CLK_PERIOD 				//波特率计数值
localparam IDLE = 2'D0 ,SEND = 2'D1 ;							

//------------------------------------------------------
//-- 波特率发生器
//------------------------------------------------------
always@(posedge SYS_CLK or negedge RST_N) begin
	if(!RST_N) begin
		baud_count <= 16'b0;
	end
	else if(STATE == SEND ) begin
		if(baud_count == `BAUD_CNT_END ) begin
			baud_count <= 16'b0 ;
		end
		else begin
			baud_count <= baud_count + 1'b1 ;
		end
	end
	else begin
		baud_count <= 16'b0;
	end
end
//------------------------------------------------------
//-- BIT位计数
//------------------------------------------------------
always@(posedge SYS_CLK or negedge RST_N) begin
	if(!RST_N) begin
		bit_cnt <= 'b0;
	end
	else if(STATE == SEND) begin
		if(baud_count == `BAUD_CNT_END)
			bit_cnt <= bit_cnt + 1'b1 ;
	end
	else
		bit_cnt <= 'b0;
end

//------------------------------------------------------
//-- 状态转换
//------------------------------------------------------
always@(posedge SYS_CLK or negedge RST_N)
begin
	if(!RST_N) begin
		STATE <= IDLE ;
	end
	else begin
		STATE <= STATE_n ;
	end
end
//------------------------------------------------------
//-- 状态判断
//------------------------------------------------------
always@(*)
begin
	case(STATE)
		IDLE : begin
			if(tx_req == 1'b1) begin
				STATE_n = SEND ;
				tx_data = data_in ;
			end
			else begin
				STATE_n = IDLE;
			end 
		end
		SEND : begin
			if(bit_cnt == 4'd10) begin
				STATE_n = IDLE ;
			end
		end
		default :
			STATE_n = IDLE;
	endcase
end


//------------------------------------------------------
//-- Txd发送信号
//------------------------------------------------------
always@(posedge SYS_CLK or negedge RST_N)
begin
	if(!RST_N) begin
		Txd <= 1'B1 ;
		tx_busy <= 1'b0 ;
	end
	else begin
		case(STATE_n)
			IDLE : begin
				Txd <= 1'B1 ;
				tx_busy <= 1'b0 ;
			end
			SEND : begin
				tx_busy <= 1'b1 ;
				case(bit_cnt)
					0 : begin
						Txd <= 1'B0 ;
					end
					1 : begin
						Txd <= tx_data[0];
					end
					2 : begin
						Txd <= tx_data[1];
					end
					3 : begin
						Txd <= tx_data[2];
					end
					4 : begin
						Txd <= tx_data[3];
					end 
					5 : begin
						Txd <= tx_data[4];
					end
					6 : begin
						Txd <= tx_data[5];
					end
					7 : begin
						Txd <= tx_data[6];
					end
					8 : begin
						Txd <= tx_data[7];
					end
					9 ,10: begin							//停止位
						Txd <= 1'B1 ;
					end
					default :
						Txd <= 1'B1 ;
				endcase
			end
			default :
				Txd <= 1'B1 ;
		endcase
	end
end



endmodule
