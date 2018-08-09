module I2C_OV7670_conf(
input						S_CLK			,
input						RST_N			,
							
input						start_init		,
output		reg				init_done		,

output		reg				SCCB_req		,
input						SCCB_busy		,

output		reg		[7:0]	LUT_INDEX

);

//------------------------------------------------------
//-- 
//------------------------------------------------------



//------------------------------------------------------
//-- 内部接口
//------------------------------------------------------
reg			[1:0]			state			;
reg			[1:0]			state_n			;	
reg							step_cnt		;	

//------------------------------------------------------
//-- 参数定义
//------------------------------------------------------
localparam	IDLE = 2'd0 ,RUN = 2'd1 ,STOP = 2'd2 ;

//------------------------------------------------------
//-- 状态寄存器赋值
//------------------------------------------------------
always@(posedge S_CLK or negedge RST_N) begin
	if(!RST_N) begin
		state <= IDLE;
	end
	else begin
		state <= state_n ;
	end
end
//------------------------------------------------------
//-- 
//------------------------------------------------------
always@(*) begin
	case(state)
		IDLE : begin
			if(start_init) begin
				state_n = RUN ;
			end
			else begin
				state_n = IDLE ;
			end
		end
		RUN : begin
			if(!SCCB_busy && LUT_INDEX == 'd164) begin
			// if(1'b0) begin
				state_n = STOP ;
			end
			else begin
				state_n = RUN ;
			end
		end
		STOP : begin
			state_n = STOP ;
		end
		default : begin
			state_n = IDLE ;
		end
	endcase
end

//------------------------------------------------------
//-- 
//------------------------------------------------------
always@(posedge S_CLK or negedge RST_N) begin
	if(!RST_N) begin
		SCCB_req <= 'b0 ;
		LUT_INDEX <= 'b0 ;
		init_done <= 'b0 ;
		step_cnt <= 'b0 ;
	end
	else begin
		case(state_n)
			IDLE : begin
				SCCB_req <= 'b0 ;
				LUT_INDEX <= 'b0 ;
				init_done <= 'b0 ;
				step_cnt <= 'b0 ;
			end
			RUN : begin
				SCCB_req <= 'b1 ;
				case(step_cnt)
					0 : begin
						if(!SCCB_busy) begin
							step_cnt <= step_cnt + 1'b1 ;
						end
					end
					1 : begin
						if(SCCB_busy) begin
							step_cnt <= 'b0 ;
							LUT_INDEX <= LUT_INDEX + 1'b1 ;
						end
					end
				endcase
			end
			STOP : begin
				SCCB_req <= 'b0 ;
				init_done <= 'b1 ;
				step_cnt <= 'b0 ;
			end
		endcase
	end
end


endmodule