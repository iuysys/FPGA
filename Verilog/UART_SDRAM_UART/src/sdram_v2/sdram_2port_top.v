`timescale 1ns / 1ps
//---------------------------------------------------
//-- 
`include "F:/FPGA/Verilog/SDRAM_V2/src/sdram_para.v"

module sdram_2port_top(
input 	 						clk			,
input							rst_n		,
input							sdram_clk_in,

//write fifo interface
input							w_fifo_wreq	,
input							w_fifo_wclk	,
input				[15:0]		sys_w_data	,
output 				[10:0]		w_fifo_wusedw	,
//read fifo interface
input							r_fifo_rreq	,
input							r_fifo_rclk	,
output				[15:0]		sys_r_data	,
output				[10:0]		r_fifo_rusedw	,
//sdram interface		
output									SDRAM_CLK	,
output									SDRAM_CKE	,
output									SDRAM_CS	,
output									SDRAM_RAS	,
output									SDRAM_CAS	,
output									SDRAM_WE	,
output				[`BANKSIZE-1:0]		SDRAM_BANK	,
inout				[`DATASIZE-1:0]		SDRAM_DQ 	,
output				[`DQMSIZE-1:0]		SDRAM_DQM	,
output				[`ROWSIZE-1:0]		SDRAM_ADDR	


);

//---------------------------------------------------
//-- 
//---------------------------------------------------

wire  				[10:0]				w_fifo_rusedw	;
wire				[10:0]				r_fifo_wusedw	;


wire									w_fifo_rclk		;
wire                                    w_fifo_rreq     ;

wire									r_fifo_wclk		;
wire									r_fifo_wreq		;

wire				[15:0]				w_fifo_rdata	;
wire				[15:0]				r_fifo_wdata	;

wire                                    sdram_init_done ;

wire									sys_w_req		;
wire									sys_r_req		;
wire				[21:0]				sys_wr_addr		;
wire				[21:0]				sys_addr		;
wire									cmd_ack			;
wire				[1:0]				ctrl_cmd		;

wire									dq_oe			;

reg					[21:0]				write_addr		;
reg					[21:0]				read_addr		;
reg										bank_flag		;
reg										read_en			;
reg										read_flag		;
reg										write_flag		;

reg										m_w_req			;
reg										m_r_req			;


//---------------------------------------------------
//-- 
//---------------------------------------------------
`define 	BUFF_SIZE		16

//---------------------------------------------------
//-- 
//---------------------------------------------------
assign      SDRAM_CLK = sdram_clk_in ;
assign      SDRAM_DQM = 2'b00 ;
assign 		sys_wr_addr = sys_w_req ? write_addr : read_addr ;

assign		sys_w_req = m_w_req ;
assign 		sys_r_req = m_r_req	;

assign   	w_fifo_rclk = clk ;
assign		r_fifo_wclk	= ~clk ;

assign     	SDRAM_DQ = dq_oe ? w_fifo_rdata : 16'bz ;
assign		r_fifo_wdata = SDRAM_DQ ;


//---------------------------------------------------
//-- 鑷姩璇诲啓鎺у埗
//---------------------------------------------------
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin
    	bank_flag <= 'b0 ;
    	write_addr <= 'b0 ;
    	read_addr <= 'b0 ;
    	write_flag <= 'b0 ;
    	read_flag <= 'b0 ;
    	m_w_req <= 'b0 ;
    	m_r_req <= 'b0 ;
    	read_en <= 'b0 ;
    end
    else if (write_flag) begin
    	if (cmd_ack) begin
    		m_w_req <= 'b0 ;
    		write_flag <= 'b0 ;
    		if(write_addr[19:0] == `BUFF_SIZE - `BURST_LENGTH) begin
    			bank_flag <= ~bank_flag ;
    			write_addr <= {~bank_flag,{21{1'b0}}} ;
    		end
    		else begin
    			write_addr <= write_addr + 22'd`BURST_LENGTH ;
    		end

    		if (write_addr == `BUFF_SIZE - `BURST_LENGTH) begin
    			read_en <= 'b1 ;
    		end
    	end
    	else begin
    		m_w_req <= 'b1 ;
    	end
    end
    else if (read_flag) begin
    	if (cmd_ack) begin
    		m_r_req <= 'b0 ;
    		read_flag <= 'b0 ;
    		if(read_addr[19:0] == `BUFF_SIZE - `BURST_LENGTH) begin
    			read_addr[19:0] <= 'b0 ;
    		end
    		else begin
    			read_addr[19:0] <= read_addr[19:0] + 20'd`BURST_LENGTH ;
    		end
    	end
    	else begin
    		m_r_req <= 'b1 ;
    	end

    	if (bank_flag) begin
    		read_addr[21:20] <= 2'b00 ;
    	end
    	else begin
    		read_addr[21:20] <= 2'b10 ;
    	end
    end
    else if (ctrl_cmd == 'b00) begin
    	if (w_fifo_rusedw >= `BURST_LENGTH) begin
    		write_flag <= 'b1 ;
    	end
    	else if(r_fifo_wusedw <= `BURST_LENGTH && read_en) begin
    		read_flag <= 'b1 ;
    	end
    end
    
end





//------------------------------------ ---------------
//-- 
sdram_fifo		sdram_fifo_write(
.data			(sys_w_data					),
.rdclk			(w_fifo_rclk				),
.rdreq			(w_fifo_rreq				),
.wrclk			(w_fifo_wclk				),
.wrreq			(w_fifo_wreq				),
.q				(w_fifo_rdata				),
.rdusedw		(w_fifo_rusedw				),
.wrusedw		(w_fifo_wusedw				)
);

//---------------------------------------------------
//-- 
sdram_fifo 		sdram_fifo_read(
.data			(r_fifo_wdata				),
.rdclk			(r_fifo_rclk				),
.rdreq			(r_fifo_rreq				),
.wrclk			(r_fifo_wclk				),
.wrreq			(r_fifo_wreq				),
.q				(sys_r_data					),
.rdusedw		(r_fifo_rusedw				),
.wrusedw		(r_fifo_wusedw				)
);

//---------------------------------------------------
//-- 
sdram_ctrl		sdram_ctrl_inst(
.clk			(clk						),
.rst_n			(rst_n						),

.sys_w_req		(sys_w_req					),
.sys_r_req		(sys_r_req					),
.sys_wr_addr	(sys_wr_addr				),


.sdram_init_done(sdram_init_done			),
.cmd_ack		(cmd_ack					),
.ctrl_cmd		(ctrl_cmd					),
.sys_addr 		(sys_addr					)	
);


//---------------------------------------------------
//-- 
sdram_cmd		sdram_cmd_inst(
.clk			(clk					),
.rst_n			(rst_n					),
.ctrl_cmd		(ctrl_cmd				),
.sys_addr		(sys_addr				),
// .cmd_busy		(					),
.cmd_ack		(cmd_ack				),

.dq_oe			(dq_oe					),					//鏁版嵁绾夸笁鎬佹帶鍒
	
.sdram_init_done(sdram_init_done		),
			
//鍐檉ifo		
.w_fifo_rreq 	(w_fifo_rreq			),
//璇籪ifo			
.r_fifo_wreq	(r_fifo_wreq			),
		
//sdram					
.SDRAM_CKE		(SDRAM_CKE				),
.SDRAM_CS		(SDRAM_CS				),
.SDRAM_RAS		(SDRAM_RAS				),
.SDRAM_CAS		(SDRAM_CAS				),
.SDRAM_WE		(SDRAM_WE				),
.SDRAM_BANK		(SDRAM_BANK				),
.SDRAM_ADDR		(SDRAM_ADDR				)					
);


endmodule	

