`timescale 1ns / 1ns
`timescale 1ns / 1ns
module SDRAM_READ(
input								S_CLK					,				//系统时钟
input								RST_N					,				//系统复位输入

output		reg						read_ack				,				//读结束应答
input								read_en					,				//仲裁模块输入的读使能信号
output		reg						fifo_wd_req				,
input				[19:0]			sdram_addr				,
output		reg		[11:0]			read_addr				,
output		reg		[4:0]			read_cmd			
);
//--------------------------------------------------------
//--内部信号
//--------------------------------------------------------
reg			[2:0]					STATE 					;				//状态寄存器
reg			[2:0]					STATE_n 				;				//次状态寄存器
reg			[2:0]					burst_cnt				;				//突发长度计数器
reg			[2:0]					cas_cnt					;				//潜伏期计数
reg			[2:0]					step_cnt				;

//--------------------------------------------------------
//--参数定义
//--------------------------------------------------------
localparam		IDLE = 3'D0 ,ACT = 3'D1 ,RD = 3'D2 , PREC = 3'D3 ,CAS = 3'D4; 
localparam		CMD_READ = 5'B10101 ,CMD_ACT = 5'B10011 ,CMD_PREC = 5'B10010,CMD_NOP = 5'B10111;

`define		BURST_LENGHT	4
`define 	CAS_LATENCY		2

//状态转换
always@(posedge S_CLK or negedge RST_N) begin
	if(!RST_N) begin
		STATE <= IDLE ;
	end
	else begin
		STATE <= STATE_n ;
	end
end
//--------------------------------------------------------
//--
//--------------------------------------------------------
always@(*) begin
	case(STATE)
		IDLE :begin
			if(read_en) begin
				STATE_n = PREC ;
			end
			else begin
				STATE_n = IDLE ;
			end
		end
		PREC :begin
			if (step_cnt == 'd2) begin
				STATE_n = ACT ;
			end
			else begin
				STATE_n = PREC ;
			end
			
		end
		ACT :begin
			if (step_cnt == 'd4) begin
				STATE_n = CAS ;
			end
			else begin
				STATE_n = ACT ;
			end
		end
		CAS :begin
			if(cas_cnt == `CAS_LATENCY) begin
				STATE_n = RD ;
			end
			else begin
				STATE_n = CAS ;
			end
		end
		RD :begin
			if(burst_cnt == `BURST_LENGHT  ) begin							//突发结束	
				STATE_n = IDLE ;
			end
			else begin
				STATE_n = RD ;
			end		
		end
		default :begin
			STATE_n = IDLE ;
		end
	endcase
end
//--------------------------------------------------------
//--读状态输出
//--------------------------------------------------------
always@(posedge S_CLK or negedge RST_N) begin
	case(STATE_n)
		IDLE :begin
			
			read_ack <= 1'b0 ;
			fifo_wd_req <= 1'b0 ;
			read_cmd <= CMD_NOP ;
			read_addr <= 12'b0100_0000_0000;
			burst_cnt <= 'b0 ;	
			cas_cnt <= 'b0 ;
			step_cnt <= 'b0 ;
		end
		ACT :begin
			if (step_cnt == 'd2) begin
				read_cmd <= CMD_ACT ;
				read_addr <= sdram_addr[11:0] ;
			end
			else begin
				read_cmd <= CMD_NOP ;
				read_addr <= 12'b0100_0000_0000;
			end
			step_cnt <= step_cnt + 1'b1 ;
			
		end
		CAS :begin
			cas_cnt <= cas_cnt + 1'b1 ;
			case(cas_cnt)
				0: begin
					read_cmd <= CMD_READ ;
					read_addr <= sdram_addr[19:12];
				end
				default: begin
					read_cmd <= CMD_NOP ;
					read_addr <= 12'b0100_0000_0000;
				end
			endcase
		end
		RD :begin
			case(burst_cnt)
				0:begin
					fifo_wd_req <= 1'b1 ;
				end
				3:begin
					fifo_wd_req <= 1'b0 ;
				end
				
				default :begin
					read_cmd <= CMD_NOP ;
					read_addr <= 12'b0100_0000_0000;
				end
			endcase
			
			burst_cnt <= burst_cnt + 1'b1 ;
			
			if(burst_cnt == `BURST_LENGHT - 1'b1) begin
				read_ack <= 1'b1 ;
			end
		end
		PREC :begin
			if (step_cnt == 'd0) begin
				read_cmd <= CMD_PREC ;
				read_addr <= 12'b0100_0000_0000;
			end
			else begin
				read_cmd <= CMD_NOP ;
				read_addr <= 12'b0100_0000_0000;
			end
			step_cnt <= step_cnt + 1'b1 ;
		end
		default :begin	
			STATE <= IDLE ;
		end
	endcase
end
	
endmodule