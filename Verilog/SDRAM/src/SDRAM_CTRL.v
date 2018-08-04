`timescale 1ns / 1ns
module SDRAM_CTRL(
input								S_CLK					,				//系统时钟
input								RST_N					,				//系统复位输入

input				[8:0]			w_fifo_usedw			,				//写fifo使用深度
input				[8:0]			r_fifo_usedw			,				//读fifo使用深度



output				[19:0]			addr					,				//读写SDRAM地址
output		reg		[1:0]			bank					,
input								write_ack				,				//突发写结束		
output		reg						write_en				,				//写SDRAM使能
input								read_ack				,				//突发读结束
output		reg						read_en									//读SDRAM使能
);
//--------------------------------------------------------
//--内部信号
//--------------------------------------------------------
reg					[1:0]				STATE					;
reg					[19:0]				addr_w					;
reg					[19:0]				addr_r					;
reg										w_bank_flag				;	
reg										r_bank_flag				;	
reg										pp_flag					;	

reg					[1:0]				r_bank_reg				;



//--------------------------------------------------------
//--参数定义
//--------------------------------------------------------
localparam		IDLE = 2'D0 ,WRITE =2'D1 ,READ =2'D2 ;

//---------------------------------------------------
//-- 
//---------------------------------------------------
assign addr = (STATE == WRITE) ? addr_w : addr_r ;

// //状态转换
// always@(posedge S_CLK or negedge RST_N) begin
// 	if(!RST_N) begin
// 		STATE <= IDLE ;
// 	end
// 	else begin
// 		STATE <= STATE_n ;
// 	end
// end

//---------------------------------------------------
//-- 
//---------------------------------------------------
always @ (posedge S_CLK or negedge RST_N) begin
    if(!RST_N) begin
    	STATE <= IDLE ;
    	addr_w <= 'b0 ;
    	addr_r <= 'b0 ;
    	r_bank_flag <= 'b0 ;
    	w_bank_flag <= 'b0 ;
    	pp_flag <= 'b0 ;
    	write_en <= 'b0 ;
    	read_en <= 'b0 ;
    	bank <= 'b0 ;
    end
    else begin
    	case(STATE)
			IDLE :begin
				if (pp_flag && r_fifo_usedw < 'd5) begin	//触发了乒乓操作且数据少于(几个)突发长度
					STATE <= READ ;
				end
				else if (w_fifo_usedw > 'd4) begin		//大于突发长度的数据
					STATE <= WRITE ;
				end
				else begin
					STATE <= IDLE ;
				end
			end
			WRITE :begin
				//---------------------------------------------------
				//-- bank转换
				if (w_bank_flag) begin
					bank <= 2'b01 ;
				end
				else begin
					bank <= 2'b00 ;
				end
				//---------------------------------------------------
				//-- 地址生成
				if (write_ack) begin
					STATE <= IDLE ;
					write_en <= 'b0 ;
					addr_w <= addr_w + 1'b1 ;
					if (addr_w == 'd7) begin
						addr_w <= 'b0 ;
						w_bank_flag <= ~ w_bank_flag ;
						//---------------------------------------------------
						//-- 触发乒乓操作
						if (!pp_flag) begin
							pp_flag <= 'b1 ;
						end
					end
					
				end
				else begin
					write_en <= 'b1 ;
				end
			end
			READ : begin
				//---------------------------------------------------
				//-- 选择读取的bank
				if (!r_bank_flag) begin			//帧读取结束后才转换bank
					r_bank_flag <= 'b1 ;
					if (w_bank_flag) begin		//读取与写操作相反的bank
						bank <= 2'b00 ;
						r_bank_reg <= 2'b00 ;
					end
					else begin
						bank <= 2'b01 ;
						r_bank_reg <= 2'b01 ;
					end
				end
				else begin
					bank <= r_bank_reg ;
				end
				
				//---------------------------------------------------
				//-- 读地址生成
				if (read_ack) begin
					STATE <= IDLE ;
					read_en <= 'b0 ;
					addr_r <= addr_r + 1'b1 ;
					if (addr_r == 'd7) begin
						addr_r <= 'b0 ;
						r_bank_flag <= 'b0 ;
					end
				end
				else begin
					read_en <= 'b1 ;
				end
			end
			default :begin
				STATE <= IDLE ;
			end
		endcase
    end
end


// //-------------------------------------
// //-- write_ack边沿检测
// //-------------------------------------
// always @ (posedge S_CLK or negedge RST_N)begin
//     if(!RST_N) begin
//     	w_ack_now <= 1'b0 ;
//     	w_ack_pre <= 1'b0 ;
//     end
//     else begin
//     	w_ack_now <=  write_ack;
//     	w_ack_pre <=  w_ack_now;
//     end
// end
// //---- 下降沿信号
// assign w_ack_pedg = (!w_ack_pre && w_ack_now) ? 1'b1 : 1'b0 ;

// //-------------------------------------
// //-- read_ack边沿检测
// //-------------------------------------
// always @ (posedge S_CLK or negedge RST_N)begin
//     if(!RST_N) begin
//     	r_ack_now <= 1'b0 ;
//     	r_ack_pre <= 1'b0 ;
//     end
//     else begin
//     	r_ack_now <=  read_ack;
//     	r_ack_pre <=  r_ack_now;
//     end
// end
// //---- 下降沿信号
// assign r_ack_pedg = (!r_ack_pre && r_ack_now) ? 1'b1 : 1'b0 ;

endmodule
























