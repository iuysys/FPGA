`timescale 1ns/1ps


module VGA_driver(
input								clk					,
input								rst_n				,
				
input					[15:0]		vga_rgb_in			,

output								vga_display_en		,		//处于显示区
				
output					[9:0]		vga_x_pos			,
output					[9:0]		vga_y_pos			,
						


output								vga_blank			,
output								vga_sync			,

output								vga_clk				,						
output								vga_hsync 			,
output								vga_vsync			,
output		reg			[15:0]		vga_rgb_out			
);

//------------------------------------------------------
//--包涵参数文件
//------------------------------------------------------
`include "F:/FPGA/Verilog/OV7670_SDRAM_VGA/src/vga/VGA_para.v"
// `include"..src/VGA_para.v"
//------------------------------------------------------
//--
//------------------------------------------------------


//------------------------------------------------------
//-- 内部端口
//------------------------------------------------------
reg			[15:0]					hsync_cnt			;
reg			[15:0]					vsync_cnt			;	


//------------------------------------------------------
//--组合逻辑输出
//------------------------------------------------------

assign	vga_clk = ~clk ;
assign	vga_sync = 1'b0 ;
assign	vga_blank = vga_hsync & vga_vsync ;	


assign	vga_hsync = (hsync_cnt <= `HSYNC_A - 1) ? 1'b1 : 1'b0 ;
assign	vga_vsync = (vsync_cnt <= `VSYNC_O - 1) ? 1'b1 : 1'b0 ;

assign	vga_display_en =((hsync_cnt >= `HSYNC_B && hsync_cnt <= `HSYNC_C) && 
						(vsync_cnt >= `VSYNC_P && vsync_cnt <= `VSYNC_Q)) ? 1'b1 : 1'b0 ;
						
//---------------------------------------------------
//-- 锁存输出数据
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin
    	vga_rgb_out <= 'b0 ;
    end
    else if (vga_display_en) begin
    	vga_rgb_out <= vga_rgb_in ;
    end
    else begin
    	vga_rgb_out <= 'b0 ;
    end
end


assign	vga_x_pos = vga_display_en ? (hsync_cnt - `HSYNC_B) : 10'b0 ;
assign	vga_y_pos = vga_display_en ? (vsync_cnt - `VSYNC_P) : 10'b0 ;
//------------------------------------------------------
//--行同步计数
//------------------------------------------------------
always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		hsync_cnt <= 'b0 ;
	end
	else if(hsync_cnt < `HSYNC_D - 1)begin
		hsync_cnt <= hsync_cnt + 1'b1 ;
	end
	else begin
		hsync_cnt <= 'b0 ;
	end
end

//------------------------------------------------------
//--列同步计数
//------------------------------------------------------
always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		vsync_cnt <= 'b0 ;
	end
	else if(hsync_cnt == `HSYNC_D - 1)begin
		if(vsync_cnt < `VSYNC_R - 1) begin
			vsync_cnt <= vsync_cnt + 1'b1 ;
		end
		else begin
			vsync_cnt <= 'b0 ;
		end
	end
end


endmodule








































