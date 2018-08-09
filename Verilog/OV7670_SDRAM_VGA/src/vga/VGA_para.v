`timescale 1ns/1ns

//define colors RGB--5|6|5
`define RED		16'hF800   /*11111,000000,00000	F800 */
`define GREEN	16'h07E0   /*00000,111111,00000	07E0 */
`define BLUE  	16'h001F   /*00000,000000,11111	001F */
`define WHITE 	16'hFFFF   /*11111,111111,11111	FFFF */
`define BLACK 	16'h0000   /*00000,000000,00000	0000 */
`define YELLOW	16'hFFE0   /*11111,111111,00000	FFE0 */
`define CYAN  	16'hF81F   /*11111,000000,11111	F81F */
`define ROYAL 	16'h07FF   /*00000,111111,11111	07FF */ 

//---------------------------------------------------
//-- 定义显示的起始坐标及显示区的大小
//---------------------------------------------------
`define DISPLAY_X_START 100
`define DISPLAY_Y_START 100

`define DISPLAY_X_SIZE 	320
`define DISPLAY_Y_SIZE 	240


//------------------------------------------------------
//--
//------------------------------------------------------
// `define VGA_600_480_60HZ
`define	VGA_800_600_60HZ


//------------------------------------------------------
//--600*480@60hz
//------------------------------------------------------
`ifdef	VGA_600_480_60HZ
//-- Horizonal timing information
`define HSYNC_A   16'd96	//96
`define HSYNC_B   16'd144  	//96+48
`define HSYNC_C   16'd784 	//96+48+600
`define HSYNC_D   16'd800 	//96+48+600+16
//-- Vertical  timing information
`define VSYNC_O   16'd2    //2 
`define VSYNC_P   16'd35   //2+33 
`define VSYNC_Q   16'd515  //2+33+480 
`define VSYNC_R   16'd525  //2+33+480+10 
`endif
//------------------------------------------------------
//--800*600@60hz
//------------------------------------------------------
`ifdef	VGA_800_600_60HZ
//-- Horizonal timing information
`define HSYNC_A   16'd128  // 
`define HSYNC_B   16'd216  // 
`define HSYNC_C   16'd1016 // 
`define HSYNC_D   16'd1056 // 
//-- Vertical  timing information
`define VSYNC_O   16'd4    //
`define VSYNC_P   16'd27   //
`define VSYNC_Q   16'd627  //
`define VSYNC_R   16'd628  //
`endif