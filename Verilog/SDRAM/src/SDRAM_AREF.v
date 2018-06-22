`timescale 1ns / 1ns
module SDRAM_AREF(
//system input
input							S_CLK				,
input							RST_N				,
//signal ioput
output		reg					aref_req			,	//自刷新请求
input							aref_en				,	//自刷新使能
output		reg					aref_ack			,	//自刷新应答
output		reg		[4:0]		aref_cmd			,	//命令寄存器
output		reg 	[11:0]		aref_addr			,	//地址线寄存器
input							flag_init				//初始化完成信号	
);
//---------------------------------------------------
//--
//---------------------------------------------------
//---------------------------------------------------
//--内部信号
//---------------------------------------------------
reg		[8:0]		aref_cnt ;							//自刷新计数器
reg		[3:0]		step_cnt ;												

//---------------------------------------------------
//--参数定义
//---------------------------------------------------
`define		AREF_CNT_NUM	300 						//自刷新周期计数值
localparam		NOP = 5'B10111 ,PREC = 5'B10010	,AREF = 5'B10001 ;

//---------------------------------------------------
//--自刷新周期计数
//---------------------------------------------------
always@(posedge S_CLK or negedge RST_N) begin
	if(!RST_N)	begin
		aref_cnt <= 'b0 ;
	end
	else if(flag_init)begin
		if(aref_cnt == `AREF_CNT_NUM) begin
			aref_cnt <= 'b0 ;
		end
		else begin
			aref_cnt <= aref_cnt + 1'b1 ;
		end
	end
end
//---------------------------------------------------
assign	flag_aref = (aref_cnt == `AREF_CNT_NUM) ? 1'b1 : 1'b0 ;
//---------------------------------------------------
always@(posedge S_CLK or negedge RST_N ) begin
	if(!RST_N)	begin
		aref_req <= 'b0 ;
	end
	else begin
		if(flag_aref) begin
			aref_req <= 1'b1 ;
		end
		else if(aref_en)begin
			aref_req <= 1'b0 ;
		end
	end
end
//---------------------------------------------------
always@(posedge S_CLK or negedge RST_N ) begin
	if(!RST_N)	begin
		aref_cmd <= NOP ;
		step_cnt <= 'b0 ;
		aref_ack <= 'b0 ;
	end
	else begin
		if(aref_en) begin
			case(step_cnt)
			0 :begin
				aref_cmd <= PREC ;
				aref_addr <= 12'b0100_0010_0010 ;
			end
			1 ,3:begin
				aref_cmd <= AREF ;
			end
			5 :begin
				aref_ack <= 1'b1 ;
			end
			default :begin
				aref_cmd <= NOP ;
				aref_addr <= 12'b0100_0000_0000 ;
			end

			endcase
			step_cnt <= step_cnt + 1'b1 ;
		end
		else begin
			aref_cmd <= NOP ;
			step_cnt <= 'b0 ;
			aref_ack <= 'b0 ;
		end
	end
end
//---------------------------------------------------
endmodule























