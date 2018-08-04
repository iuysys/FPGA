`timescale 1ns / 1ns
module SDRAM_WRITE(
input								S_CLK					,				//系统时钟
input								RST_N					,				//系统复位输入

output		reg						write_ack				,				//写结束应答
input								write_en				,				//仲裁模块输入的写使能信号
// input								aref_req				,
output		reg						fifo_rd_req				,
input				[19:0]			sdram_addr				,
output		reg		[11:0]			write_addr				,
output		reg		[4:0]			write_cmd			
);
//--------------------------------------------------------
//--内部信号
//--------------------------------------------------------
reg			[2:0]					STATE 					;				//状态寄存器
reg			[2:0]					STATE_n 				;				//次状态寄存器
reg			[2:0]					burst_cnt				;				//突发长度计数器
reg			[2:0]					step_cnt				;				//步骤计数器

//--------------------------------------------------------
//--参数定义
//--------------------------------------------------------
localparam		IDLE = 3'D0 , PREC = 3'D1,ACT = 3'D2 ,WD = 3'D3  ; 
localparam		CMD_WRITE = 5'B10100 ,CMD_ACT = 5'B10011 ,CMD_PREC = 5'B10010,CMD_NOP = 5'B10111;

`define		BURST_LENGHT	4


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
			if(write_en) begin
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
				STATE_n = WD ;
			end
			else begin
				STATE_n = ACT ;
			end	
		end
		WD :begin
			if(burst_cnt == `BURST_LENGHT  ) begin							//突发结束	
				STATE_n = IDLE ;
			end
			else begin
				STATE_n = WD ;
			end		
		end
		default :begin
			STATE_n = IDLE ;
		end
	endcase
end
//--------------------------------------------------------
//--写状态输出
//--------------------------------------------------------
always@(posedge S_CLK or negedge RST_N) begin
	case(STATE_n)
		IDLE :begin
			
			write_ack <= 1'b0 ;
			fifo_rd_req <= 1'b0 ;
			write_cmd <= CMD_NOP ;
			write_addr <= 12'b0100_0000_0000;
			burst_cnt <= 'b0 ;
			step_cnt <= 'b0 ;			
		end
		PREC :begin
			if (step_cnt == 'd0) begin
				write_cmd <= CMD_PREC ;
				write_addr <= 12'b0100_0000_0000;
			end
			else begin
				write_cmd <= CMD_NOP ;
				write_addr <= 12'b0100_0000_0000;
			end
			
			step_cnt <= step_cnt + 1'b1 ;
		end
		ACT :begin
			if (step_cnt == 'd2) begin
				write_cmd <= CMD_ACT ;
				write_addr <= sdram_addr[11:0] ;
			end
			else begin
				write_cmd <= CMD_NOP ;
				write_addr <= 12'b0100_0000_0000;
				fifo_rd_req <= 1'b1 ;
			end
			step_cnt <= step_cnt + 1'b1 ;
		end
		WD :begin
			case(burst_cnt)
				0 :begin
					write_cmd <= CMD_WRITE ;
					write_addr <= sdram_addr[19:12];
				end
				`BURST_LENGHT - 1 :begin
					fifo_rd_req <= 1'b0 ;
				end
				
				default :begin
					write_cmd <= CMD_NOP ;
					write_addr <= 12'b0100_0000_0000;
				end
			endcase
			
			burst_cnt <= burst_cnt + 1'b1 ;
			
			if(burst_cnt == `BURST_LENGHT - 1) begin
				write_ack <= 1'b1 ;
			end
		end
	endcase
end
	
endmodule