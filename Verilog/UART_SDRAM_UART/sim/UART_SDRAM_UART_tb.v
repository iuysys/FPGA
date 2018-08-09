`timescale 1ns / 1ps
module UART_SDRAM_UART_tb();

//---------------------------------------------------
//-- 
//---------------------------------------------------

//系统输入
reg  							SYS_CLK				;
reg								RST_N				;
//串口接口		
reg								Rxd					;
wire							Txd					;
//SDRAM接口
//SDRAM interfaces
wire						SDRAM_CLK				;			//SDRAM时钟
wire						SDRAM_CKE				;			//时钟使能
wire						SDRAM_CS				;			//片选
wire						SDRAM_RAS				;			//行地址选通信号,低电平
wire						SDRAM_CAS				;			//列地址选通信号,低电平
wire						SDRAM_WE				;			//写使能,低电平
wire		[1:0]			SDRAM_BANK				;			//BANK选择
wire		[11:0]			SDRAM_ADDR				;			//地址线
wire		[15:0]			SDRAM_DQ				;			//数据线
wire		[1:0]			SDRAM_DQM				;			//掩码线

//---------------------------------------------------
//-- 
initial begin
	SYS_CLK = 1'b1 ;
	RST_N = 1'b1 ;
	Rxd = 1'b0 ;
	#50 RST_N = 1'B0 ;
	#100 RST_N = 1'B1 ;
end 

//---------------------------------------------------
//-- 
always #25 SYS_CLK = ~ SYS_CLK ;

//---------------------------------------------------
//-- 产生PC端数据
always begin
	#100 Rxd = 0 ;
	#150 Rxd = 1 ;
end



UART_SDRAM_UART		UART_SDRAM_UART_inst(
//系统输入
.SYS_CLK			(SYS_CLK				),
.RST_N				(RST_N					),
//串口接口		
.Rxd				(Rxd					),
.Txd				(Txd					),
//SDRAM接口
//SDRAM interfaces
.SDRAM_CLK			(SDRAM_CLK				),			//SDRAM时钟
.SDRAM_CKE			(SDRAM_CKE				),			//时钟使能
.SDRAM_CS			(SDRAM_CS				),			//片选
.SDRAM_RAS			(SDRAM_RAS				),			//行地址选通信号,低电平
.SDRAM_CAS			(SDRAM_CAS				),			//列地址选通信号,低电平
.SDRAM_WE			(SDRAM_WE				),			//写使能,低电平
.SDRAM_BANK			(SDRAM_BANK				),			//BANK选择
.SDRAM_ADDR			(SDRAM_ADDR				),			//地址线
.SDRAM_DQ			(SDRAM_DQ				),			//数据线
.SDRAM_DQM			(SDRAM_DQM				)			//掩码线
);

sdram_model_plus 	sdram_model_plus_inst(
.Dq				(SDRAM_DQ			), 
.Addr			(SDRAM_ADDR			), 
.Ba				(SDRAM_BANK			), 
.Clk			(SDRAM_CLK			), 
.Cke			(SDRAM_CKE			), 
.Cs_n			(SDRAM_CS			), 
.Ras_n			(SDRAM_RAS			), 
.Cas_n			(SDRAM_CAS			), 
.We_n			(SDRAM_WE			), 
.Dqm			(SDRAM_DQM			),
.Debug			(1'b1				)
);


endmodule