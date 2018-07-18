module UART_Txd_tb();


reg							SYS_CLK			;
reg							RST_N			;
			                    		
wire						Txd				;
wire						tx_busy			;


wire			[15:0]		data_in 		;
wire						rd_empty	    ;
wire						rd_clk		    ;
wire						rd_req		    ;
			                                 
wire			[7:0]		data_out	    ;
wire						tx_req		    ;
wire						wrreq			;
reg				[15:0]  	data			;

wire			[7:0]  		wrusedw			;
initial begin
	SYS_CLK = 1'B1 ;
	RST_N = 1'B1 ;
	#50 RST_N = 1'B0 ;
	#100 RST_N = 1'B1 ;

end

always #25 SYS_CLK = ~SYS_CLK ;


always@(posedge SYS_CLK or negedge RST_N) begin
	if(!RST_N) begin
		data <= 'b0 ;
	end
	else begin
		if(wrusedw < 128) begin
			data <= data + 1'b1 ;
		end
	end
end
assign	wrreq = wrusedw < 128 ? 1'b1 : 1'b0 ;




UART_CTRL	UART_CTRL_inst(
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


uart_tx_fifo	uart_tx_fifo_inst(
.data		(data					),
.rdclk		(rd_clk					),
.rdreq		(rd_req					),
.wrclk		(SYS_CLK				),
.wrreq		(wrreq					),
.q			(data_in				),
.rdempty	(rd_empty				),
.wrusedw 	(wrusedw				)
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