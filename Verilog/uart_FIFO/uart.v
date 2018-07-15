
module uart(
	input uart_clk ,				//串口驱动时钟
	input uart_res ,				//串口异步复位
	input wrclk,					//写时钟
	input wrreq,					//写使能1
	input [7:0] uart_data,			//串口输入数据,后期加FIFO
	output wrempty,				//FIFO空信号
	output wrfull,					//FIFO满信号
	output [7:0] wrusedw,		//FIFO使用深度，数据个数
	output reg uart_tx				//串口发送数据
);

parameter sys_time = 50;		//预定义系统时钟周期ns
parameter buad = 9600;			//波特率


reg [31:0] buad_count = (1_000_000_000/buad/sys_time);		//计数值		
reg [31:0] count;			//波特率计数器
reg [7:0]  count1;		//字节位计数器

fifo_ip u1_fifo(
	.wrclk(wrclk),
	.wrempty(wrempty),
	.wrfull(wrfull),
	.data(uart_data),
	.wrusedw(wrusedw),
	
);


//*********************************************************
//读FIFO数据
//*********************************************************
always@()
begin
	
end



always@(posedge uart_clk)
	
	begin
			
			count =count + 1'b1;
		
			if(count >= 10)
			begin
				count =32'b0;
				
				if(count1==0)
					uart_tx = 1'b0;
				else if (count1 <= 0)
				begin
					 uart_tx = data_out[count1 - 1];
				end
				else
				begin 
					uart_tx = 1'b1;
				end 
				count1 = count1 + 1'b1 ;
				if (count1>9)
					count1 =0;
			end	
	end
endmodule