`timescale 1ns / 1ns
module SDRAM_CTRL(
input								S_CLK					,				//系统时钟
input								RST_N					,				//系统复位输入

input								image_rd_en				,
output		reg		[19:0]			addr					,
input								write_ack				,
output		reg						write_en				
);
//--------------------------------------------------------
//--内部信号
//--------------------------------------------------------
reg					[1:0]				STATE				;



//--------------------------------------------------------
//--参数定义
//--------------------------------------------------------
localparam		IDLE = 2'D0 ,WRITE =2'D1 ,READ =2'D2 ;



//--------------------------------------------------------
//--
//--------------------------------------------------------
always@(posedge S_CLK or negedge RST_N) begin
	if(!RST_N)	begin
		STATE <= IDLE ;
		write_en <= 1'b0 ;
	end
	else begin
		case(STATE)
			IDLE :begin
				if(image_rd_en) begin
					STATE <= WRITE ;
					write_en <= 1'b1 ;
				end
				else begin
					STATE <= IDLE ;
				end
			end
			WRITE :begin
				if(write_ack) begin
					write_en <= 1'b0 ;
					STATE <= IDLE ;
				end
				else begin
					addr <= 12'h0001 ;
				end
			end
			default :begin
				STATE <= IDLE ;
			end
		
		endcase
	end
end

endmodule
























