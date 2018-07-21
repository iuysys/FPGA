module I2C_Write(
input 							CLK			,				//3MHz > CLK > 1.1MHz
input 							RST_N		,
input 				[23:0] 		data_in		,				//从机地址+寄存器地址+数据
input 							SCCB_req	,
				                            
output 		reg					SCCB_SDA	,				
output 		reg					SCCB_SCL	,				//输入时钟/4
output 		reg					SCCB_busy					//
);
//------------------------------------------------------
//-- 
//------------------------------------------------------


//------------------------------------------------------
//-- 内部信号
//------------------------------------------------------
reg 	[2:0] 	state 				;				//状态
reg 	[2:0] 	state_n				;				//状态机下一个状态
		
reg 	[7:0]	step_cnt			;				//步骤计数
reg		[1:0]	scl_cnt				;				//SCL时钟的计数器
reg 	[23:0]	latch_data			;				//锁存数据寄存器

//------------------------------------------------------
//-- 参数定义
//------------------------------------------------------
localparam IDLE = 3'D0 ,START = 3'D1 ,S_ADDR = 3'D2 ,S_REG = 3'D3 ,S_DATA = 3'D4 ,STOP = 3'D5;


//------------------------------------------------------
//-- 状态寄存器赋值
//------------------------------------------------------
always@(posedge CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		state <= IDLE;
	end
	else
	begin
		state <= state_n ;
	end
end

//------------------------------------------------------
//-- 状态的判断转换
//------------------------------------------------------
always@(*)
begin
	case(state)
		IDLE : begin
			if(SCCB_req) begin
				state_n = START;
			end
			else begin
				state_n = IDLE;
			end
		end
		START : begin
			if(scl_cnt == 'd2) begin
				state_n = S_ADDR;
			end
			else
				state_n = START ;
		end
		S_ADDR : begin
			if(step_cnt == 'd0 && scl_cnt == 'd1) begin
				state_n = S_REG;
			end
			else
				state_n = S_ADDR ;
		end
		S_REG : begin
			if(step_cnt == 'd0 && scl_cnt == 'd1) begin
				state_n = S_DATA;
			end
			else
				state_n = S_REG ;
		end
		S_DATA : begin
			if(step_cnt == 'd9) begin
				state_n = STOP;
			end
			else
				state_n = S_DATA ;
		end
		STOP : begin
			if(scl_cnt == 'd2) begin
				state_n = IDLE;
			end
			else
				state_n = STOP ;
		end
		default :
			state_n = IDLE;
	endcase
end
//------------------------------------------------------
//-- 产生SCL时钟
//------------------------------------------------------
always@(posedge CLK or negedge RST_N) begin
	if(!RST_N) begin
		scl_cnt <= 'b0 ;
		SCCB_SCL <= 1'B1 ;
	end
	else if(state_n != IDLE) begin
		case(scl_cnt)
			0 ,1: begin
				SCCB_SCL <= 1'B1 ;	
			end
			2 ,3: begin
				SCCB_SCL <= 1'B0 ;
			end
		endcase
		scl_cnt <= scl_cnt + 1'b1 ;
	end
	else begin
		scl_cnt <= 'b0 ;
		SCCB_SCL <= 1'B1 ;
	end
end
//------------------------------------------------------
//-- 状态的输出值
//------------------------------------------------------
always@(posedge CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		step_cnt <= 8'B0 ;
		SCCB_SDA <= 1'B1 ;
		latch_data <= 'b0 ;
		SCCB_busy <= 1'b0 ;
	end
	else
	begin
		case(state_n)
			IDLE : begin
				SCCB_SDA <= 1'B1;
				SCCB_busy <= 1'b0 ;
				step_cnt <= 8'B0;
				latch_data <= 'b0 ;
			end
			START : begin 
				SCCB_SDA <= 1'B0;
				latch_data <= data_in ;
				SCCB_busy <= 1'b1 ;
			end
			S_ADDR : begin
				
				if(step_cnt == 'd9 && scl_cnt == 'd0) begin
					step_cnt <= 'b0 ;
				end
				else if(scl_cnt == 'd3) begin
					step_cnt <= step_cnt + 1'b1 ;
					case(step_cnt)
						0 : begin
							SCCB_SDA <= latch_data[23] ;
						end
						1 : begin
							SCCB_SDA <= latch_data[22] ;
						end
						2 : begin
							SCCB_SDA <= latch_data[21] ;
						end
						3 : begin
							SCCB_SDA <= latch_data[20] ;
						end
						4 : begin
							SCCB_SDA <= latch_data[19] ;
						end
						5 : begin
							SCCB_SDA <= latch_data[18] ;
						end
						6 : begin
							SCCB_SDA <= latch_data[17] ;
						end
						7 : begin
							SCCB_SDA <= latch_data[16] ;
						end
						default :begin
							SCCB_SDA <= 1'b1 ;
						end
					endcase
				end
			end
			S_REG : begin
				if(step_cnt == 'd9 && scl_cnt == 'd0) begin
					step_cnt <= 'b0 ;
				end
				else if(scl_cnt == 'd3) begin
					step_cnt <= step_cnt + 1'b1 ;
					case(step_cnt)
						0 : begin
							SCCB_SDA <= latch_data[15] ;
						end
						1 : begin
							SCCB_SDA <= latch_data[14] ;
						end
						2 : begin
							SCCB_SDA <= latch_data[13] ;
						end
						3 : begin
							SCCB_SDA <= latch_data[12] ;
						end
						4 : begin
							SCCB_SDA <= latch_data[11] ;
						end
						5 : begin
							SCCB_SDA <= latch_data[10] ;
						end
						6 : begin
							SCCB_SDA <= latch_data[9] ;
						end
						7 : begin
							SCCB_SDA <= latch_data[8] ;
						end
						default :begin
							SCCB_SDA <= 1'b1 ;
						end
					endcase
				end
			end
			S_DATA: begin
				if(scl_cnt == 'd3) begin
					step_cnt <= step_cnt + 1'b1 ;
					case(step_cnt)
						0 : begin
							SCCB_SDA <= latch_data[7] ;
						end
						1 : begin
							SCCB_SDA <= latch_data[6] ;
						end
						2 : begin
							SCCB_SDA <= latch_data[5] ;
						end
						3 : begin
							SCCB_SDA <= latch_data[4] ;
						end
						4 : begin
							SCCB_SDA <= latch_data[3] ;
						end
						5 : begin
							SCCB_SDA <= latch_data[2] ;
						end
						6 : begin
							SCCB_SDA <= latch_data[1] ;
						end
						7 : begin
							SCCB_SDA <= latch_data[0] ;
						end
						default :begin
							SCCB_SDA <= 1'b0 ;
						end
					endcase
				end
			end
			STOP :
			begin
				if(scl_cnt == 'd1) begin
					SCCB_SDA <= 1'b1 ;
				end
				else begin
					SCCB_SDA <= 1'b0 ;
				end	
			end
			default :
			begin
				SCCB_SDA <= 1'B1;
			end
		endcase
	end
end
endmodule
