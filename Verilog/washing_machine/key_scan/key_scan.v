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


//------------------------------------------------------
//-- 功能模块
//------------------------------------------------------
always@(posedge CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		key_value <= 3'b0 ;
	end
	else				//按键只响应单键按下,同时按多建无反应
	begin
		if(key_s == 1'b0 && key_w == 1'b1 && key_w == 1'b1)		//检测到启动键按下
		begin
			if(key_value == 3'd0)
			begin
				key_value <= 3'd1 ;
			end
		end
		else if(key_s == 1'b1 && key_w == 1'b0 && key_w == 1'b1)	//检测到注水键按下
		begin
			if(key_value != 3'd0)			//
			begin
				key_value <= 3'd2 ;
			end
			else if(key_value == 3'd2)		//处于注水状态才响应暂停注水
			begin
				key_value <= 3'd3 ;
			end
		end
		else if(key_s == 1'b1 && key_w == 1'b1 && key_w == 1'b0)	//检测到暂停键按下
		begin
		if(key_value != 3'd0)				//不是空闲状态才有暂停
			begin
				key_value <= 3'd4 ;
			end
			else if(key_value == 3'd4)		//按过暂停键才有恢复
			begin
				key_value <= 3'd5 ;
			end
		end
	end
end
endmodule

