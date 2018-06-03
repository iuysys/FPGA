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
reg 		[2:0]							key_temp;			//记录按键状态
reg 										key_rst;				//按键状态复位

//------------------------------------------------------
//-- 功能模块
//------------------------------------------------------
always@(posedge CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		key_value <= 3'b0 ;
		key_rst <= 1'b1 ;
	end
	else if(key_temp != 3'b0)				
	begin
		case(key_temp)
			3'b001:
			begin
				key_value <= 3'd1 ;
				key_rst <= 1'b0 ;
			end
			3'b010:
			begin
				if(key_value == 3'd1)
				begin
					key_value <= 3'd2 ;
				end
				else if(key_value == 3'd2)
				begin
					key_value <= 3'd3 ;
				end
				key_rst <= 1'b0 ;
			end
			3'b100:
			begin
				if(key_value == 3'd3)
				begin
					key_value <= 3'd4 ;
				end
				else if(key_value == 3'd4)
				begin
					key_value <= 3'd5 ;
				end
				key_rst <= 1'b0 ;
			end
			
		endcase
	end
	else
		key_rst <= 1'b1 ;
end


//------------------------------------------------------
//-- 起始按键记录
//------------------------------------------------------
always@(negedge key_s or negedge key_rst)
begin
	if(!key_rst)
	begin
		key_temp[0] <= 1'b0 ;
	end
	else
	begin
		key_temp[0] <= 1'b1 ;
	end
end
//------------------------------------------------------
//-- 注水按键记录
//------------------------------------------------------
always@(negedge key_w or negedge key_rst)
begin
	if(!key_rst)
	begin
		key_temp[1] <= 1'b0 ;
	end
	else
	begin
		key_temp[1] <= 1'b1 ;
	end
end
//------------------------------------------------------
//-- 暂停按键记录
//------------------------------------------------------
always@(negedge key_p or negedge key_rst)
begin
	if(!key_rst)
	begin
		key_temp[2] <= 1'b0 ;
	end
	else
	begin
		key_temp[2] <= 1'b1 ;
	end
end

endmodule
























