`timescale 1ns / 1ns
module SDRAM_CTRL(
input								S_CLK					,				//系统时钟
input								RST_N					,				//系统复位输入

input								image_rd_en				,				//图像数据读使能
output								fifo_rd_en				,				//读fifo 的读使能



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
reg					[1:0]				STATE_n					;
reg					[8:0]				write_image_pixel_cnt	;
reg					[8:0]				read_image_pixel_cnt	;
reg					[1:0]				image_cnt				;	
reg					[19:0]				addr_w					;
reg					[19:0]				addr_r					;

//--------------------------------------------------------
//--参数定义
//--------------------------------------------------------
localparam		IDLE = 2'D0 ,WRITE =2'D1 ,READ =2'D2 ;



assign addr = (STATE == WRITE)? {addr_w[7:0],addr_w[19:8]} :{addr_r[7:0],addr_r[19:8]} ;



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
// always@(STATE or image_rd_en or write_ack or read_ack or write_image_pixel_cnt or read_image_pixel_cnt) begin
always@(*) begin
	case(STATE)
		IDLE :begin
			if(image_rd_en) begin
				STATE_n = WRITE ;	
			end
			else begin
				STATE_n = IDLE ;
			end
			write_en = 'b0 ;
			read_en = 'b0 ;
		end
		WRITE :begin
			if(write_ack && write_image_pixel_cnt == 64 ) begin
				STATE_n = READ ;
				write_en = 1'b0 ;
				image_cnt = 2'b1  ;
			end
			else begin
				// addr = 12'h0001 ;
				bank = 2'b00 ;
				write_en = 1'b1 ;
			end
		end
		READ : begin
			if(read_ack && read_image_pixel_cnt == 64 ) begin
				read_en = 1'b0 ;
				STATE_n = IDLE ;
				image_cnt = 2'b0  ;
			end
			else begin
				// addr = 12'h0001 ;
				bank = 2'b00 ;
				read_en = 1'b1 ;
			end
		end
		default :begin
			STATE_n = IDLE ;
		end
	
	endcase
end

// 写图像像素计数
always@(posedge write_ack or negedge RST_N) begin
	if(!RST_N)	begin
		write_image_pixel_cnt <= 'b0 ;
		addr_w <= 'b0 ;
	end
	else begin
		if(write_image_pixel_cnt == 64) begin
			write_image_pixel_cnt <= 'b0 ;
			addr_w <= 'b0 ;
		end
		else begin
			write_image_pixel_cnt <= write_image_pixel_cnt + 1'b1 ;
			addr_w <= addr_w + 'd4 ;
		end
		
	end
end
// 读图像像素计数
always@(posedge read_ack or negedge RST_N) begin
	if(!RST_N)	begin
		read_image_pixel_cnt <= 'b0 ;
		addr_r <= 'b0 ;
	end
	else begin
		if(read_image_pixel_cnt == 64) begin
			read_image_pixel_cnt <= 'b0 ;
			addr_r <= 'b0 ;
		end
		else begin
			read_image_pixel_cnt <= read_image_pixel_cnt + 1'b1 ;
			addr_r <= addr_r + 'd4 ;
		end
		
	end
end

endmodule
























