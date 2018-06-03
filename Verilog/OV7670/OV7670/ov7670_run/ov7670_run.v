module ov7670_run
(
	//system input
	SYS_CLK,RST_N,RUN_EN,OV_VSYNC,R_IDLE,
	//
	OV_WRRST,OV_WEN,WR_FRAME
);
//------------------------------------------------------
//-- 
//------------------------------------------------------
input 						SYS_CLK ;
input							RST_N ;
input 						RUN_EN ;
input							OV_VSYNC ;
input 						R_IDLE ;

output 		reg			OV_WRRST ;
output		reg			OV_WEN 	;
output 		reg			WR_FRAME ;

//------------------------------------------------------
//-- 
//------------------------------------------------------
reg 			[3:0] 		STATE ;
reg 							vsync_posedge ;
reg			[3:0]			vsync_cnt ;
reg 			[3:0]			step_cnt ;

//------------------------------------------------------
//-- 
//------------------------------------------------------
localparam IDLE = 4'D0 ,WTRIG = 4'D1 ,WEN = 4'D2 ,W2TRIG = 4'D3 ,WDISEN = 4'D4 ,WAIT = 4'D5 ;


//------------------------------------------------------
//-- 
//------------------------------------------------------
always@(posedge SYS_CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		STATE <= IDLE ;
		step_cnt <= 4'b0 ;
		OV_WRRST <= 1'b1 ;
		OV_WEN <= 1'b0;
		WR_FRAME <= 1'b0 ;
	end
	else
	begin
		case(STATE)
			IDLE :
			begin
				if(RUN_EN == 1'B1)
				begin
					STATE <= WTRIG ;
					WR_FRAME <= 1'B0 ;
				end
				else
				begin
					STATE <= IDLE ;
				end
			end
			WTRIG :
			begin
				if(vsync_cnt == 4'd1)
				begin
					STATE <= WEN ;
				end
				else
				begin
					STATE <= WTRIG ;
				end
			end
			WEN :
			begin
				case(step_cnt)
					0 ,1 ,2 ,3 :
					begin
						OV_WRRST <= 1'B0 ;
						step_cnt <= step_cnt + 1'B1 ;
					end
					4 :
					begin
						OV_WRRST <= 1'B1 ;
						OV_WEN <= 1'B1 ;
						step_cnt <= 4'B0 ;
						STATE <= W2TRIG ;
					end
					default :
					begin
						step_cnt <= 4'B0 ;
					end
				endcase
			end
			W2TRIG :
			begin
				if(vsync_cnt == 4'D2)
				begin
					STATE <= WDISEN ;
					WR_FRAME <= 1'B1 ;
				end
				else
				begin
					STATE <= W2TRIG ;
				end
			end
			WDISEN :
			begin
				OV_WEN <= 1'B0 ;
				STATE <= WAIT ;
			end
			WAIT :
			begin
				if(R_IDLE == 1'B1)
				begin
					STATE <= IDLE ;
				end
				else
				begin
					STATE <= WAIT ;
				end
			end
			default :
			begin
				STATE <= IDLE ;
			end
		endcase
	end
end



//-------------------------------------------------------
//-- 场信号捕捉器
//-------------------------------------------------------
always@(posedge OV_VSYNC or negedge RST_N)
begin
	if(!RST_N)
	begin
		vsync_cnt <= 4'B0 ;
	end
	else if(STATE == WTRIG || STATE == W2TRIG )
	begin
		if(vsync_cnt == 4'D2)
		begin
			vsync_cnt <= 4'B0 ;
		end
		else
		begin
			vsync_cnt <= vsync_cnt + 1'B1 ;
		end
	end
	else
	begin
		vsync_cnt <= 4'B0 ;
	end
end











endmodule
