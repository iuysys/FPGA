`timescale 1ns / 1ns

module SDRAM_TOP_tb();
reg						S_CLK					;				//系统时钟
reg						RST_N					;				//系统复位输入

wire					SDRAM_CLK				;			//SDRAM时钟
wire					SDRAM_CKE				;			//时钟使能
wire					SDRAM_CS				;			//片选
wire					SDRAM_RAS				;			//行地址选通信号,低电平
wire					SDRAM_CAS				;			//列地址选通信号,低电平
wire					SDRAM_WE				;			//写使能,低电平
wire	[1:0]			SDRAM_BANK				;			//BANK选择
wire	[11:0]			SDRAM_ADDR				;			//地址线
wire	[15:0]			SDRAM_DQ				;			//数据线
wire	[1:0]			SDRAM_DQM				;			//掩码线
                                                
wire	[15:0]			sys_write_data			;			//写入SDRAM的数据
wire	[15:0]			sys_read_data			;			//读出SDRAM的数据
wire	[19:0]			sdram_addr				;
wire	[1:0]			sys_bank				;
										        

wire					write_en				;
wire					read_en					;
															

wire					fifo_rd_req				;
wire					fifo_wd_req				;

wire					write_ack				;
wire					read_ack				;

wire					fifo_rd_en				;

                                                
wire					read_fifo_rdclk		    ;
wire					read_fifo_rdreq		    ;
wire					read_fifo_wrclk		    ;
wire	[15:0]			read_fifo_q			    ;
wire	[8:0]			read_fifo_wrusedw       ;


                                                
wire	[15:0]			write_fifo_data		    ;
wire					write_fifo_rdclk	 	;
wire					write_fifo_wrclk	 	;
wire					write_fifo_wrreq	 	;

wire	[8:0]			write_fifo_wrusedw      ;

reg						write_clk				;
reg						read_clk 				;
reg		[15:0]			w_fifo_data				;

initial begin
	S_CLK = 1'b1 ;
	RST_N = 1'b1 ;
	#100 RST_N = 1'B0 ;
	#100 RST_N = 1'B1 ;
end 

always #5 S_CLK = ~ S_CLK ;






// assign sys_write_data = 16'haffa ;




//写fifo的写时钟
always begin 
	#20 write_clk = 1'b1 ;		 
	#20 write_clk = 1'b0 ;
end
assign	write_fifo_wrclk = write_clk ;

//模拟摄像头产生数据
always@(posedge S_CLK or negedge RST_N) begin
	if(!RST_N)	begin
		w_fifo_data <= 'b0 ;
	end
	else begin
		if(write_fifo_wrusedw < 256 ) begin
			w_fifo_data <= w_fifo_data + 1'b1 ;
		end
		else begin
			w_fifo_data <= 'b0 ;
		end
	end
end
assign write_fifo_data = w_fifo_data ;
assign write_fifo_wrreq = (write_fifo_wrusedw < 256) ? 1'b1 : 1'b0 ;
//---------------------------------------------------
//-- 模拟VGA读数据

always begin 
	#12 read_clk = 1'b1 ;		 
	#12 read_clk = 1'b0 ;
end

assign read_fifo_rdreq = (read_fifo_wrusedw >2) ? 1'b1 : 1'b0 ;
assign read_fifo_rdclk = read_clk ;





SDRAM_CTRL	SDRAM_CTRL_inst(
.S_CLK					(S_CLK			),				//系统时钟
.RST_N					(RST_N			),				//系统复位输入
                        
.w_fifo_usedw			(write_fifo_wrusedw		),				//写fifo使用深度
.r_fifo_usedw			(read_fifo_wrusedw		),				//读fifo使用深度
.addr					(sdram_addr		),
.bank					(sys_bank		),
.write_ack				(write_ack		),
.write_en				(write_en		),
.read_ack				(read_ack		),
.read_en				(read_en		)		
);


SDRAM_TOP	SDRAM_TOP_inst(
	.S_CLK					(S_CLK	),				//系统时钟
	.RST_N					(RST_N	),				//系统复位输入

	.SDRAM_CLK				(SDRAM_CLK	),			//SDRAM时钟
	.SDRAM_CKE				(SDRAM_CKE	),			//时钟使能
	.SDRAM_CS				(SDRAM_CS	),			//片选
	.SDRAM_RAS				(SDRAM_RAS	),			//行地址选通信号,低电平
	.SDRAM_CAS				(SDRAM_CAS	),			//列地址选通信号,低电平
	.SDRAM_WE				(SDRAM_WE	),			//写使能,低电平
	.SDRAM_BANK				(SDRAM_BANK	),			//BANK选择
	.SDRAM_ADDR				(SDRAM_ADDR	),			//地址线
	.SDRAM_DQ				(SDRAM_DQ	),			//数据线
	.SDRAM_DQM				(SDRAM_DQM	),			//掩码线
                                         
	.sys_write_data			(sys_write_data	),			//写入SDRAM的数据
	.sdram_addr				(sdram_addr		),	
	.sys_bank				(sys_bank		),
	.sys_read_data			(sys_read_data	),			//读出SDRAM的数据
	
	.write_req				(write_en			),
	.read_req				(read_en			),
	.fifo_rd_req			(fifo_rd_req		),
	.fifo_rd_clk			(write_fifo_rdclk	),
	.fifo_wd_req			(fifo_wd_req 		),
	.fifo_wd_clk			(read_fifo_wrclk	),
	.write_ack				(write_ack			),
	.read_ack				(read_ack			)
	
);



sdram_model_plus sdram_model_plus_inst(
	.Dq		(SDRAM_DQ			), 
	.Addr	(SDRAM_ADDR			), 
	.Ba		(SDRAM_BANK			), 
	.Clk	(SDRAM_CLK			), 
	.Cke	(SDRAM_CKE			), 
	.Cs_n	(SDRAM_CS			), 
	.Ras_n	(SDRAM_RAS			), 
	.Cas_n	(SDRAM_CAS			), 
	.We_n	(SDRAM_WE			), 
	.Dqm	(SDRAM_DQM			),
	.Debug  (1'b1				)
);



read_fifo read_fifo_inst(
	.data		(sys_read_data						),
	.rdclk		(read_fifo_rdclk					),
	.rdreq		(read_fifo_rdreq					),
	.wrclk		(read_fifo_wrclk					),
	.wrreq		(fifo_wd_req						),
	.q			(read_fifo_q						),
	.wrusedw    (read_fifo_wrusedw   				)
);

write_fifo write_fifo_inst(
	.data		(write_fifo_data					),
	.rdclk		(write_fifo_rdclk					),
	.rdreq		(fifo_rd_req						),
	.wrclk		(write_fifo_wrclk					),
	.wrreq		(write_fifo_wrreq					),
	.q			(sys_write_data						),
	.wrusedw    (write_fifo_wrusedw  				)
);



















endmodule