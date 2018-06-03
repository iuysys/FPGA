module UART_TOP 
(
	//输入
	SYS_CLK,RST_N,WRREQ,WRCLK,FIFO_DATA,
	//输出
	TXD,WRFULL
);
//------------------------------------------------------
//-- 外部端口
//------------------------------------------------------
input 					SYS_CLK;						//输入系统时钟
input 					RST_N;						//复位
input		[7:0] 		FIFO_DATA;					//写入数据
input 					WRREQ;						//FIFO写请求
input 					WRCLK;						//FIFO写时钟

output					TXD;							//发送引脚
output					WRFULL;						//FIFO满信号
//------------------------------------------------------
//-- 内部端口
//------------------------------------------------------
wire		[7:0]			fifo_out_data;				//FIFO输出数据线
wire						fifo_empty_sig;			//FIFO空信号线
wire						fifo_rdclk_sig;			//FIFO读时钟信号线
wire						fifo_rdreq_sig;			//FIFO读请求信号线

FIFO_IP	FIFO_IP_inst (
	.data ( FIFO_DATA ),
	.rdclk ( fifo_rdclk_sig ),
	.rdreq ( fifo_rdreq_sig ),
	.wrclk ( WRCLK ),
	.wrreq ( WRREQ ),
	.q ( fifo_out_data ),
	.rdempty ( fifo_empty_sig ),
	.wrfull ( WRFULL )
	);

//------------------------------------------------------
//-- 
//------------------------------------------------------

UART_TXD UART_TXD_inst(
	//输入
	.SYS_CLK(SYS_CLK),
	.RST_N(RST_N),
	.DATA_IN(fifo_out_data),
	.TX_REQ(1'b0),
	//输出
	.TXD(TXD),
	.RDCLK(fifo_rdclk_sig),
	.RDREQ(fifo_rdreq_sig)
);

endmodule 