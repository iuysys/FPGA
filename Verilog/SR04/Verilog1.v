
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

//reg TRIG_n;								//触发使能的下一个状态
reg ECHO_s;					//		

reg [15:0] distance;
reg START_n;	
reg [7:0] STATE;
reg [7:0] STATE_n;

reg [15:0] TRIG_CNT;

reg [15:0] DIS_CNT_n;
//-----------------------------------------------------
//	--	常量声明
//-----------------------------------------------------
parameter STATE_IDLE = 8'h00,STATE_TRIG = 8'h01,STATE_WAIT = 8'h02;

//-----------------------------------------------------
//	--	处理外部单片机的测距请求
//-----------------------------------------------------
always@(posedge CLK or negedge RST_N)
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

always@(posedge CLK)
begin
	case(STATE)
		STATE_IDLE :
			if(START_n) STATE_n <= STATE_TRIG;

		STATE_TRIG :
			if(TRIG_CNT > 100) STATE_n <= STATE_WAIT;

		STATE_WAIT :
			if(ECHO_s) STATE_n <= STATE_IDLE;
	endcase

end
//-----------------------------------------------------
//	--	触发时间计时
//-----------------------------------------------------
always@(posedge CLK or negedge RST_N)
begin
	if(!RST_N)
		TRIG_CNT <= 16'b0;
	else if(STATE == STATE_TRIG)
	begin
		TRIG_CNT <= TRIG_CNT + 1'b1;
	end
	else
		TRIG_CNT <= 16'b0;
end



//-----------------------------------------------------
//	--	输出触发信号
//-----------------------------------------------------
assign TRIG = (STATE == STATE_TRIG) ? 1'b1 :1'b0;
//-----------------------------------------------------
//	--	获取SR04高电平返回信号
//-----------------------------------------------------


//always@(posedge ECHO or negedge RST_N)
//begin
//	if(!RST_N)
//		ECHO_s <= 1'b0;
//	else if(ECHO && STATE == STATE_WAIT)
//	begin
//		ECHO_s <= 1'b1;
//		distance <= DIS_CNT_n;
//	end
//	else 
//		ECHO_s <= 1'b0;
//end
//-----------------------------------------------------
//	--	计算SR04高电平返回的时间
//-----------------------------------------------------
always@(posedge CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		DIS_CNT_n <= 16'b0;
		ECHO_s <= 1'b0;
	end
	else if(ECHO && STATE == STATE_WAIT)
	begin
		DIS_CNT_n <= DIS_CNT_n +1'b1;
		ECHO_s <= 1'b1;
	end
	else if(ECHO_s)
	begin
		distance <= DIS_CNT_n;
	end
	else
	begin
		DIS_CNT_n <= 16'b0;
		ECHO_s <= 1'b0;
	end
end
endmodule






















