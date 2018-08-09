module UART_SDRAM_UART(
//系统输入
input  							SYS_CLK					,
input							RST_N					,

//串口接口		
input							Rxd						,
output							Txd						,
//SDRAM接口
//SDRAM interfaces
output							SDRAM_CLK				,			//SDRAM时钟
output							SDRAM_CKE				,			//时钟使能
output							SDRAM_CS				,			//片选
output							SDRAM_RAS				,			//行地址选通信号,低电平
output							SDRAM_CAS				,			//列地址选通信号,低电平
output							SDRAM_WE				,			//写使能,低电平
output			[1:0]			SDRAM_BANK				,			//BANK选择
output			[11:0]			SDRAM_ADDR				,			//地址线
inout			[15:0]			SDRAM_DQ				,			//数据线
output			[1:0]			SDRAM_DQM							//掩码线
);
//---------------------------------------------------
//-- 内部接口
//---------------------------------------------------
wire 			[7:0]			rx_data					;
wire							rx_busy					;

wire							w_req					;
wire							w_clk					;
wire			[15:0]			rx_data_out				;

wire							sdram_clk_in			;
wire							sdram_clk_out			;

wire							r_req 					;
wire							r_clk 					;
wire			[15:0]			r_fifo_q				;
wire			[10:0]			read_side_fifo_wusedw 	;
wire 			[10:0]			w_fifo_wusedw			;

wire			[7:0]			tx_data_out				;
wire							tx_req					;
wire							tx_busy					;

//---------------------------------------------------
//-- 串口接收模块
UART_Rxd	UART_Rxd_inst(
.SYS_CLK			(SYS_CLK				),
.RST_N				(RST_N					),
.Rxd				(Rxd					),						
        
.rx_data			(rx_data				),					//接收字节数据
.rx_busy			(rx_busy				)					//单字节接收完成信号
);
//---------------------------------------------------
//-- 串口数据处理模块
UART_Rxd_CTRL	UART_Rxd_CTRL_inst(
.SYS_CLK			(SYS_CLK				),
.RST_N				(RST_N					),

.rx_data_in			(rx_data				),
.rx_busy			(rx_busy				),


.w_req				(w_req					),
.w_clk				(w_clk					),			
.rx_data_out		(rx_data_out			)		

);

//---------------------------------------------------
//-- SDRAM_pll
sdram_pll 		sdram_pll_inst(
.inclk0				(SYS_CLK					),
.c0					(sdram_clk_in				),
.c1					(sdram_clk_out				)
);
//---------------------------------------------------
//-- SDRAM控制器
sdram_2port_top		sdram_2port_top_inst(
.clk				(sdram_clk_in				),
.rst_n				(RST_N						),
.sdram_clk_in		(sdram_clk_out				),

//write fifo interface
.w_fifo_wreq		(w_req							),
.w_fifo_wclk		(w_clk							),
.sys_w_data			(rx_data_out					),
.w_fifo_wusedw		(w_fifo_wusedw					),
//read fifo interface
.r_fifo_rreq		(r_req							),
.r_fifo_rclk		(r_clk							),
.sys_r_data			(r_fifo_q						),
.r_fifo_rusedw		(read_side_fifo_wusedw			),
//sdram interface		
.SDRAM_CLK			(SDRAM_CLK						),
.SDRAM_CKE			(SDRAM_CKE						),
.SDRAM_CS			(SDRAM_CS						),
.SDRAM_RAS			(SDRAM_RAS						),
.SDRAM_CAS			(SDRAM_CAS						),
.SDRAM_WE			(SDRAM_WE						),
.SDRAM_BANK			(SDRAM_BANK						),
.SDRAM_DQ 			(SDRAM_DQ 						),
.SDRAM_DQM			(SDRAM_DQM						),
.SDRAM_ADDR			(SDRAM_ADDR						)
);
//---------------------------------------------------
//-- 
UART_Txd_CTRL		UART_Txd_CTRL_inst(
//system interface
.SYS_CLK			(SYS_CLK						),					//输入系统时钟
.RST_N				(RST_N							),					//复位
//FIFO interface						
.data_in 			(r_fifo_q						),
.rd_fifo_usedw		(read_side_fifo_wusedw			),
.rd_clk				(r_clk							),
.rd_req				(r_req							),
//other 										
.data_out			(tx_data_out					),
.tx_req				(tx_req							),
.tx_busy			(tx_busy						)

);

UART_Txd		UART_Txd_inst(
.SYS_CLK			(SYS_CLK				),					//输入系统时钟
.RST_N				(RST_N					),					//复位
.data_in			(tx_data_out			),					//写入数据
.tx_req				(tx_req					),					//发送请求
	
.Txd				(Txd					),					//发送引脚
.tx_busy			(tx_busy				)					//发送模块忙,锁存数据后输出高
);


endmodule