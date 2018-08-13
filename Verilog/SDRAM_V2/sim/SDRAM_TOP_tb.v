`timescale 1ns / 100ps

module SDRAM_TOP_tb();


reg						clk						;
reg						rst_n					;
wire					sdram_clk_in			;

wire					w_fifo_wreq				;
reg						w_fifo_wclk				;
reg		[15:0]			sys_w_data				;
wire	[10:0]			w_fifo_wusedw			;


wire					r_fifo_rreq				;	
reg						r_fifo_rclk				;
wire	[15:0]			sys_r_data				;
wire	[10:0]			r_fifo_rusedw			;

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
                                                





//---------------------------------------------------
//-- 
initial begin
	clk <= 1'b1 ;
	rst_n <= 1'b1 ;
	w_fifo_wclk <= 1'b0 ;
	r_fifo_rclk <= 1'b0 ;
	sys_w_data <= 'b0 ;
	#100 rst_n <= 1'B0 ;
	#100 rst_n <= 1'B1 ;
end 
//---------------------------------------------------
//-- 
always #5 clk = ~ clk ;
//---------------------------------------------------
//-- 
assign sdram_clk_in = ~clk ;


//写fifo的写时钟
always begin 
	#25 w_fifo_wclk = 1'b1 ;		 
	#25 w_fifo_wclk = 1'b0 ;
end

//模拟摄像头产生数据
always@(posedge w_fifo_wclk or negedge rst_n) begin
	if(!rst_n)	begin
		sys_w_data <= 'b0 ;
	end
	else begin
		if(w_fifo_wusedw == 256 ) begin
			sys_w_data <= 'b0 ;
		end
		else begin
			sys_w_data <= sys_w_data + 1'b1 ;
		end
	end
end
assign w_fifo_wreq = (w_fifo_wusedw <= 1024) ? 1'b1 : 1'b0 ;
//---------------------------------------------------
//-- 模拟VGA读数据

always begin 
	#12 r_fifo_rclk = 1'b1 ;		 
	#12 r_fifo_rclk = 1'b0 ;
end

assign r_fifo_rreq = (r_fifo_rusedw >256) ? 1'b1 : 1'b0 ;





sdram_2port_top	sdram_2port_top_inst(
.clk			(clk					),
.rst_n			(rst_n					),
.sdram_clk_in	(sdram_clk_in			),
//write fifo interface
.w_fifo_wreq	(w_fifo_wreq			),
.w_fifo_wclk	(w_fifo_wclk			),
.sys_w_data		(sys_w_data				),
.w_fifo_wusedw	(w_fifo_wusedw			),
//read fifo interface
.r_fifo_rreq	(r_fifo_rreq			),
.r_fifo_rclk	(r_fifo_rclk			),
.sys_r_data		(sys_r_data				),
.r_fifo_rusedw	(r_fifo_rusedw			),
//sdram interface		
.SDRAM_CLK		(SDRAM_CLK				),
.SDRAM_CKE		(SDRAM_CKE				),
.SDRAM_CS		(SDRAM_CS				),
.SDRAM_RAS		(SDRAM_RAS				),
.SDRAM_CAS		(SDRAM_CAS				),
.SDRAM_WE		(SDRAM_WE				),
.SDRAM_BANK		(SDRAM_BANK				),
.SDRAM_DQ 		(SDRAM_DQ 				),
.SDRAM_DQM		(SDRAM_DQM				),
.SDRAM_ADDR		(SDRAM_ADDR				)


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