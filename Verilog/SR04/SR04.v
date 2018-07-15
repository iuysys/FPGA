
module SR04(
	//输入
	CLK,RST_N,START,ECHO,
	//输出
	TRIG,DISTANCE
	
);

//-----------------------------------------------------
//	--	外部信号
//-----------------------------------------------------
input  	CLK;							//时钟
input		RST_N;						//复位
input  	START;						//外部单片机控制启动测距
output  	TRIG;							//触发信号,模块上的trig引脚
input  	ECHO;							//接收返回时间,模块上的echo引脚
output 	[15:0] 	DISTANCE;		//输出距离,单位:CM
//-----------------------------------------------------
//	--	内部信号
//-----------------------------------------------------

//reg TRIG_n;								//触发使能的下一个状态
reg ECHO_n;					//		


reg START_n;	
reg [7:0] STATE;
reg [7:0] STATE_n;

reg [15:0] TRIG_CNT;

reg [15:0] DIS_CNT;
reg [15:0] DIS_CNT_n;
//-----------------------------------------------------
//	--	常量声明
//-----------------------------------------------------
parameter [7:0] STATE_IDLE = 8'h00,STATE_TRIG = 8'h01,STATE_WAIT = 8'h02;

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
//-----------------------------------------------------
//	--	
//-----------------------------------------------------
always@(*)
begin
	case(STATE)
		STATE_IDLE :
		
			if(START_n) STATE_n = STATE_TRIG;
			else STATE_n = STATE_IDLE;

		STATE_TRIG :
		
			if(TRIG_CNT == 100) STATE_n = STATE_WAIT;
			else STATE_n = STATE_TRIG;
			
		STATE_WAIT :
			if(ECHO_n && !ECHO) STATE_n = STATE_IDLE;
			else STATE_n = STATE_WAIT;
		default :  
			STATE_n = STATE_IDLE;
	endcase

end
//-----------------------------------------------------
//	--	触发时间计时
//-----------------------------------------------------
always@(posedge CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		TRIG_CNT <= 16'b0;
		DIS_CNT <= 16'b0;
		DIS_CNT_n <= 16'b0;
	end
	else if(STATE == STATE_TRIG)
	begin
		if(TRIG_CNT == 100)
			TRIG_CNT <= 16'b0;
		else
			TRIG_CNT <= TRIG_CNT + 1'b1;
	end
	else if(STATE == STATE_WAIT)
	begin
		if(ECHO )
		begin
			DIS_CNT_n <= DIS_CNT_n +1'b1;
			ECHO_n <= 1'b1;
		end
		else if(ECHO_n && !ECHO)
		begin
			ECHO_n <= 1'b0;
			DIS_CNT <= DIS_CNT_n ;
		end
		else
		begin
			DIS_CNT_n <= 16'b0;
		end
	end
end



//-----------------------------------------------------
//	--	输出触发信号
//-----------------------------------------------------
assign TRIG = (STATE == STATE_TRIG) ? 1'b1 :1'b0;

//-----------------------------------------------------
//	--	输出触发信号
//-----------------------------------------------------
assign DISTANCE = DIS_CNT * 170 / 10_000 ;


endmodule






















