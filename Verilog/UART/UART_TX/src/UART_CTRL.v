module UART_CTRL(
input						SYS_CLK		,					//输入系统时钟
input 						RST_N		,					//复位

input			[15:0]		data_in 	,
input						rd_empty	,
output						rd_clk		,
output	reg					rd_req		,

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
reg				[15:0]		latch_data	;

//------------------------------------------------------
//-- 参数定义
//------------------------------------------------------
localparam	IDLE = 2'D0 ,LATCH = 2'D1 ,SEND = 2'D2 ;


assign	rd_clk = ~SYS_CLK ;







//------------------------------------------------------
//-- 
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
//-- 
//------------------------------------------------------
always@(*) begin
	case(state)
		IDLE: begin
			if(!rd_empty && rd_req ) begin
				state_n = LATCH ;
			end
			else begin
				state_n = IDLE ;
			end
			step_cnt = 'b0 ;
		end
		LATCH: begin
			if(!tx_busy) begin
				state_n = SEND ;
			end
		end
		SEND: begin
			if(step_cnt == 'd5) begin
				state_n = IDLE ;
			end
		end
		default: begin
			state_n = IDLE ;
		end
	endcase

end
//------------------------------------------------------
//-- 
//------------------------------------------------------
always@(posedge SYS_CLK or negedge RST_N) begin
	case(state_n)
		IDLE: begin
			if(!rd_empty) begin
				rd_req = 1'b1 ;
			end
			else begin
				rd_req = 1'b0 ;
			end
			tx_req = 1'b0 ;
		end
		LATCH: begin
			latch_data = data_in ;
			rd_req = 1'b0 ;
		end
		SEND: begin
			case(step_cnt)
				0: begin
					data_out <= latch_data[7:0] ;
					step_cnt <= step_cnt + 1'b1 ;
					tx_req <= 1'b1 ;
				end
				1: begin
					if(tx_busy) begin
						step_cnt <= step_cnt + 1'b1 ;
					end	
				end
				2: begin
					if(!tx_busy) begin
						data_out <= latch_data[15:8] ;
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
	
	
	endcase

end


























endmodule