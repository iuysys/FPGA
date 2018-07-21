module OV7670_UART(
input 							SYS_CLK		,
input 							RST_N		,
			

			
input 				[7:0]		OV_data		,
input							OV_vsync	,			
output							OV_wrst		,
output							OV_rrst		,
output							OV_oe		,
output							OV_wen		,
output							OV_rclk		,

output							SCCB_SDA	,
output							SCCB_SCL	,

output							Txd			,	
output							c1			
);







wire		[15:0]  	data		;
wire		  			rdclk		;
wire		  			rdreq		;
wire		  			wrclk		;
wire		  			wrreq		;
wire		[15:0]  	q			;
wire			  		rdempty		;
wire		[8:0]  		wrusedw		;

wire					S_CLK		;

wire		[7:0]		data_out	;
wire					tx_req		;
wire					tx_busy	    ;


//------------------------------------------------------
//-- 
//------------------------------------------------------

OV_UART_pll OV_UART_pll_inst(
.inclk0			(SYS_CLK		),
.c0				(S_CLK			),
.c1				(c1				)
);

//------------------------------------------------------
//-- 
//------------------------------------------------------

uart_send_fifo uart_send_fifo_inst(
.data			(data					),
.rdclk			(rdclk					),
.rdreq			(rdreq					),
.wrclk			(wrclk					),
.wrreq			(wrreq					),
.q				(q						),
.rdempty		(rdempty				),
.wrusedw		(wrusedw				)
);

//------------------------------------------------------
//-- 
//------------------------------------------------------


OV7670_top	OV7670_top_inst(
.S_CLK			(S_CLK					),
.RST_N			(RST_N					),

.SCCB_SDA		(SCCB_SDA				),
.SCCB_SCL		(SCCB_SCL				),

.OV_data		(OV_data				),
.OV_vsync		(OV_vsync				),			
.OV_wrst		(OV_wrst				),
.OV_rrst		(OV_rrst				),
.OV_oe			(OV_oe					),
.OV_wen			(OV_wen					),
.OV_rclk		(OV_rclk				),

.w_usedw		(wrusedw				),
.w_req			(wrreq					),
.w_clk			(wrclk					),
.w_data		    (data					)

);

 UART_CTRL	UART_CTRL_inst(

.SYS_CLK		(SYS_CLK				),					//输入系统时钟
.RST_N			(RST_N					),					//复位
		
.data_in 		(q						),
.rd_empty		(rdempty				),
.rd_clk			(rdclk					),
.rd_req			(rdreq					),
		
.data_out		(data_out				),
.tx_req			(tx_req					),
.tx_busy		(tx_busy    			)

);

UART_Txd	UART_Txd_inst(
.SYS_CLK		(SYS_CLK				),					//输入系统时钟
.RST_N			(RST_N					),					//复位
.data_in		(data_out				),					//写入数据
.tx_req			(tx_req					),					//发送请求

.Txd			(Txd					),					//发送引脚
.tx_busy		(tx_busy				)					//发送模块忙,锁存数据后输出高
);






endmodule
