`define CLK_IN 20000000			//接入的时钟频率
`define LCD_WORK_FRQ	1000	//LCD工作频率
`define LCD_CLK_COUNT	(`CLK_IN/`LCD_WORK_FRQ/2)	

module LCD1602(
	lcd_clk_in,				//LCD高速时钟输入
	lcd_data_in,	//LCD[命令/数据-数据输入]
	LCD_RS,		//数据命令选择
	LCD_EN,		//LCD使能
	LCD_RW,					//读/写
	LCD_DATA	//LCD数据输出DATA[7..0]
);
input  lcd_clk_in;				//LCD高速时钟输入
input  [8:0] lcd_data_in;	//LCD[命令/数据-数据输入]
output  LCD_RS;		//数据命令选择
output  LCD_EN;		//LCD使能
output  LCD_RW;					//读/写
output  [7:0] LCD_DATA;	//LCD数据输出DATA[7..0]


wire lcd_clk_in;				//LCD高速时钟输入
wire [8:0] lcd_data_in;	//LCD[命令/数据-数据输入]
reg LCD_RS;		//数据命令选择
wire LCD_EN;		//LCD使能
wire LCD_RW;					//读/写
reg [7:0] LCD_DATA;	//LCD数据输出DATA[7..0]

 
assign LCD_RW = 1'b0;					//写使能


/************************************************/
//时钟分频
reg [31:0] count1 ;		//分频计数器
reg LCD_CLOCK;				//分频输出的LCD工作低频时钟
always@(posedge lcd_clk_in)
begin
	
	count1 = count1 + 1'b1;
	if(count1 >= `LCD_CLK_COUNT)
	begin
		count1 = 32'b0;
		LCD_CLOCK = !LCD_CLOCK;
	end
end
assign LCD_EN = LCD_CLOCK ;

/************************************************/
//驱动模块
reg start;			//已初始化1/未初始化0
reg [7:0] count2;	//初始化计数器
always@(posedge LCD_CLOCK)
begin
	
	if(start)			
	begin
		LCD_DATA <= "k";
	end
	else				//初始化LCD
	begin
		LCD_RS <= 1'b0;		
		count2 = count2 + 1'b1;
		case(count2)
			0:
			begin
				LCD_DATA[7:0]=8'bz;
			end
			1:
			begin
				LCD_DATA[7:0]=8'h01;
			end
			2:
			begin
				LCD_DATA[7:0]=8'h38;
			end
			3:
			begin
				LCD_DATA[7:0]=8'h0c;
			end
			4:
			begin
				LCD_DATA[7:0]=8'h06;
			end
			5:
			begin
				LCD_DATA[7:0]=8'h01;
			end
			6:
			begin
				LCD_DATA[7:0]=8'h80;
			end
			7:
			begin
				LCD_RS <= 1;
				LCD_DATA[7:0]="O";	
			end
			8:
			begin
				LCD_RS <= 1;
				LCD_DATA[7:0]="K";	
			end
			9:
			begin
				LCD_RS <= 1;
				LCD_DATA[7:0]="!";	
				start <= 1'b1;
				count2 = 1'b0;
			end
			default:
			begin 
				LCD_DATA[7:0]=8'd32;
			end
		endcase
	
	end
	
	
end

endmodule
