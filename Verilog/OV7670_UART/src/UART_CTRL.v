module UART_CTRL(
//system interface
input						SYS_CLK		,					//输入系统时钟
input 						RST_N		,					//复位
//FIFO interface
input			[15:0]		data_in 	,
input						rd_empty	,
output						rd_clk		,
output	reg					rd_req		,
//other 
output	reg		[7:0]		data_out	,
output	reg					tx_req		,
input						tx_busy

);
//------------------------------------------------------
//-- 内部端口
//------------------------------------------------------
reg				[1:0]		state		;
reg				[1:0]		state_n		;
reg				[3:0]		step_cnt	;

reg				[15:0]		send_data	;
reg				[17:0]		send_cnt	;
reg							cmd_flag	;

//------------------------------------------------------
//-- 参数定义
//------------------------------------------------------

`define		IMAGE_SIZE 240*320
// `define		IMAGE_SIZE 176*144										//定义数据包大小
localparam UART_SEND_MODE = 8'h01 ;							//配合山外的调试助手,1:发送图像 2:CCD图像 3:波形
localparam	IDLE = 2'D0 ,LATCH = 2'D1 ,CMD = 2'D2 ,SEND = 2'D3 ;

//------------------------------------------------------
//-- 组合逻辑输出
//------------------------------------------------------
assign	rd_clk = ~SYS_CLK ;									//FIFO的读时钟

//------------------------------------------------------
//-- 时序逻辑,状态转换
//------------------------------------------------------
always@(posedge SYS_CLK or negedge RST_N) begin
	if(!RST_N) begin
		state <= IDLE ;
	end
	else begin
		state <= state_n ;
	end

end
//------------------------------------------------------
//-- 组合逻辑,次态判断
//------------------------------------------------------
always@(*) begin
	case(state)
		IDLE: begin
			if((!rd_empty && !rd_req )||(send_cnt == `IMAGE_SIZE)) begin					//fifo非空,但是fifo读请求被置低,则次态为发送指令状态
				state_n = CMD ;
			end
			else if(rd_req)begin							//fifo读请求置高,次态为锁存状态
				state_n = LATCH ;
			end
			else begin										
				state_n = IDLE ;
			end
		end
		LATCH: begin										//锁存数据后,判断发送模块是否空闲
			if(!tx_busy) begin
				state_n = SEND ;
			end
			else begin
				state_n = LATCH ;
			end
		end
		CMD: begin											//时序逻辑判断发送前或后指令,组合逻辑判断发送模块是否空闲
			if(!tx_busy) begin
				state_n = SEND ;
			end
			else begin
				state_n = CMD ;
			end
		end
		SEND: begin											
			if(step_cnt == 'd5) begin						//双字节发送结束后,回到空闲状态
				state_n = IDLE ;
			end
			else begin
				state_n = SEND ;
			end
		end
		default: begin
			state_n = IDLE ;
		end
	endcase

end
//------------------------------------------------------
//-- 时序逻辑,状态输出
//------------------------------------------------------
always@(posedge SYS_CLK or negedge RST_N) begin
	if(!RST_N) begin
		tx_req <= 1'b0 ;
		data_out <= 8'hff ; 
		step_cnt <= 'b0 ;
		send_cnt <= 'b0 ;
		cmd_flag <= 1'b0 ;
	end
	else begin
		case(state_n)
			IDLE: begin
				if(!rd_empty && cmd_flag != 'd0 && send_cnt != `IMAGE_SIZE) begin	//fifo为空,发前指令或者发后指令时,置低fifo读请求
					rd_req <= 1'b1 ;
				end
				else begin
					rd_req <= 1'b0 ;
				end
				step_cnt <= 'b0 ;
			end
			LATCH: begin
				rd_req <= 1'b0 ;
				send_cnt <= send_cnt + 1'b1 ;
				send_data <= data_in ;
			end
			CMD: begin
				if(send_cnt == 'd0) begin								//发送前命令
					send_data <= {~UART_SEND_MODE ,UART_SEND_MODE} ;
					// send_data <= 16'hfe01 ;
					cmd_flag <= 1'b1 ;
				end
				else begin												//发送后命令
					send_data <= {UART_SEND_MODE ,~UART_SEND_MODE} ;
					// send_data <= 16'h01fe ;
					send_cnt <= 'b0 ;
					cmd_flag <= 'b0 ;
				end
				
			end
			SEND: begin
				case(step_cnt)
					0: begin
						data_out <= send_data[7:0] ;
						step_cnt <= step_cnt + 1'b1 ;
						tx_req <= 1'b1 ;
					end
					1: begin
						if(tx_busy) begin
							step_cnt <= step_cnt + 1'b1 ;
							data_out <= send_data[15:8] ;
						end	
					end
					2: begin
						if(!tx_busy) begin
							step_cnt <= step_cnt + 1'b1 ;
						end	
					end
					3: begin
						if(tx_busy) begin
							step_cnt <= step_cnt + 1'b1 ;
							tx_req <= 1'b0 ;
						end	
					end
					4: begin
						if(!tx_busy) begin
							step_cnt <= step_cnt + 1'b1 ;
						end	
					end
				endcase
			end
			default: begin
				rd_req <= 1'b0 ;
				tx_req <= 1'b0 ;
				data_out <= 8'hff ; 
				step_cnt <= 'b0 ;
			end
		endcase
	end
end





endmodule


