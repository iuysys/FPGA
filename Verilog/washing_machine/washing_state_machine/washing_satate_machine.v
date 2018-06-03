module washing_state_machine
(
	//system input
	CLK,RST_N,
	//signal input
	key,fangshui_flag,
	//output
	led_start,										//启动指示灯
	led_zhushui,									//注水指示灯
	led_motor_f,									//电机正传指示灯
	led_motor_o,									//电机反转指示灯
	led_fangshui,									//放水指示灯	
	led_tuoshui										//脱水指示灯
);
//-------------------------------------------------------
//-- 外部端口
//-------------------------------------------------------
input 							CLK;						//系统时钟20Mhz,周期50us
input								RST_N;					//全局复位
input				[2:0]			key;						//有按键扫描模块提供的按键信息
input 							fangshui_flag;			//由水位检测装置提供的信号,低电平代表放水完毕,高电平代表机箱水位仍高

output 			reg			led_start	;										//启动指示灯
output 			reg			led_zhushui	;										//注水指示灯
output 			reg			led_motor_f	;										//电机正传指示灯
output 			reg			led_motor_o	;										//电机反转指示灯
output 			reg			led_fangshui;										//放水指示灯	
output 			reg			led_tuoshui	;										//脱水指示灯
//-------------------------------------------------------
//-- 内部端口
//-------------------------------------------------------
reg				[2:0]			STATE;												//状态机寄存器
reg				[19:0]		time_cnt;											//时间计数器
reg				[4:0]			step_cnt1;											//步骤计数器1
reg				[1:0]			step_cnt2;											//步骤计数器2

//-------------------------------------------------------
//-- 常量定义
//-------------------------------------------------------
//定义系统时钟周期,单位:us
localparam system_period = 50000 ;			
//状态机常量
localparam IDLE = 3'd0 ,START = 3'D1 ,ZHUSHUI = 3'D2 ,XIDI = 3'D3 ,FANGSHUI = 3'D4 ,TUOSHUI = 3'D5 ,END = 3'D6;

//-------------------------------------------------------
//-- 状态机状态转换及输出
//-------------------------------------------------------
always@(posedge CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		STATE <= IDLE ;
		time_cnt <= 20'b0 ;
		step_cnt1 <= 5'b0 ;
		step_cnt2 <= 2'b0 ;
		led_start		=	1'b1;										//启动指示灯
		led_zhushui		=	1'b1;										//注水指示灯
		led_motor_f		=	1'b1;										//电机正传指示灯
		led_motor_o		=	1'b1;										//电机反转指示灯
		led_fangshui	=	1'b1;										//放水指示灯	
		led_tuoshui		=	1'b1;										//脱水指示灯
	end
	else
	begin
		case(STATE)
			IDLE:							//洗衣机空闲态
			begin
				if(key == 3'd1)						//按下启动键
				begin
					STATE <= START ;					//跳转到启动状态
					led_start <= 1'b0 ;				//启动指示灯常亮
				end
				else
				begin
					STATE <= IDLE ;					//停留在空闲状态
					led_start		=	1'b1;										//启动指示灯
					led_zhushui		=	1'b1;										//注水指示灯
					led_motor_f		=	1'b1;										//电机正传指示灯
					led_motor_o		=	1'b1;										//电机反转指示灯
					led_fangshui	=	1'b1;										//放水指示灯	
					led_tuoshui		=	1'b1;										//脱水指示灯
					time_cnt 		<= 20'b0 ;
					step_cnt1 		<= 5'b0 ;
					step_cnt2 		<= 2'b0 ;
				end
			end
			START:						//洗衣机进入启动态
			begin
				if(key == 3'd4)								//检测到按下暂停键
				begin
					led_zhushui <= 1'b1 ;					
				end
				else if(key == 3'd2)						//启动注水
				begin
					led_zhushui <= 1'b0 ;				//注水指示灯亮
				end
				else if(key == 3'd3)					//暂停注水				
				begin
					led_zhushui <= 1'b1 ;				//注水指示灯灭
					STATE <= XIDI;						//自动进入洗涤状态
				end
			end
			XIDI:							//洗衣机进入洗涤态
			begin
				if(step_cnt1 < 19)											//执行20次
				begin
					case(step_cnt2)
						0:
						begin
							if(key == 3'd4)								//检测到按下暂停键
							begin
								led_motor_f <= 1'b1 ;					
							end
							else if(time_cnt < 5_000_000/system_period)
							begin
								time_cnt <= time_cnt + 1'b1 ;
								led_motor_f <= 1'b0 ;					//电机正传指示灯亮
							end
							else
							begin
								step_cnt2 = step_cnt2 + 1'b1 ;
								time_cnt <= 20'b0 ;
								led_motor_f <= 1'b1 ;					//5s后电机正传指示灯灭
							end
						end
						1:
						begin
							if(key == 3'd4)								//检测到按下暂停键
							begin
								led_motor_o <= 1'b1 ;					
							end
							else if(time_cnt < 5_000_000/system_period)
							begin
								time_cnt <= time_cnt + 1'b1 ;
								led_motor_o <= 1'b0 ;					//电机反传指示灯亮
							end
							else
							begin
								step_cnt2 <= 2'b0;
								time_cnt <= 20'b0 ;
								step_cnt1 <= step_cnt1 + 1'b1 ;
								led_motor_o <= 1'b1 ;					//5s后电机反传指示灯灭
							end
						end
					endcase
				end
				else
				begin
					STATE  <= FANGSHUI ;
					time_cnt <= 20'b0 ;
					step_cnt1 <= 5'b0 ;
					step_cnt2 <= 2'b0 ;
				end
			end
			FANGSHUI:
			begin
				if(key == 3'd4)								//检测到按下暂停键
				begin
					led_fangshui <= 1'b1 ;					
				end
				else if(fangshui_flag == 0)
				begin
					STATE <= TUOSHUI ;
					led_fangshui <= 1'b1 ;
				end
				else
				begin
					led_fangshui <= 1'b0 ;
				end
			end
			TUOSHUI:
			begin
				if(key == 3'd4)								//检测到按下暂停键
				begin
					led_tuoshui <= 1'b1 ;					//脱水指示灯灭,相当于关闭脱水电机,以防事故出现
				end
				else if(time_cnt < 10_000_000/system_period)
				begin
					time_cnt <= time_cnt + 1'b1 ;
					led_tuoshui <= 1'b0 ;					//脱水指示灯亮
				end
				else
				begin
					STATE <= END ;
					led_tuoshui <= 1'b1 ;					//10s后脱水指示灯灭
				end
			end
			END:													
			begin
				if(key == 3'd1)
				begin
					STATE <= START ;							//检测到按下启动键,进入下一次洗涤配置
					time_cnt <= 20'b0 ;
				end
				else if(time_cnt < 500_000 /system_period)	//1s亮灭周期
				begin
					led_start <=  ~led_start ;
				end
				else
				begin
					time_cnt <= 20'b0 ;
				end
			end
		endcase
	end

end















endmodule
