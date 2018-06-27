`timescale 1ns / 1ns
module SDRAM_READ(
input								S_CLK					,				//系统时钟
input								RST_N					,				//系统复位输入

output		reg						read_ack				,				//读结束应答
input								read_en					,				//仲裁模块输入的读使能信号
input								aref_req				,
output		reg						fifo_wd_req				,
input				[19:0]			sdram_addr				,
output		reg		[11:0]			read_addr				,
output		reg		[4:0]			read_cmd				
);
//--------------------------------------------------------
//--内部信号
//--------------------------------------------------------
reg			[2:0]					STATE 					;				//状态寄存器
reg			[2:0]					burst_cnt				;				//突发长度计数器
reg									flag_aref				;				//自刷新标志
reg									flag_next_row			;				//换行标志
reg									flag_rd_end				;				//读结束标志
reg			[11:0]					row_addr_cnt			;				//行地址计数
reg			[7:0]					col_addr_cnt			;				//列地址计数
reg			[1:0]					cas_cnt					;				//潜伏期计数


//--------------------------------------------------------
//--参数定义
//--------------------------------------------------------
localparam		IDLE = 3'D0 ,ACT = 3'D1 ,RD = 3'D2 , PREC = 3'D3 ,WAIT = 3'D4,CAS = 3'D5 ; 
localparam		CMD_READ = 5'B10101 ,CMD_ACT = 5'B10011 ,CMD_PREC = 5'B10010,CMD_NOP = 5'B10111 ;

`define		BURST_LENGHT	4		//突发长度
`define		CAS_Latency		2		//潜伏期

//--------------------------------------------------------
//--写状态转换
//--------------------------------------------------------
always@(posedge S_CLK or negedge RST_N) begin
	if(!RST_N)	begin
		STATE <= IDLE ;
		flag_aref <= 1'b0 ;
		flag_rd_end <= 1'b0 ;
		flag_next_row <= 1'b0 ;
		burst_cnt <= 'b0 ;
		row_addr_cnt <= 'b0 ;
		col_addr_cnt <= 'b0 ;
		cas_cnt <= 'b0 ;
	end
	else begin
		case(STATE)
			IDLE :begin
				if(read_en) begin
					STATE <= ACT ;
				end
				else begin
					STATE <= IDLE ;
				end
			end
			ACT :begin
				STATE <= CAS ;
				
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
			CAS :begin
				if(cas_cnt == `CAS_Latency - 1'b1) begin
					STATE <= RD ;
				end
				else begin
					cas_cnt <= cas_cnt + 1'b1 ;
				end
			end
			RD :begin
				if(burst_cnt == `BURST_LENGHT - `CAS_Latency - 1) begin					//突发至下一次潜伏期开始
					if(aref_req) begin													//自刷新
						flag_aref <= 1'b1 ;
						STATE <= WAIT ;
					end
					else if(col_addr_cnt == 256 - `BURST_LENGHT ) begin					//换行
						flag_next_row <= 1'b1 ;
						STATE <= WAIT;
					end
					else begin
						STATE <= CAS ;
						flag_aref <= 1'b0 ;
						flag_next_row <= 1'b0 ;
						flag_rd_end <= 1'b0 ;
					end
					burst_cnt <= 'b0 ;
					col_addr_cnt <= col_addr_cnt + `BURST_LENGHT ;
				end
				else begin
					STATE <= RD ;
					burst_cnt <= burst_cnt + 1'b1 ;
					flag_aref <= 1'b0 ;
					flag_next_row <= 1'b0 ;
					flag_rd_end <= 1'b0 ;
				end		
			end
			PREC :begin
				if(flag_aref || flag_rd_end) begin
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
			
			read_ack <= 1'b0 ;
			fifo_wd_req <= 1'b0 ;
			read_cmd <= CMD_NOP ;
			read_addr <= 12'b0100_0000_0000;
						
		end
		ACT :begin
			if(flag_aref ) begin			//
				read_cmd <= CMD_ACT ;
				read_addr <= row_addr_cnt ;
			end
			else if(flag_next_row) begin
				read_cmd <= CMD_ACT ;
				read_addr <= row_addr_cnt  ;
			end
			else begin
				read_cmd <= CMD_ACT ;
				read_addr <= sdram_addr[11:0] ;
			end
			burst_cnt <= 'b0 ;
			fifo_wd_req <= 1'b1 ;
		end
		CAS :begin
			case(cas_cnt)
				0 :begin
					read_cmd <= CMD_READ ;
					read_addr <= col_addr_cnt;
				end
				default : begin
					read_cmd <= CMD_NOP ;
					read_addr <= 12'b0100_0000_0000;
				end
			endcase
			if(cas_cnt == `CAS_Latency - 1) begin
				fifo_wd_req <= 1'b1 ;
			end
		end
		RD :begin
			case(burst_cnt)
				0 ,1,2,3:begin
					read_cmd <= CMD_NOP ;
					read_addr <= 12'b0100_0000_0000;
				end
				default :begin
					
				end
			endcase
			if(burst_cnt == `BURST_LENGHT - `CAS_Latency - 1'b1) begin
				read_ack <= 1'b1 ;
				fifo_wd_req <= 1'b0 ;
			end
			else begin
				read_ack <= 1'b0 ;
				fifo_wd_req <= 1'b1 ;
			end
			cas_cnt <= 'b0 ;
		end
		PREC :begin
			read_cmd <= CMD_PREC ;
			read_addr <= 12'b0100_0000_0000;
		end
		WAIT :begin
			read_cmd <= CMD_NOP ;
			read_addr <= 12'b0100_0000_0000;
		end
		default :begin	
			STATE <= IDLE ;
		end
	endcase
end
	
endmodule