`define LINE_1 12   //the number of line 1  
`define LINE_2 19   //the number of line 1 and line 2  
//=========================================================  
// Company:  Jackin  
// Engineer: Jackin  
//  
// Create Date:   2012-2-26     
// Design Name:   LCD_1602     
// Module Name:   LCD_1602     
// Project Name:  LCD_1602     
// Target Device: EP2C35F672  
// Tool versions: Modelsim SE PLUS 6.2b  &  Quartus II 9.0   
// Description:   CFAH1602B-TMC-JP port  
//                
// Dependencies:  
//   
// Revision:  
// Additional Comments:  
//=========================================================  
module V_LCD1602(reset,     
                clock,     
                LCD_DATA,  
                LCD_RW,  
                LCD_EN,  
                LCD_RS,  
                LCD_ON,  
                LCD_BLON  
                );  
  
input reset;  //reset  
input clock;  //50MHz Clock  
   
output [7:0] LCD_DATA; //8-bit LCD DATA  
output LCD_RW;   //LCD Read/Write Select,0=Write,1=Read  
output LCD_EN;   //LCD Enable  
output LCD_RS;   //LCD Command/Data select,0=Command,1=Data  
output LCD_ON;   //LCD Power ON/OFF,0=OFF,1=ON  
output LCD_BLON; //LCD Back Light ON/OFF,0=OFF,1=ON  
  
reg LCD_RS;  
reg [7:0] LCD_DATA;  
  
//Fixed signal  
assign LCD_ON = 1'b1;  //Power On  
assign LCD_BLON = 1'b1;//Back Light On  
assign LCD_RW = 1'b0;  //Because of no write,so LCD_RW signal  
                       //is always low level  
  
//---------------------------------------------------------  
//Produce 10Hz clock signal  
//---------------------------------------------------------  
  
reg LCD_CLOCK;    //10Hz Clock  
reg [21:0] count; //counter  
  
always@(posedge clock or negedge reset)  
begin  
   if(!reset)  //reset  
       begin   
       count <= 22'd0;  
       LCD_CLOCK <= 1'b0;  
       end  
   else if(count == 1250000)  //20Hz turn  
       begin  
       count <= 22'd0;  
       LCD_CLOCK <= ~LCD_CLOCK;  
       end  
   else  
       count <= count + 1'b1;  //count  
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
parameter  DISPLAY=10'b00_0000_1000;//display ON/OFF control  
parameter   SHIFT=10'b00_0001_0000;//cursor or display shift  
parameter FUNCTION = 10'b00_0010_0000; //function set  
parameter    CGRAM = 10'b00_0100_0000; //set CGRAM address  
parameter    DDRAM = 10'b00_1000_0000; //set DDRAM address  
parameter    WRITE = 10'b01_0000_0000; //write data to RAM  
parameter     STOP = 10'b10_0000_0000; //release control  
  
reg [9:0] state; //state machine code  
reg [5:0] char_count;  //char counter  
reg [7:0] data_display;//display data  
  
//If read,LCD_RS is high level,else is low level  
always@(posedge LCD_CLOCK or negedge reset)  
begin  
    if(!reset)  
       LCD_RS <= 1'b0;  
    else if(state == WRITE)  
       LCD_RS <= 1'b1;  
    else  
       LCD_RS <= 1'b0;  
end  
  
//State machine  
always@(posedge LCD_CLOCK or negedge reset)  
begin  
   if(!reset)  
   begin  
       state <= IDLE;  
       LCD_DATA <= 8'bzzzz_zzzz;  
       char_count <= 6'd0;  
   end  
   else  
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
             state <= DDRAM;  
             LCD_DATA <= 8'b0011_1000;  
               end  
      //Set DDRAM address in address counter  
      DDRAM:begin  
             state <= WRITE;  
             if(char_count <= `LINE_1)  
                LCD_DATA <= 8'b1000_0000;//line 1  
             else  
                LCD_DATA <= 8'b1100_0000;//line 2  
            end  
      //Write data into internal RAM  
      WRITE:begin  
             if(char_count == `LINE_1)  
                state <= DDRAM;  
             else  
                state <= WRITE;  
             if(char_count == `LINE_2)  
                state <= STOP;  
             char_count <= char_count + 1'b1;  
             LCD_DATA <= data_display;  
            end  
      //Finish  
      STOP:state <= STOP;  
      //Other state  
      default:state <= IDLE;  
      endcase     
   end  
end  
  
//---------------------------------------------------------  
//the data of display  
//---------------------------------------------------------  
  
always@(char_count)  
begin  
   case(char_count)  
       6'd0: data_display = "H";  
       6'd1: data_display = "e";  
       6'd2: data_display = "l";  
       6'd3: data_display = "l";  
       6'd4: data_display = "o";  
       6'd5: data_display = ",";  
       6'd6: data_display = "J";  
       6'd7: data_display = "a";  
       6'd8: data_display = "c";  
       6'd9: data_display = "k";  
       6'd10: data_display = "i";  
       6'd11: data_display = "n";  
       6'd12: data_display = "!";  
       6'd13: data_display = "W";  
       6'd14: data_display = "e";  
       6'd15: data_display = "l";  
       6'd16: data_display = "c";  
       6'd17: data_display = "o";  
       6'd18: data_display = "m";  
       6'd19: data_display = "e";  
       default:data_display = 8'd32;  
   endcase  
end  
endmodule  