`timescale 1ns / 100ps
//---------------------------------------------------
//-- 
`include "F:/FPGA/Verilog/SDRAM_V2/src/sdram_para.v"
//---------------------------------------------------
//-- 
module sdram_cmd(
input 									clk			,
input									rst_n		,
				
input				[1:0]				ctrl_cmd	,
input				[21:0]				sys_addr	,
// output									cmd_busy	,
output		reg							cmd_ack		,

output									dq_oe		,					//鏁版嵁绾夸笁鎬佹帶鍒
	
output		reg							sdram_init_done	,

//鍐檉ifo
output		reg							w_fifo_rreq ,
//璇籪ifo
output		reg							r_fifo_wreq	,
			
//sdram			
output									SDRAM_CKE	,
output									SDRAM_CS	,
output									SDRAM_RAS	,
output									SDRAM_CAS	,
output									SDRAM_WE	,
output				[`BANKSIZE-1:0]		SDRAM_BANK	,
output				[`ROWSIZE-1:0]		SDRAM_ADDR						
);



//---------------------------------------------------
//-- 
//---------------------------------------------------
reg				[15:0]				power_on_wait_cnt	;
wire								flag_power_on_wait	;
reg				[8:0]				step_cnt			;
reg				[4:0]				m_cmd				;
reg				[1:0]				m_bank 				;
reg				[11:0]				m_addr 				;
reg				[10:0]				aref_time_cnt		;
reg									aref_req			;

reg									do_aref				;
reg									do_write			;
reg									do_read				;

wire			[`BANKSIZE-1:0]		sys_bank			;
wire 			[`ROWSIZE-1:0]		sys_row				;
wire			[`COLSIZE-1:0]		sys_col				;



//---------------------------------------------------
//-- 
//---------------------------------------------------
assign {SDRAM_CKE,SDRAM_CS,SDRAM_RAS,SDRAM_CAS,SDRAM_WE} = m_cmd ;
assign SDRAM_BANK = m_bank ;
assign SDRAM_ADDR = m_addr ;
//---------------------------------------------------
//-- 
assign sys_bank = sys_addr[21:20];
assign sys_row = sys_addr[19:8];
assign sys_col = sys_addr[7:0];
//---------------------------------------------------
//-- 
//assign cmd_busy = (do_write || do_read) ? 1'b1 : 1'b0 ;
//---------------------------------------------------
//-- 
assign dq_oe = (do_write) ? 1'b1 : 1'b0 ;

//---------------------------------------------------
//-- 
//---------------------------------------------------
//---------------------------------------------------
//-- 涓婄數绛夊緟200us
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin
    	power_on_wait_cnt <= 'b0 ;
    end
    else if(power_on_wait_cnt < `POWER_ON_WAIT_TIME)begin
    	power_on_wait_cnt <= power_on_wait_cnt + 1'b1 ;
    end
end
//---------------------------------------------------
//-- 
assign	flag_power_on_wait = (power_on_wait_cnt == `POWER_ON_WAIT_TIME) ? 1'b1 : 1'b0 ;
//---------------------------------------------------
//-- 
//---------------------------------------------------
//---------------------------------------------------
//-- 鑷埛鏂板懆鏈熻鏁
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin
    	aref_time_cnt <= 'b0 ;
    end
    else if(aref_time_cnt < `AUTO_REF_TIME && flag_power_on_wait && sdram_init_done)begin
    	aref_time_cnt <= aref_time_cnt + 1'b1 ;
    end
    else begin
    	aref_time_cnt <= 'b0 ;
    end
end
//---------------------------------------------------
//-- 
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin
    	aref_req <= 'b0 ;
    end
    else if(aref_time_cnt == `AUTO_REF_TIME) begin
    	aref_req <= 'b1 ;
    end
    else if (do_aref) begin
    	aref_req <= 'b0 ;
    end
end

//---------------------------------------------------
//-- 
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin
    	step_cnt <= 'b0 ;
    	sdram_init_done <= 'b0 ;
    	m_cmd <= `NOP ;
    	m_bank <= 'b00 ;
    	m_addr <= 12'b0000_0000_0000 ;
    	do_write <= 'b0 ;
    	do_read <= 'b0 ;
    	do_aref <= 'b0 ;
    	cmd_ack <= 'b0 ;
    	w_fifo_rreq <= 'b0 ;
    	r_fifo_wreq <= 'b0 ;
    end
    else if (!sdram_init_done && flag_power_on_wait) begin		//鍒濆鍖
    		if(step_cnt == 'd0) begin
    			step_cnt <= step_cnt + 1'b1 ;
    			m_cmd <= `PRE ;
    			m_bank <= 'b00 ;
    			m_addr <= 12'b0100_0000_0000 ;
    		end
    		else if (step_cnt == `Trp || step_cnt == `Trp + `Trc) begin
    			step_cnt <= step_cnt + 1'b1 ;
    			m_cmd <= `AREF ;
    		end
    		else if (step_cnt == `Trp + 2*`Trc) begin
    			step_cnt <= step_cnt + 1'b1 ;
    			m_cmd <= `MRS ;
    			m_bank <= 2'b00 ;
    			m_addr <= {	
    						2'b00,
    						1'b0,			//OP code
    						2'b00,
    						3'b010,			//CL
    						1'b0,			//BT
    						3'b010			//BL
    					};
    		end
    		else if (step_cnt == `Trp + 2*`Trc + `Tmrd) begin
    			step_cnt <= 'b0 ;
    			sdram_init_done <= 1'b1 ;
    		end
    		else begin
    			step_cnt <= step_cnt + 1'b1 ;
    			m_cmd <= `NOP ;
    			m_bank <= 'b00 ;
    			m_addr <= 12'b0100_0000_0000 ;
    		end
    end
    else if ((aref_req || do_aref) && !do_write && !do_read ) begin				//鑷埛鏂涓婁竴鐘舵€佷笉鑳戒负璇绘垨鑰呭啓
    	if (step_cnt == 'd0) begin
    		step_cnt <= step_cnt + 1'b1 ;
    		do_aref <= 1'b1 ;
    		m_cmd <= `PRE ;
    		m_bank <= 'b00 ;
    		m_addr <= 12'b0100_0000_0000 ;
    	end
    	else if(step_cnt == `Trp || step_cnt == `Trp + `Trc) begin
    		step_cnt <= step_cnt + 1'b1 ;
    		m_cmd <= `AREF ;
    	end
	    else if(step_cnt == `Trp + 2*`Trc) begin
	    	step_cnt <= 'b0 ;
	    	do_aref <= 'b0 ;
	    end
	    else begin
	    	step_cnt <= step_cnt + 1'b1 ;
    		m_cmd <= `NOP ;
    		m_bank <= 'b00 ;
    		m_addr <= 12'b0000_0000_0000 ;
	    end
	end
	else if ((ctrl_cmd == 'b01 && sdram_init_done) || do_write) begin									//绐佸彂鍐
		if (step_cnt == 'd0) begin
			step_cnt <= step_cnt + 1'b1 ;
			do_write <= 1'b1 ;
    		m_cmd <= `PRE ;
    		m_bank <= sys_bank ;
    		m_addr <= 12'b0100_0000_0000 ;
    	end
    	else if (step_cnt == `Trp) begin
    		step_cnt <= step_cnt + 1'b1 ;
    		m_cmd <= `ACT ;
    		m_bank <= sys_bank ;
    		m_addr <= sys_row ;
    	end
    	else if (step_cnt == `Trp + `Trcd -1) begin						//鎻愬墠涓€涓椂閽熷彂鍑哄啓fifo鐨勮璇锋眰
    		step_cnt <= step_cnt + 1'b1 ;
    		w_fifo_rreq <= 1'b1 ;
    		m_cmd <= `NOP ;
    	end
    	else if (step_cnt == `Trp + `Trcd) begin
    		step_cnt <= step_cnt + 1'b1 ;
    		m_cmd <= `WRITE ;
    		m_bank <= sys_bank ;
    		m_addr <= sys_col ;
    	end
    	else if (step_cnt == `Trp + `Trcd + `BURST_LENGTH -1) begin		//鍙栨秷鍐檉ifo鐨勮璇锋眰
    		step_cnt <= step_cnt + 1'b1 ;
    		w_fifo_rreq <= 'b0 ;
    		cmd_ack <= 1'b1 ;
    		// do_write <= 'b0 ;
    	end
    	else if (step_cnt == `Trp + `Trcd + `BURST_LENGTH ) begin		
    		step_cnt <= 'b0 ;
    		cmd_ack <= 'b0 ;
    		do_write <= 'b0 ;
    		m_cmd <= `NOP ;
    		m_bank <= 'b00 ;
    		m_addr <= 12'b0000_0000_0000 ;
    	end
    	else begin
    		step_cnt <= step_cnt + 1'b1 ;
    		m_cmd <= `NOP ;
    		m_bank <= 'b00 ;
    		m_addr <= 12'b0100_0000_0000 ;
    	end
	end
	else if ((ctrl_cmd == 'b10 && sdram_init_done) || do_read) begin					//绐佸彂璇
		if (step_cnt == 'd0) begin														//棰勫厖鐢
			step_cnt <= step_cnt + 1'b1 ;
			do_read <= 1'b1 ;
    		m_cmd <= `PRE ;
    		m_bank <= 'b00 ;
    		m_addr <= 12'b0100_0000_0000 ;
    	end
    	else if (step_cnt == `Trp) begin												//婵€娲昏
    		step_cnt <= step_cnt + 1'b1 ;
    		m_cmd <= `ACT ;
    		m_bank <= sys_bank ;
    		m_addr <= sys_row ;
    	end
    	else if (step_cnt == `Trp + `Trcd) begin										//鍙戝嚭璇诲懡浠
    		step_cnt <= step_cnt + 1'b1 ;
    		m_cmd <= `READ ;
    		m_bank <= sys_bank ;														
    		m_addr <= sys_col ;
    	end
    	else if (step_cnt == `Trp + `Trcd + `CAS_LATENCY) begin							//绛夊緟娼滀紡鏈熷悗,鍙戝嚭璇籪ifo鐨勫啓璇锋眰
    		step_cnt <= step_cnt + 1'b1 ;
    		r_fifo_wreq <= 1'b1 ;
    	end
    	else if (step_cnt == `Trp + `Trcd + `CAS_LATENCY + `BURST_LENGTH - 1) begin		//鍙栨秷璇籪ifo鐨勫啓璇锋眰
    		step_cnt <= step_cnt + 1'b1 ;
    		cmd_ack <= 1'b1 ;
    		// do_read <= 'b0 ;
    	end
    	else if (step_cnt == `Trp + `Trcd + `CAS_LATENCY + `BURST_LENGTH) begin			//缁撴潫绐佸彂璇
    		step_cnt <= step_cnt + 1'b1 ;
    		// r_fifo_wreq <= 'b0 ;
            r_fifo_wreq <= 'b0 ;
            cmd_ack <= 1'b1 ;
    		cmd_ack <= 'b0 ;
    		do_read <= 'b0 ;
    		m_cmd <= `NOP ;
    		m_bank <= 'b00 ;
    		m_addr <= 12'b0000_0000_0000 ;
    	end
    	else begin
    		step_cnt <= step_cnt + 1'b1 ;
    		m_cmd <= `NOP ;
    		m_bank <= 'b00 ;
    		m_addr <= 12'b0000_0000_0000 ;
    	end
    end
end

endmodule	

