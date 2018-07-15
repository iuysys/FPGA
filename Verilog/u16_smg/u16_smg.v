module u16_smg(
	input res_n,					//复位
	input clk,						//输入时钟
	input [15:0] data,			//输入数据
	output [2:0] smg_sel,		//位选输出
	output [7:0] smg_duan		//段选数据
);

//***********************************************
//取出各位数据
//***********************************************
reg [15:0] data_temp;			//输入数据寄存器
reg [7:0] qian,shi,bai,ge;		//千,百,十,个

always@(posedge scan_clk or negedge res_n)
begin
	if(!res_n)
		data_temp = 0;
	else
		data_temp = data;		//读取输入数据
//	if(data_temp > 9999)
//		data_temp = 9999;
		
end
	
always@(*)
begin
	qian 	= data_temp /1000;
	bai  	= (data_temp %1000)/100;
	shi	= (data_temp%100)/10;
	ge   	= data_temp%10;
end
//***********************************************
//分频输出扫描时钟
//***********************************************
wire scan_clk;					//扫面时钟

clk_div 
#(
	.CLK_IN(20_000_000),
	.CLK_OUT(1_000)
)
smg_clk_div1(
	.clk(clk),
	.clk_div(scan_clk)
);
//***********************************************
//位选扫描
//***********************************************
reg [2:0] sel_count=0;			//位选计数	
	
always@(posedge scan_clk)
begin
	sel_count = sel_count + 1'b1;
	if (sel_count >= 4)
		sel_count = 0 ;
end
assign smg_sel = sel_count ;
//***********************************************
//选择位数据
//***********************************************
reg [7:0] duan_data_temp=0;
reg [7:0] duan_data=0;

always@(posedge scan_clk)
begin
	case(smg_sel)
		0	:duan_data	<=qian;
		1	:duan_data	<=bai;
		2	:duan_data	<=shi;
		3	:duan_data	<=ge;
		default:	$display("ERROR");
	
	endcase
	
	case(duan_data)
		0 : duan_data_temp <=8'b00111111;//0
		1 : duan_data_temp <=8'b00000110;//1
		2 : duan_data_temp <=8'b01011011;//2
		3 : duan_data_temp <=8'b01001111;//3
		4 : duan_data_temp <=8'b01100110;//4
		5 : duan_data_temp <=8'b01101101;//5
		6 : duan_data_temp <=8'b01111101;//6
		7 : duan_data_temp <=8'b00000111;//7
		8 : duan_data_temp <=8'b01111111;//8
		9 : duan_data_temp <=8'b01101111;//9
		default : $display("ERROR");
	endcase
end
assign smg_duan = duan_data_temp;



endmodule















