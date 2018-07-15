
`define CLK_IN 20000000			//接入的时钟频率
`define LCD_WORK_FRQ	1000	//LCD工作频率
`define LCD_CLK_COUNT	(`CLK_IN/`LCD_WORK_FRQ/2)		//分频计数器数值	


module LCD1602(     
                input wire lcd_clk_in,				//高频时钟输入
				input wire[8:0] lcd_data_in,		//输入数据
                output reg [7:0] LCD_DATA,  		//输出数据
                output wire LCD_RW,  				//读/写使能
                output wire LCD_EN, 				//LCD使能 
                output reg LCD_RS  					//数据命令
                );  
    

//Fixed signal  
assign LCD_RW = 1'b0;  //Because of no write,so LCD_RW signal  
                       //is always low level  
  
//---------------------------------------------------------  
// 
//---------------------------------------------------------  
  
reg LCD_CLOCK;    //LCD工作时钟  
reg [21:0] count; //分频计数器
  
always@(posedge lcd_clk_in )  
begin  
   if(count == `LCD_CLK_COUNT)  
       count <= 22'd0;  
       LCD_CLOCK <= ~LCD_CLOCK;  
       end  
   else  
       count <= count + 1'b1;  //count清零  
end  
  
//enable negative edge  
assign LCD_EN = LCD_CLOCK;  
  
//---------------------------------------------------------  
//LCD internal parameter Settings  
//---------------------------------------------------------  
  
//Set parameters   
parameter     IDLE = 10'b00_0000_0000; //initial state  
parameter    CLEAR = 10'b00_0000_0001; //clear  
parameter   RETURN = 10'b00_0000_0010; //return home  
parameter     MODE = 10'b00_0000_0100; //entry mode set  
parameter  DISPLAY = 10'b00_0000_1000;//display ON/OFF control  
parameter   SHIFT  = 10'b00_0001_0000;//cursor or display shift  
parameter FUNCTION = 10'b00_0010_0000; //function set  
parameter    CGRAM = 10'b00_0100_0000; //set CGRAM address  
parameter  COMMAND = 10'b00_1000_0000; // 
parameter    WRITE = 10'b01_0000_0000; //write data to RAM  
parameter     STOP = 10'b10_0000_0000; //release control  
  
reg [9:0] state; //state machine code    
  
//If read,LCD_RS is high level,else is low level  
always@(posedge LCD_CLOCK)  
begin  
    if(state == WRITE)  
       LCD_RS <= 1'b1;  
    else  
       LCD_RS <= 1'b0;  
end  
  
//State machine  
always@(posedge LCD_CLOCK)  
begin  
      case(state)  
      //start  
      IDLE:begin    
            state <= CLEAR;  
            LCD_DATA <= 8'bzzzz_zzzz;  
           end  
      //clear  
      CLEAR:begin    
             state <= RETURN;  
             LCD_DATA <= 8'b0000_0001;  
            end   
      //home  
      RETURN:begin    
             state <= MODE;  
             LCD_DATA <= 8'b0000_0010;  
             end  
      //cursor move to the right  
      //display don't move  
      MODE:begin    
             state <= DISPLAY;  
             LCD_DATA <= 8'b0000_0110;  
           end  
      //display on  
      //cursor and blinking of cursor off  
      DISPLAY:begin    
             state <= SHIFT;  
             LCD_DATA <= 8'b0000_1100;  
              end  
      //cursor moving  
      //move to the right  
      SHIFT:begin    
             state <= FUNCTION;  
             LCD_DATA <= 8'b0001_0100;  
            end  
      //Set interface data length(8-bit)  
      //numbers of display line(2-line)  
      //display font type(5*8 dots)  
      FUNCTION:begin  
             state <= COMMAND;  
             LCD_DATA <= 8'b0011_1000;  
               end  
      //写入命令 
      COMMAND:begin 
				state <=WRITE;
				LCD_DATA <= lcd_data_in[7:0]; 
			end
      //Write data into internal RAM  
      WRITE:begin  
				if(!lcd_data_in[8])
					state <= COMMAND;
				else
					LCD_DATA <= lcd_data_in[7:0];  
            end  
      //Finish  
      //STOP:state <= STOP;  
      //Other state  
      default:state <= IDLE;  
      endcase     
   end   
  

endmodule  