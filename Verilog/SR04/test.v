
module SR04(
	//输入
	CLK,RST_N,START,ECHO,
	//输出
	TRIG,distance
	
);

//-----------------------------------------------------
//	--	外部信号
//-----------------------------------------------------
input  	CLK;							//时钟
input		RST_N;						//复位
input  	START;						//外部单片机控制启动测距
output  	TRIG;							//触发信号,模块上的trig引脚
input  	ECHO;							//接收返回时间,模块上的echo引脚
output 	[15:0] 	distance;		//输出距离,单位:CM
//-----------------------------------------------------
//	--	内部信号
//-----------------------------------------------------

reg TRIG_n;								//触发使能的下一个状态
reg ECHO_s,ECHO_e;					//		

reg [15:0] distance;
reg START_n;	
reg [7:0] STATE;
reg [7:0] STATE_n;

reg [15:0] TRIG_CNT;

reg [15:0] DIS_CNT_n;
//-----------------------------------------------------
//	--	常量声明
//-----------------------------------------------------
parameter STATE_IDLE = 8'h00,STATE_BEGIN = 8'h01,STATE_TRIG = 8'h02,STATE_WAIT = 8'h04;

//-----------------------------------------------------
//	--	处理外部单片机的测距请求
//-----------------------------------------------------
always@(negedge START or negedge RST_N )
begin
	if(!RST_N)
		START_n <= 1'b0;	
	else if((!START) && STATE == STATE_IDLE)
		START_n <= 1'b1;	
	else
		START_n <= 1'b0;
end


//-----------------------------------------------------
//	--	给STATE 寄存器赋值
//-----------------------------------------------------
always@(posedge CLK or negedge RST_N)
begin
	if(!RST_N)
		STATE <= STATE_IDLE;
	else
		STATE <= STATE_n;
end

always@(*)
begin
	case(STATE)
		STATE_IDLE :
			if(START_n) STATE_n <= STATE_BEGIN;
			else STATE_n <= STATE_IDLE;
		STATE_BEGIN :
			if(TRIG_n) STATE_n <= STATE_TRIG;
			else STATE_n <= STATE_BEGIN;
		STATE_TRIG :
			if(TRIG_CNT > 100) STATE_n <= STATE_WAIT;
			else STATE_n <= STATE_TRIG;
		STATE_WAIT :
			if(ECHO_e) STATE_n <= STATE_IDLE;
	endcase

end
//-----------------------------------------------------
//	--	状态处理
//-----------------------------------------------------
always@(*)
begin
	if(!RST_N)
		TRIG_CNT <= 16'b0;
	else	
		case(STATE)
			STATE_BEGIN://开始触发SR04
			begin
				TRIG_n <= 1'b1;
			end
			STATE_TRIG ://计算触发时间	
			begin
				if(TRIG_CNT > 100)
				begin
					TRIG_CNT <= 16'b0;
					
				end
				else
					TRIG_CNT <= TRIG_CNT + 1'b1;	
			end
			STATE_WAIT://等待返回信号,并计算
			begin
				TRIG_n <= 1'b0;
			end
		endcase
end



//-----------------------------------------------------
//	--	输出触发信号
//-----------------------------------------------------
assign TRIG = TRIG_n;
//-----------------------------------------------------
//	--	获取SR04高电平返回信号
//-----------------------------------------------------
//always@(*)
//begin
//	if(STATE == STATE_WAIT)
//	begin
//		if(ECHO)
//		begin
//			ECHO_s <= 1'b1;
//		end
//		else if((!ECHO) && ECHO_s)
//		begin
//			ECHO_e <= 1'b1;
//			distance <= DIS_CNT_n ;// * 170/10000
//		end
//	end
//	else
//	begin
//		ECHO_s <= 1'b0;
//		ECHO_e <= 1'b0;
//	end
//	
//end


always@(posedge ECHO or negedge RST_N)
begin
	if(!RST_N)
		ECHO_s <= 1'b0;
	else if(ECHO && STATE == STATE_WAIT)
		ECHO_s <= 1'b1;
	else
		ECHO_s <= 1'b0;
end
always@(negedge ECHO or negedge RST_N)
begin
	if(!RST_N)
		ECHO_e <= 1'b0;
	else if(!ECHO && STATE == STATE_WAIT)
	begin
		ECHO_e <= 1'b1;
		distance <= DIS_CNT_n;
	end
	else 
		ECHO_e <= 1'b0;
end
//-----------------------------------------------------
//	--	计算SR04高电平返回的时间
//-----------------------------------------------------
always@(posedge CLK or negedge RST_N)
begin
	if(!RST_N)
		DIS_CNT_n <= 16'b0;
	else if(ECHO_e && STATE == STATE_WAIT)
	begin
		DIS_CNT_n <= DIS_CNT_n +1'b1;
	end
	else
		DIS_CNT_n <= 16'b0;

end
endmodule






















