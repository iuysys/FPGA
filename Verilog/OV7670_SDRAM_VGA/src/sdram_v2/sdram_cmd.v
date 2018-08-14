`timescale 1ns / 1ps
//---------------------------------------------------
//-- 
`include "F:/FPGA/Verilog/OV7670_SDRAM_VGA/src/sdram_v2/sdram_para.v"
//---------------------------------------------------
//-- 
module sdram_cmd(
input 									clk			,                  //控制时钟输入    
input									rst_n		,                  //复位
				
input				[1:0]				ctrl_cmd	,                  //控制命令输入
input				[21:0]				sys_addr	,
// output									cmd_busy	,              //SDRAM忙标志
output		reg							cmd_ack		,                  //控制命令应答信号  

output									dq_oe		,				     //DQ输入输出控制
	
output		reg							sdram_init_done	,             //SDRAM初始化完成标志

//write fifo
output		reg							w_fifo_rreq ,                 //写入缓存请求
//read fifo
output		reg							r_fifo_wreq	,                 //读出缓存请求
			
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
//-- 内部信号
//---------------------------------------------------
reg				[15:0]				power_on_wait_cnt	;                //上电等待200us计时器
wire								flag_power_on_wait	;                //上电等待完成标志
reg				[8:0]				step_cnt			;                //步骤驱动计数器
reg				[4:0]				m_cmd				;                //SDRAM 命令寄存器
reg				[1:0]				m_bank 				;                //SDRAM bank寄存器
reg				[11:0]				m_addr 				;                //SDRAM 地址寄存器
reg				[10:0]				aref_time_cnt		;                //自刷新周期计数器
reg									aref_req			;                //自刷新请求

reg									do_aref				;                //执行自刷新标志
reg									do_write			;                //执行写操作标志
reg									do_read				;                //执行读操作标志

wire			[`BANKSIZE-1:0]		sys_bank			;                //从系统输入地址中分离出的bank信号
wire 			[`ROWSIZE-1:0]		sys_row				;
wire			[`COLSIZE-1:0]		sys_col				;



//---------------------------------------------------
//-- 组合逻辑
//---------------------------------------------------
//---------------------------------------------------
//-- 地址,命令输出
assign {SDRAM_CKE,SDRAM_CS,SDRAM_RAS,SDRAM_CAS,SDRAM_WE} = m_cmd ;
assign SDRAM_BANK = m_bank ;
assign SDRAM_ADDR = m_addr ;
//---------------------------------------------------
//-- 分离出bank,行,列地址
assign sys_bank = sys_addr[21:20];
assign sys_row = sys_addr[19:8];
assign sys_col = sys_addr[7:0];
//---------------------------------------------------
//-- 
//assign cmd_busy = (do_write || do_read) ? 1'b1 : 1'b0 ;
//---------------------------------------------------
//-- 输出DQking之信号
assign dq_oe = (do_write) ? 1'b1 : 1'b0 ;

//---------------------------------------------------
//-- 
//---------------------------------------------------
//---------------------------------------------------
//-- 上电等待200us
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
//-- 自刷新周期计数
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
//-- 等待自刷新模块的回复
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
//-- 控制模块
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
    else if (!sdram_init_done && flag_power_on_wait) begin		//初始化
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
    						3'b111			//BL
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
    			m_addr <= 12'b0000_0000_0000 ;
    		end
    end
    else if ((aref_req || do_aref) && !do_write && !do_read ) begin				//自刷新
    	if (step_cnt == 'd0) begin
    		step_cnt <= step_cnt + 1'b1 ;
    		do_aref <= 1'b1 ;
    		m_cmd <= `PRE ;
    		m_bank <= 'b00 ;
    		m_addr <= 12'b0100_0000_0000 ;
    	end
    	else if(step_cnt == `Trp || step_cnt == `Trp + `Trc) begin             //两次自刷新请求
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
	else if ((ctrl_cmd == 'b01 && sdram_init_done) || do_write) begin		//突发写
		if (step_cnt == 'd0) begin
			step_cnt <= step_cnt + 1'b1 ;
			do_write <= 1'b1 ;
    		m_cmd <= `ACT ;
    		m_bank <= sys_bank ;
    		m_addr <= sys_row ;
    	end
    	else if (step_cnt == `Trp + `Trcd -1) begin						//提前写命令一个时钟发出请求
    		step_cnt <= step_cnt + 1'b1 ;
    		w_fifo_rreq <= 1'b1 ;
    		m_cmd <= `NOP ;
    	end
    	else if (step_cnt == `Trp + `Trcd) begin                       //写命令,行,bank,数据同时送出
    		step_cnt <= step_cnt + 1'b1 ;
    		m_cmd <= `WRITE ;
    		m_bank <= sys_bank ;
    		m_addr <= sys_col ;								//
    	end
    	else if (step_cnt == `Trp + `Trcd + `BURST_LENGTH -1) begin		//结束写fifo的读请求
    		step_cnt <= step_cnt + 1'b1 ;
    		w_fifo_rreq <= 'b0 ;
    		cmd_ack <= 1'b1 ;
    		// do_write <= 'b0 ;
    		m_cmd <= `NOP ;
    		m_bank <= 'b00 ;
    		m_addr <= 12'b0000_0000_0000 ;
    	end
    	else if (step_cnt == `Trp + `Trcd + `BURST_LENGTH ) begin		
    		step_cnt <= 'b0 ;
    		cmd_ack <= 'b0 ;
    		do_write <= 'b0 ;
    		m_cmd <= `PRE ;
    		m_bank <= 'b00 ;
    		m_addr <= 12'b0100_0000_0000 ;
    	end
    	// else if (step_cnt == `Trp + `Trcd + `BURST_LENGTH + 1) begin	//发出命令应答	
    	// 	step_cnt <= 'b0 ;
    	// 	cmd_ack <= 'b1 ;
    	// 	do_write <= 'b0 ;
    	// 	m_cmd <= `NOP ;
    	// 	m_bank <= 'b00 ;
    	// 	m_addr <= 12'b0000_0000_0000 ;
    	// end
    	// else if (step_cnt == `Trp + `Trcd + `BURST_LENGTH + 2) begin	//结束写操作	
    	// 	step_cnt <= 'b0 ;
    	// 	cmd_ack <= 'b0 ;
    	// 	do_write <= 'b0 ;
    	// 	m_cmd <= `PRE ;
    	// 	m_bank <= 'b00 ;
    	// 	m_addr <= 12'b0100_0000_0000 ;
    	// end
    	else begin
    		step_cnt <= step_cnt + 1'b1 ;
    		m_cmd <= `NOP ;
    		m_bank <= 'b00 ;
    		m_addr <= 12'b0000_0000_0000 ;
    	end
	end
	else if ((ctrl_cmd == 'b10 && sdram_init_done) || do_read) begin					//突发读
		if (step_cnt == 'd0) begin												//
    		step_cnt <= step_cnt + 1'b1 ;
    		do_read <= 'b1 ;
    		m_cmd <= `ACT ;
    		m_bank <= sys_bank ;
    		m_addr <= sys_row ;
    	end
    	else if (step_cnt == `Trcd) begin										//
    		step_cnt <= step_cnt + 1'b1 ;
    		m_cmd <= `READ ;
    		m_bank <= sys_bank ;														
    		m_addr <= sys_col ;
    	end
    	else if (step_cnt == `Trcd + `CAS_LATENCY) begin							//
    		step_cnt <= step_cnt + 1'b1 ;
    		r_fifo_wreq <= 1'b1 ;
    	end
    	// else if (step_cnt == `Trp + `Trcd + `CAS_LATENCY + `BURST_LENGTH - 3) begin			//
    	// 	step_cnt <= step_cnt + 1'b1 ;
    	// 	m_cmd <= `PRE ;
    	// 	m_bank <= 'b00 ;
    	// 	m_addr <= 12'b0100_0000_0000 ;
    	// end
        else if (step_cnt == `Trp + `Trcd + `CAS_LATENCY + `BURST_LENGTH - `CAS_LATENCY) begin     //
            step_cnt <= step_cnt + 1'b1 ;
            r_fifo_wreq <= 'b0 ;
            // cmd_ack <= 1'b1 ;
            m_cmd <= `PRE ;
            m_bank <= 'b00 ;
            m_addr <= 12'b0100_0000_0000 ;
        end
    	else if (step_cnt == `Trp + `Trcd + `CAS_LATENCY + `BURST_LENGTH - 1) begin		//
    		step_cnt <= step_cnt + 1'b1 ;
            r_fifo_wreq <= 'b0 ;
    		cmd_ack <= 1'b1 ;
    		m_cmd <= `NOP ;
    		m_bank <= 'b00 ;
    		m_addr <= 12'b0000_0000_0000 ;
    	end
    	else if (step_cnt == `Trp + `Trcd + `CAS_LATENCY + `BURST_LENGTH) begin			//
    		step_cnt <= 'b0 ;
            
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
    else begin
        step_cnt <= 'b0 ;
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
end

endmodule	

