module OV7670_Capture(
input 							S_CLK		,
input 							RST_N		,
			
input							init_done	,
output		reg					start_init	,
			
input 				[7:0]		OV_data		,
input							OV_vsync	,			
output		reg					OV_wrst		,
output		reg					OV_rrst		,
output							OV_oe		,
output		reg					OV_wen		,
output							OV_rclk		,
			
input				[8:0]		w_usedw		,
output		reg					w_req		,
output							w_clk		,
output		reg		[15:0]		w_data		

);
//------------------------------------------------------
//-- 
//------------------------------------------------------



//------------------------------------------------------
//-- 内部信号
//------------------------------------------------------
reg					[2:0]		state				;
reg					[2:0]		state_n				;
reg					[3:0]		rst_cnt				;
reg					[2:0]		step_cnt			;
reg								edge_vs_now			;
reg								edge_vs_pre			;
wire							flag_pose_edge_vs	;
reg					[1:0]		vsync_cnt			;
reg					[17:0]		pixel_cnt			;
		
wire							almost_full			;
wire							almost_empty		;
reg								ov_rclk_en			;
		
reg					[16:0]		wait_cnt			;		//等待OV7670上电稳定,2uS
reg								flag_wait			;

//------------------------------------------------------
//-- 参数定义
//------------------------------------------------------
`define		IMAGE_SIZE 240*320
`define		WAIT_2US_TIME 80
localparam	INIT = 3'D0 ,IDLE = 3'D1 ,WRST = 3'D2 ,CAPT = 3'D3 ,RRST = 3'D4 ,READ = 3'D5 ;

//------------------------------------------------------
//-- 
//------------------------------------------------------
assign	OV_oe = 1'b0 ;
assign	OV_rclk = (state == READ && ov_rclk_en) ? S_CLK : 1'b1 ;
assign	w_clk = ~S_CLK ;
assign 	almost_full = (w_usedw >= 480 - 1) ? 1'b1 : 1'b0 ;
assign	almost_empty = (w_usedw <= 32) ? 1'b1 : 1'b0 ;

//------------------------------------------------------
//-- 上电等待2us
//------------------------------------------------------
always@(posedge S_CLK or negedge RST_N) begin
	if(!RST_N) begin
		wait_cnt <= 'b0 ;
		flag_wait <= 1'b0 ;
	end
	else if(wait_cnt == `WAIT_2US_TIME) begin
		flag_wait <= 1'b1 ;
	end
	else begin
		wait_cnt <= wait_cnt + 1'b1 ;
	end
end

//------------------------------------------------------
//-- 时序逻辑,状态转换
//------------------------------------------------------
always@(posedge S_CLK or negedge RST_N) begin
	if(!RST_N) begin
		state <= INIT ;
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
		INIT : begin
			if(init_done && flag_wait) begin
				state_n <= IDLE ;
			end
			else begin
				state_n <= INIT ;
			end
		end
		IDLE : begin
			if(flag_pose_edge_vs && w_usedw == 'd0) begin					//等一帧图像发送完成在采集下一帧图像
				state_n = WRST ;
			end
			else begin
				state_n = IDLE ;
			end
		end
		WRST : begin
			if(rst_cnt == 'd6) begin
				state_n = CAPT ;
			end
			else begin
				state_n = WRST ;
			end
		end
		CAPT :  begin
			if(vsync_cnt == 'd2) begin
				state_n = RRST ;
			end
			else begin
				state_n = CAPT ;
			end
		end
		RRST : begin
			if(rst_cnt == 'd6) begin
				state_n = READ ;
			end
			else begin
				state_n = RRST ;
			end
		end
		READ : begin
			if(pixel_cnt == `IMAGE_SIZE) begin
				state_n = IDLE ;
			end
			else begin
				state_n = READ ;
			end
		end
		
	endcase
end
//------------------------------------------------------
//-- 
//------------------------------------------------------
always@(posedge S_CLK or negedge RST_N) begin
	if(!RST_N) begin
		OV_wrst <= 1'b1 ;
		OV_wen <= 1'b0 ;
		OV_rrst <= 1'b1 ;
		step_cnt <= 'b0 ;
		start_init <= 1'b0 ;
		rst_cnt <= 'b0 ;
		pixel_cnt <= 'b0 ;
		w_req <= 1'b0 ;
		w_data <= 'b0 ;
		ov_rclk_en <= 1'b0 ;
	end
	else begin
		case(state_n)
			INIT : begin
				if(flag_wait) begin					
				// if(1) begin							//调试置1
					start_init <= 1'b1 ;
				end
				else begin
					start_init <= 1'b0 ;
				end
				OV_wrst <= 1'b1 ;
				OV_wen <= 1'b0 ;
				OV_rrst <= 1'b1 ;
				step_cnt <= 'b0 ;
				rst_cnt <= 'b0 ;
				pixel_cnt <= 'b0 ;
				w_req <= 1'b0 ;
				w_data <= 'b0 ;
			end
			IDLE : begin
				start_init <= 1'b0 ;
				step_cnt <= 'b0 ;
				rst_cnt <= 'b0 ;
				pixel_cnt <= 'b0 ;
				w_req <= 1'b0 ;
				w_data <= 'b0 ;
			end
			WRST : begin
				OV_wrst <= 1'b0 ;
				rst_cnt <= rst_cnt + 1'b1 ;
			end
			CAPT : begin
				rst_cnt <= 'b0 ;
				OV_wrst <= 1'b1 ;
				OV_wen <= 1'b1 ;
			end
			RRST : begin
				OV_wen <= 1'b0 ;
				OV_rrst <= 1'b0 ;
				rst_cnt <= rst_cnt + 1'b1 ;
				ov_rclk_en <= 1'b1 ;				//打开读时钟
			end
			READ : begin
				OV_rrst <= 1'b1 ;
				rst_cnt <= 'b0 ;
				if(ov_rclk_en) begin								
					step_cnt <= step_cnt + 1'b1 ;
					if(step_cnt == 'd1) begin
						w_req <= 1'b0 ;
						w_data[15:8] <= OV_data ;
					end	
					else if(step_cnt == 'd2) begin
						w_req <= 1'b1 ;
						step_cnt <= 'd1 ;
						w_data[7:0] <= OV_data ;
						pixel_cnt <= pixel_cnt + 1'b1 ;
						
						if(almost_full) begin						//此处调试修改			
							ov_rclk_en <= 1'b0 ;
						end
						else begin
							ov_rclk_en <= 1'b1 ;
						end
					end
					else begin
						w_req <= 1'b0 ;
					end
				end
				else if(almost_empty) begin
					ov_rclk_en <= 1'b1 ;
					w_req <= 1'b0 ;
				end
				else begin
					w_req <= 1'b0 ;
				end
			end	
		endcase
	end
	
end
//------------------------------------------------------
//-- 场同步信号检测
//------------------------------------------------------
always@(posedge S_CLK or negedge RST_N) begin
	if(!RST_N) begin
		edge_vs_now <= 'b0 ;
		edge_vs_pre <= 'b0 ;
	end
	else begin
		edge_vs_now <= OV_vsync ;
		edge_vs_pre <= edge_vs_now ;
	end
end

assign flag_pose_edge_vs = (!edge_vs_pre & edge_vs_now) ? 1'b1 : 1'b0 ;

always@(posedge S_CLK or negedge RST_N) begin
	if(!RST_N) begin
		vsync_cnt <= 'b0 ;
	end
	else if(flag_pose_edge_vs && state != INIT && state != READ)begin
		vsync_cnt <= vsync_cnt + 1'b1 ;
	end
	else if(state == IDLE) begin
		vsync_cnt <= 'b0 ;
	end
end































endmodule
