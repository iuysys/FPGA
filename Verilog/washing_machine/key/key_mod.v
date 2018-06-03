module key_mod
(
	//system input
	CLK,RST_N,
	//按键端口
	key,
	//输出
	key_press
);
//-------------------------------------------------------
//-- 外部端口
//-------------------------------------------------------
input 					CLK	;				//时钟
input						RST_N	;				//复位
input 					key	;				//按键输入端口
output 	reg			key_press;			//按键按下,输出低电平,时间和按下时间相差检测时间

//-------------------------------------------------------
//-- 内部端口
//-------------------------------------------------------
reg 					s_now,s_last;			//按键前后状态
wire 					isH_L;					//按键是否变化信号				
reg 	[2:0]			step_cnt;				//步骤计数器
reg 	[9:0] 		time_count;				//时间计数器
//-------------------------------------------------------
//-- 扫描按键状态
//-------------------------------------------------------
always@(posedge CLK or negedge RST_N)
begin
	if(!RST_N)
		{s_last,s_now} <= 2'b11;
	else
		{s_last,s_now} <= {s_now,key};
end

//-------------------------------------------------------
//-- 组合逻辑电路判断按键是否变化
//-------------------------------------------------------

assign isH_L = (s_last == 1 && s_now == 0);

//-------------------------------------------------------
//-- 按键消抖
//-------------------------------------------------------
always@(posedge CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		step_cnt <= 2'b0 ;
		key_press <= 1'b1 ;
		time_count <= 10'b0 ;
	end
	else
	begin
		case(step_cnt)
			0 ://检测到按键按下
				if(isH_L) begin 
					step_cnt <= step_cnt + 1'b1;
				end
				else begin
					step_cnt <= 3'b0;
				end
			1 ://10ms等待
				if(time_count < 10_000/50) begin
					time_count <= 10'b0; 
					step_cnt <= step_cnt + 1'b1;
				end
				else begin
					time_count <= time_count + 1'b1;
				end
			2 ://再次判断
				if(!key) begin
					key_press <= 1'b0;
					step_cnt <= step_cnt + 1'b1;
				end
				else begin
					step_cnt <= 1'b0;
					key_press <= 1'b1;
				end
			3 ://等待按键释放
				if(key) begin
					step_cnt <= 1'b0;
					key_press <= 1'b1;
				end
				
			default :
			begin
				step_cnt <= 1'b0;
				key_press <= 1'b1 ;	
			end
			endcase
	end
		
end



endmodule


















