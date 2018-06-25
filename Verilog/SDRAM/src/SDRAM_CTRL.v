`timescale 1ns / 1ns
module SDRAM_CTRL(
input								S_CLK					,				//系统时钟
input								RST_N					,				//系统复位输入

input								image_rd_en				,
output		reg		[19:0]			addr					,
input								write_ack				,
output		reg						write_en				,
input								read_ack				,
output		reg						read_en				
);
//--------------------------------------------------------
//--内部信号
//--------------------------------------------------------
reg					[1:0]				STATE					;
reg					[8:0]				write_image_pixel_cnt	;
reg					[8:0]				read_image_pixel_cnt	;
reg					[1:0]				image_cnt				;	


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
				end
				else begin
					STATE <= IDLE ;
				end
			end
			WRITE :begin
				if(write_ack && write_image_pixel_cnt == 30) begin
					
					write_en <= 1'b0 ;
					STATE <= READ ;
				end
				else begin
					addr <= 12'h0001 ;
					write_en <= 1'b1 ;
				end
			end
			READ : begin
				if(read_ack && read_image_pixel_cnt == 30) begin
					read_en <= 1'b0 ;
					STATE <= IDLE ;
				end
				else begin
					addr <= 12'h0001 ;
					read_en <= 1'b1 ;
				end
			end
			default :begin
				STATE <= IDLE ;
			end
		
		endcase
	end
end

//写图像像素计数
always@(posedge write_ack or negedge RST_N) begin
	if(!RST_N)	begin
		write_image_pixel_cnt <= 'b0 ;
	end
	else begin
		if(write_image_pixel_cnt == 30) begin
			write_image_pixel_cnt <= 'b0 ;
		end
		else begin
			write_image_pixel_cnt <= write_image_pixel_cnt + 1'b1 ;
		end
		
	end
end
//读图像像素计数
always@(posedge read_ack or negedge RST_N) begin
	if(!RST_N)	begin
		read_image_pixel_cnt <= 'b0 ;
	end
	else begin
		if(read_image_pixel_cnt == 30) begin
			read_image_pixel_cnt <= 'b0 ;
		end
		else begin
			read_image_pixel_cnt <= read_image_pixel_cnt + 1'b1 ;
		end
		
	end
end

endmodule
























