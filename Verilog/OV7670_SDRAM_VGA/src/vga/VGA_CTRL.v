`timescale 1ns/1ps
//------------------------------------------------------
//--包涵参数文件
//------------------------------------------------------
`include "F:/FPGA/Verilog/OV7670_SDRAM_VGA/src/vga/VGA_para.v"
//---------------------------------------------------
//-- 
module VGA_CTRL(
input							clk				,
input							rst_n			,

input				[10:0]		r_fifo_usedw	,
output							vga_r_req		,
output							vga_r_clk		,
input				[15:0]		vga_r_data_in	,


input							vga_display_en	,
input				[9:0]		vga_x_pos		,
input				[9:0]		vga_y_pos		,


output				[15:0]		vga_r_data_out		

);

//---------------------------------------------------
//-- 
//---------------------------------------------------
wire								r_req_mask		;
reg									vga_r_en		;

//------------------------------------------------------
//--
//------------------------------------------------------
assign 	vga_r_clk = ~clk ;
assign	vga_r_req = (vga_display_en && r_req_mask && vga_r_en) ? 1'b1 : 1'b0 ;
assign  vga_r_data_out =  r_req_mask ? vga_r_data_in : `ROYAL ;

//---------------------------------------------------
//-- 组合逻辑输出数据的读使能
assign r_req_mask = (((vga_x_pos >= `DISPLAY_X_START && vga_x_pos < `DISPLAY_X_START + `DISPLAY_X_SIZE ) &&
    		(vga_y_pos >= `DISPLAY_Y_START && vga_y_pos < `DISPLAY_Y_START + `DISPLAY_Y_SIZE )) &&
    		(vga_display_en)) ? 1'b1 : 1'b0 ;

//---------------------------------------------------
//-- 
//---------------------------------------------------
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin
    	vga_r_en <= 'b0 ;
    end
    else if (r_fifo_usedw >= 320) begin
    	vga_r_en <= 'b1 ;
    end
end
// //------------------------------------------------------
// //--
// //------------------------------------------------------
// always@(*) begin
// 	if(vga_x_pos < 200 && vga_y_pos < 150) begin
// 		vga_data = `RED ;
// 	end
// 	else if(vga_x_pos < 400 && vga_y_pos < 300) begin
// 		vga_data = `GREEN ;
// 	end
// 	else if(vga_x_pos < 600 && vga_y_pos < 450) begin
// 		vga_data = `BLUE ;
// 	end
// 	else begin
// 		vga_data = `YELLOW ;
// 	end

// end











endmodule





































