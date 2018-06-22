`timescale 1ns / 1ns
module SDRAM_WRITE(
input								S_CLK					,				//系统时钟
input								RST_N					,				//系统复位输入

output		reg						write_ack				,
input								write_en				,
output		reg						fifo_rd_req				,
input				[19:0]			sdram_addr				,
output		reg		[11:0]			write_addr				,
output		reg		[4:0]			write_cmd			
);
//--------------------------------------------------------
//--内部信号
//--------------------------------------------------------
reg			[1:0]					STATE 					;
reg			[2:0]					burst_cnt				;


//--------------------------------------------------------
//--参数定义
//--------------------------------------------------------
localparam		IDLE = 2'D0 ,ACT = 2'D1 ,WD = 2'D2 , PREC = 2'D3 ; 
localparam		CMD_WRITE = 5'B10100 ,CMD_ACT = 5'B10011 ,CMD_PREC = 5'B10010,CMD_NOP = 5'B10111;
`define		BURST_LENGHT	3

//--------------------------------------------------------
//--写状态转换
//--------------------------------------------------------
// always@(posedge S_CLK or negedge RST_N) begin
	// if(!RST_N)	begin
		// STATE <= IDLE ;
	// end
	// else begin
		// case(STATE)
			// IDLE :begin
				// if(write_en) begin
					// STATE <= ACT ;
				// end
				// else begin
					// STATE <= IDLE ;
				// end
			// end
			// ACT :begin
				// STATE <= WD ;
			// end
			// WD :begin
				// if(burst_cnt == `BURST_LENGHT) begin			//突发结束			
					
					// STATE <= PREC ;
					
				// end
				// else begin
					// STATE <= WD ;
				// end
			// end
			// PREC :begin
				// STATE <= IDLE ;
			// end
			// default :begin
				// STATE <= IDLE ;
			// end
		// endcase
	// end
// end
//--------------------------------------------------------
//--写状态输出
//--------------------------------------------------------
always@(posedge S_CLK or negedge RST_N) begin
	if(!RST_N)	begin
		STATE <= IDLE ;
		write_ack <= 1'b0 ;
	end
	else begin
		case(STATE)
			IDLE :begin
				if(write_en) begin
					STATE <= ACT ;
					
				end
				else begin
					STATE <= IDLE ;
				end
				write_ack <= 1'b0 ;
				write_cmd <= CMD_NOP ;
				write_addr <= 12'b0100_0000_0000;
							
			end
			ACT :begin
				STATE <= WD ;
				burst_cnt <= 'b0 ;
				fifo_rd_req <= 1'b1 ;
				write_cmd <= CMD_ACT ;
				write_addr <= sdram_addr[11:0] ;
			end
			WD :begin
				case(burst_cnt)
					0 :begin
						write_cmd <= CMD_WRITE ;
						write_addr <= sdram_addr[19:12];
					end
					1,2,3:begin
						write_cmd <= CMD_NOP ;
						write_addr <= 12'b0100_0000_0000;
					end
					4 :begin
						STATE <= PREC ;
						write_cmd <= CMD_PREC ;
						fifo_rd_req <= 1'b0 ;
						
					end
				endcase
				burst_cnt <= burst_cnt + 1'b1 ;
			end
			PREC :begin
				STATE <= IDLE ;
				write_cmd <= CMD_NOP ;
				write_ack <= 1'b1 ;
				write_addr <= 12'b0100_0000_0000;
			end
			default :begin	
				STATE <= IDLE ;
			end
		endcase
	end
end
	
endmodule