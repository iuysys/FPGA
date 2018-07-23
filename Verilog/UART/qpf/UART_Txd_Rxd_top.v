module UART_Txd_Rxd_top(
input							SYS_CLK		,
input							RST_N	    ,
                                          
input							Rxd         ,
                                          
output							Txd    

);


			                    		


wire						tx_busy			;

wire			[7:0]		rx_data         ;
wire 						rx_busy         ;

wire			[15:0]		data_in 		;
wire						rd_empty	    ;
wire						rd_clk		    ;
wire						rd_req		    ;
			                                 
wire			[7:0]		data_out	    ;
wire						tx_req		    ;
wire						wrreq			;


wire			[7:0]  		wrusedw			;

wire						w_clk			;



// always@(posedge SYS_CLK or negedge RST_N) begin
	// if(!RST_N) begin
		// data <= 'b0 ;
	// end
	// else begin
		// if(wrusedw < 128) begin
			// data <= data + 1'b1 ;
		// end
	// end
// end
// assign	wrreq = wrusedw < 128 ? 1'b1 : 1'b0 ;



UART_Rxd	UART_Rxd_inst(
.SYS_CLK			(SYS_CLK			),
.RST_N				(RST_N				),
.Rxd				(Rxd				),						
                                        
.rx_data			(rx_data			),					//接收字节数据
.rx_busy			(rx_busy			)					//单字节接收完成信号
);

UART_Rxd_CTRL	UART_Rxd_CTRL_inst(
.SYS_CLK			(SYS_CLK			),
.RST_N				(RST_N				),
                   
.rx_busy			(rx_busy			),
                  
.w_req				(wrreq				),
.w_clk				(w_clk				)


);

uart_tx_fifo	uart_tx_fifo_inst(
.data		({8'haf,rx_data}				),
.rdclk		(rd_clk					),
.rdreq		(rd_req					),
.wrclk		(w_clk					),
.wrreq		(wrreq					),
.q			(data_in				),
.rdempty	(rd_empty				),
.wrusedw 	(wrusedw				)
);

UART_Txd_CTRL	UART_Txd_CTRL_inst(
.SYS_CLK	(SYS_CLK					),					//输入系统时钟
.RST_N		(RST_N						),					//复位

.data_in 	(data_in 					),
.rd_empty	(rd_empty					),
.rd_clk		(rd_clk						),
.rd_req		(rd_req						),
          
.data_out	(data_out					),
.tx_req		(tx_req						),
.tx_busy    (tx_busy     				)
);

UART_Txd	UART_Txd_inst(
.SYS_CLK	(SYS_CLK					),					//输入系统时钟
.RST_N		(RST_N						),					//复位
.data_in	(data_out					),					//写入数据
.tx_req		(tx_req						),					//发送请求
	
.Txd		(Txd						),					//发送引脚
.tx_busy	(tx_busy					)					//发送模块忙,锁存数据后输出高
);


endmodule