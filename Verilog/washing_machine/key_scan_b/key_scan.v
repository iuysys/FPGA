module key_scan
(
	//system input
	CLK,RST_N,
	//按键
	key_s,key_w,key_p,
	//output
	key_value
);
//------------------------------------------------------
//-- 外部端口
//------------------------------------------------------
input 									CLK;					//系统时钟,20Mhz
input										RST_N;				//全局复位
input										key_s;				//启动键
input										key_w;				//复位键
input										key_p;				//暂停键

output 	reg	[2:0]					key_value;			//键值

//------------------------------------------------------
//-- 内部端口
//------------------------------------------------------
reg 		[2:0]							step_cnt;			//步骤计数

//------------------------------------------------------
//-- 功能模块
//------------------------------------------------------
always@(posedge CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		key_value <= 3'b0 ;
		step_cnt <= 3'b0 ;
	end
	else				//按键只响应单键按下,同时按多建无反应
	begin
		case(step_cnt)
			0:						//空闲状态等待启动键按下
			begin
				if(!key_s)		//启动键按下
				begin
					step_cnt <= step_cnt + 1'b1 ;
					key_value <= 3'd1 ;
				end
				else
				begin
					key_value <= 3'd0 ;
					step_cnt <= 3'b0 ;
				end
			end
			1:	
			begin
				if(!key_w)			//注水键按下
				begin
					step_cnt <= step_cnt + 1'b1 ;
					key_value <= 3'd2 ;
				end
				else
				begin
					key_value <= 3'd1 ;
				end
			end
			2:
			begin
				if(!key_w)			//注水键再次按下
				begin
					step_cnt <= step_cnt + 1'b1 ;
					key_value <= 3'd3 ;
				end
				else
				begin
					key_value <= 3'd2 ;
				end
			end
			3:
			begin
				if(!key_p)			//
				begin
					step_cnt <= step_cnt + 1'b1 ;
					key_value <= 3'd4 ;
				end
				else if(!key_s)
				begin
					step_cnt <= 3'd1 ;
				end
			end
			4:
			begin
				if(!key_p)			//注水键再次按下
				begin
					step_cnt <= step_cnt - 1'b1 ;
					key_value <= 3'd5 ;
				end
			end
		endcase
	end
end
endmodule
























