`timescale 1ns / 1ns
module SDRAM_init(
		input						S_CLK					,				//系统时钟
		input						RST_N					,				//系统复位输入

		output	reg		[4:0]		init_cmd				,			
		output		 	[11:0]		init_addr				,

		output	reg 				flag_init								//初始化完成信号
);
//--------------------------------------------------------
//--内部信号
//--------------------------------------------------------
reg		[11:0]		cnt_200us		;				//200us起始等待时间计数器
wire				flag_200us		;				//200us计时完成信号
reg		[3:0]		step_cnt		;				//步骤计数器
//--------------------------------------------------------
//--参数定义
//--------------------------------------------------------
`define	cnt_200us_num	4000 				//200us计数个数
//CS RAS CAS WE
localparam	MRS = 5'B10000	,NOP = 5'B10111 ,	PREC = 5'B10010	,AREF = 5'B10001;


//--------------------------------------------------------
//--200us定时
//--------------------------------------------------------
always@(posedge S_CLK or negedge RST_N)begin
	if(!RST_N)	begin
		cnt_200us <= 'b0;
	end
	else begin
		if(cnt_200us == `cnt_200us_num)	begin
			cnt_200us 	<= `cnt_200us_num ;
		end
		else begin
			cnt_200us <= cnt_200us + 1'b1 ;
		end
	end
end
//--输出定时标志
assign	flag_200us = (cnt_200us == `cnt_200us_num) ? 1'b1 : 1'b0 ;
//--------------------------------------------------------
//--输出初始化配置命令
//--------------------------------------------------------
always@(posedge S_CLK or negedge RST_N)begin
	if(!RST_N)	begin
		init_cmd <= NOP ;
		step_cnt <= 'b0 ;
		flag_init <= 1'b0 ;
	end
	else	begin
		if(flag_200us && (flag_init == 1'b0))	begin
			case(step_cnt)
				0 :begin
					init_cmd <= PREC ;
				end
				1 ,3:begin
					init_cmd <= AREF ;
				end
				5 :begin
					init_cmd <= MRS ;
				end
				6 :begin
					flag_init <= 1'b1 ;
					init_cmd <= NOP ;
				end
				default :begin
					init_cmd <= NOP ;
				end
			endcase
			step_cnt <= step_cnt + 1'b1 ;
		end
	end
end
//地址线命令输出
assign init_addr = (init_cmd == MRS) ? 12'b0100_0010_0010 : 12'b0100_0000_0000 ;






















endmodule
