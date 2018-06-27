`timescale 1ns / 1ns
module SDRAM_WRITE(
input								S_CLK					,				//系统时钟
input								RST_N					,				//系统复位输入

output		reg						write_ack				,				//写结束应答
input								write_en				,				//仲裁模块输入的写使能信号
input								aref_req				,
output		reg						fifo_rd_req				,
input				[19:0]			sdram_addr				,
output		reg		[11:0]			write_addr				,
output		reg		[4:0]			write_cmd			
);
//--------------------------------------------------------
//--内部信号
//--------------------------------------------------------
reg			[2:0]					STATE 					;				//状态寄存器
reg			[2:0]					burst_cnt				;				//突发长度计数器
reg									flag_aref				;				//自刷新标志
reg									flag_next_row			;				//换行标志
reg									flag_wd_end				;				//写结束标志
reg			[11:0]					row_addr_cnt			;				//行地址计数
reg			[7:0]					col_addr_cnt			;				//列地址计数


//--------------------------------------------------------
//--参数定义
//--------------------------------------------------------
localparam		IDLE = 3'D0 ,ACT = 3'D1 ,WD = 3'D2 , PREC = 3'D3 ,WAIT = 3'D4; 
localparam		CMD_WRITE = 5'B10100 ,CMD_ACT = 5'B10011 ,CMD_PREC = 5'B10010,CMD_NOP = 5'B10111;

`define		BURST_LENGHT	4

//--------------------------------------------------------
//--写状态转换
//--------------------------------------------------------
always@(posedge S_CLK or negedge RST_N) begin
	if(!RST_N)	begin
		STATE <= IDLE ;
		// write_ack <= 1'b0 ;
		flag_aref <= 1'b0 ;
		flag_wd_end <= 1'b0 ;
		flag_next_row <= 1'b0 ;
		burst_cnt <= 'b0 ;
		row_addr_cnt <= 'b0 ;
		col_addr_cnt <= 'b0 ;
	end
	else begin
		case(STATE)
			IDLE :begin
				if(write_en) begin
					STATE <= ACT ;
					// write_ack <= 1'b0 ;
				end
				else begin
					STATE <= IDLE ;
				end
			end
			ACT :begin
				STATE <= WD ;
				
				if(flag_next_row) begin
					col_addr_cnt <= 'b0 ;
				end
				else if(flag_aref) begin
					col_addr_cnt <= col_addr_cnt ;
				end
				else begin
					row_addr_cnt <= sdram_addr[11:0] ;
					col_addr_cnt <= sdram_addr[19:12] ;
				end
				
			end
			WD :begin
				if(burst_cnt == `BURST_LENGHT - 1'b1 ) begin							//突发结束	
					if(~write_en) begin
						STATE <= IDLE ;
						flag_wd_end <= 1'b1 ;
					end
					else if(aref_req) begin										//自刷新
						flag_aref <= 1'b1 ;
						STATE <= WAIT ;
					end
					else if(col_addr_cnt == 256 - `BURST_LENGHT ) begin							//换行
						flag_next_row <= 1'b1 ;
						STATE <= WAIT;
					end
					else begin
						flag_aref <= 1'b0 ;
						flag_next_row <= 1'b0 ;
						flag_wd_end <= 1'b0 ;
						// write_ack <= 1'b0 ;
					end
					burst_cnt <= 'b0 ;
					// write_ack <= 1'b1 ;
					col_addr_cnt <= col_addr_cnt + `BURST_LENGHT ;
				end
				else begin
					STATE <= WD ;
					burst_cnt <= burst_cnt + 1'b1 ;
					flag_aref <= 1'b0 ;
					flag_next_row <= 1'b0 ;
					flag_wd_end <= 1'b0 ;
					// write_ack <= 1'b0 ;
				end		
			end
			PREC :begin
				if(flag_aref || flag_wd_end) begin
					STATE <= IDLE ;
				end
				else if(flag_next_row) begin
					STATE <= ACT ;
					row_addr_cnt <= row_addr_cnt + 1'b1 ;
				end
			end
			WAIT :begin
				STATE <= PREC ;
			end
			default :begin
				STATE <= IDLE ;
			end
		endcase
	end
end
//--------------------------------------------------------
//--写状态输出
//--------------------------------------------------------
always@(*) begin
	case(STATE)
		IDLE :begin
			
			write_ack <= 1'b0 ;
			fifo_rd_req <= 1'b0 ;
			write_cmd <= CMD_NOP ;
			write_addr <= 12'b0100_0000_0000;
						
		end
		ACT :begin
			if(flag_aref ) begin			//
				write_cmd <= CMD_ACT ;
				write_addr <= row_addr_cnt ;
			end
			else if(flag_next_row) begin
				write_cmd <= CMD_ACT ;
				write_addr <= row_addr_cnt  ;
			end
			else begin
				write_cmd <= CMD_ACT ;
				write_addr <= sdram_addr[11:0] ;
			end
			burst_cnt <= 'b0 ;
			fifo_rd_req <= 1'b1 ;
		end
		WD :begin
			case(burst_cnt)
				0 :begin
					write_cmd <= CMD_WRITE ;
					write_addr <= col_addr_cnt;
				end
				1,2,3:begin
					write_cmd <= CMD_NOP ;
					write_addr <= 12'b0100_0000_0000;
				end
				
				default :begin
					
				end
			endcase
			
			if(burst_cnt > 2) begin
				write_ack <= 1'b1 ;
				fifo_rd_req <= 1'b0 ;
			end
			else begin
				write_ack <= 1'b0 ;
				fifo_rd_req <= 1'b1 ;
			end
		end
		PREC :begin
			write_cmd <= CMD_PREC ;

			write_addr <= 12'b0100_0000_0000;
		end
		WAIT :begin
			write_cmd <= CMD_NOP ;
			write_addr <= 12'b0100_0000_0000;
		end
		default :begin	
			STATE <= IDLE ;
		end
	endcase
end
	
endmodule