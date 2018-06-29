`timescale 1ns / 1ns

module SDRAM_TOP_tb();
reg								S_CLK					;				//系统时钟
reg								RST_N					;				//系统复位输入

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
                                                
reg		[15:0]			sdram_data				;			//写入SDRAM的数据
wire	[19:0]			sdram_addr				;			
										        

wire					write_en				;
wire					read_en					;
															
wire					write_req				;
wire					read_req				;

wire					fifo_rd_req				;
wire					fifo_wd_req				;

wire					write_ack				;
wire					read_ack				;


initial begin
	S_CLK = 1'b1 ;
	RST_N = 1'b0 ;
	#100 RST_N = 1'B0 ;
	RST_N = 1'B1 ;
end 

always #25 S_CLK = ~ S_CLK ;

// assign sdram_data = 16'haffa ;
assign	image_rd_en = 1'b1 ;
assign	vga_rd_req = 1'b1 ;

//模拟产生数据
always@(posedge S_CLK or negedge RST_N) begin
	if(!RST_N)	begin
		sdram_data <= 'b0 ;
	end
	else begin
		if(fifo_rd_req) begin
			sdram_data <= sdram_data + 1'b1 ;
		end
	end
end


SDRAM_CTRL	SDRAM_CTRL_inst(
.S_CLK					(S_CLK			),				//系统时钟
.RST_N					(RST_N			),				//系统复位输入
                        
.image_rd_en			(image_rd_en	),
.vga_rd_req				(vga_rd_req		),
.addr					(sdram_addr		),
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
                                         
	.sdram_data				(sdram_data	),			//写入SDRAM的数据
	.sdram_addr				(sdram_addr	),			

	.write_req				(write_en		),
	.read_req				(read_en		),
	.fifo_rd_req			(fifo_rd_req	),
	.fifo_wd_req			(fifo_wd_req 	),
	.write_ack				(write_ack		),
	.read_ack				(read_ack		)
	
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

























endmodule