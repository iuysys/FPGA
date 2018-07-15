module vga_control
(
	//输入端口
	CLK,RST_N,
	//输出端口
	DATA_OUT,VGA_X,VGA_Y
);
input CLK;
input RST_N;

output [7:0] DATA_OUT;
output VGA_X;
output VGA_y;

endmodule
