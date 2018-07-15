module ov7670_control
(
	//system input
	SYS_CLK,RST_N,WR_FRAME,RD_FRAME,INIT_DONE,
	//system output
	RUN_EN,READ_EN,INIT_EN,R_IDLE
);
//------------------------------------------------------
//-- 
//------------------------------------------------------
input 					SYS_CLK	;	
input 					RST_N		;
input						WR_FRAME	;						//ov7670完成一帧图像的存储信号
input						RD_FRAME	;						//读缓存完成一帧图像的输出
input						INIT_DONE;						//初始化完成信号

output 	reg			RUN_EN	;
output	reg			READ_EN 	;
output	reg			INIT_EN 	;
output 	reg			R_IDLE	;


//------------------------------------------------------
//-- 
//------------------------------------------------------
reg 		[3:0]			STATE		;	
reg 		[3:0]			step_cnt;					
//------------------------------------------------------
//-- 
//------------------------------------------------------
localparam INIT = 4'D1 ,RUN = 4'D2 ,READ = 4'D3 ;
//------------------------------------------------------
//-- 
//------------------------------------------------------
always@(posedge SYS_CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		STATE <= INIT ;
		INIT_EN <= 1'B0 ;
		RUN_EN <= 1'B0 ;
		READ_EN <= 1'B0 ;
		R_IDLE <= 1'B0 ;
		step_cnt <= 4'b0 ;
	end
	else 
	begin
		case(STATE)
			INIT :
			begin
				if(INIT_DONE == 1'B1)
				begin
					STATE <= RUN ;
					INIT_EN <= 1'B0 ;
				end
				else
				begin
					INIT_EN <= 1'B1 ;
				end
			end	
			RUN :
			begin
				case(step_cnt)
					0 ,1:
					begin
						R_IDLE <= 1'B1 ;
						step_cnt <= step_cnt + 1'b1 ;
					end
					2 ,3 :
					begin
						RUN_EN <= 1'B1 ;
						step_cnt <= step_cnt + 1'b1 ;
					end
					4 :
					begin
						R_IDLE <= 1'B0 ;
						if(WR_FRAME == 1'B1 )
						begin
							RUN_EN <= 1'B0 ;
							STATE <= READ ;
							step_cnt <= 4'b0 ;
						end
					end
				endcase
			end	
			READ :
			begin
				case(step_cnt)
					0 ,1 , 2 ,3:
					begin
						READ_EN <= 1'B1 ;
						step_cnt <= step_cnt + 1'b1 ;
					end
					4 :
					begin
						if(RD_FRAME == 1'B1 )
						begin
							RUN_EN <= 1'B1 ;
							STATE <= RUN ;
							R_IDLE <= 1'B1 ;
							step_cnt <= 4'b0 ;
						end
					end
				endcase
			end
			default :
			begin
				STATE <= INIT ;
			end
		endcase
	end
end

endmodule

