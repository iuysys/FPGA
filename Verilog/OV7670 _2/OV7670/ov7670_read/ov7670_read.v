module ov7670_read
(
	//
	CLK_40M,RST_N,READ_EN,OV_DATA,TX_CACHE_WRFULL,
	//
	RD_FRAME,OV_RRST,OV_RCLK,TX_CACHE_DATA,TX_CACHE_WRCLK,TX_CACHE_WRREQ
);

//-------------------------------------------------------
//-- 端口信号 
//-------------------------------------------------------
input 									CLK_40M;
input										RST_N;
input										READ_EN;						//裁决器输出读OV7670使能信号		
input			[7:0]						OV_DATA;						//OV端口输出的数据
input 									TX_CACHE_WRFULL ;
		
output 		reg 						RD_FRAME;					//读完一帧后输出信号
output		reg						OV_RRST;
output		 							OV_RCLK;
output		reg		[7:0]			TX_CACHE_DATA ;
output									TX_CACHE_WRCLK;
output		reg						TX_CACHE_WRREQ;

//-------------------------------------------------------
//-- 内部信号
//-------------------------------------------------------
reg 			[1:0] 	STATE ;
reg			[7:0]		step_cnt;
reg 						ov_clk_en;
reg 			[7:0]    cache_data;
reg 						tx_cache_wrclk_en;
reg 			[31:0]	pixel_cnt;

//-------------------------------------------------------
//-- 
//-------------------------------------------------------
localparam IDLE =2'D0 ,RRST = 2'D1 ,READ = 2'D2 ;

//-------------------------------------------------------
//-- 
//-------------------------------------------------------
always@(posedge CLK_40M or negedge RST_N)
begin
	if(!RST_N)
	begin
		STATE <= IDLE ;
		step_cnt <= 8'b0;
		ov_clk_en <= 1'b0; 
		tx_cache_wrclk_en <= 1'b0 ;
		pixel_cnt <= 32'b0 ;
		RD_FRAME <= 1'B1 ;
		OV_RRST <= 1'b1 ;
		TX_CACHE_WRREQ <= 1'b0 ;
	end
	else
	begin
		case(STATE)
			IDLE :
			begin
				if(READ_EN == 1'B1)
				begin
					STATE <= RRST ;
					RD_FRAME <= 1'B0 ;
				end
				else
				begin
					STATE <= IDLE ;
					RD_FRAME <= 1'B1 ;
				end
			end
			RRST :
			begin
				case(step_cnt)
					0 ,1 ,2 :
					begin
						ov_clk_en <= 1'b1; 
						OV_RRST <= 1'B0 ;
						step_cnt <= step_cnt + 1'B1 ;
					end
					 3:
					begin
						ov_clk_en <= 1'b0; 
						OV_RRST <= 1'B1 ;
						STATE <= READ ;
						step_cnt <= 8'B0 ;
					end
					default :
					begin
						step_cnt <= 4'B0 ;
					end
				endcase
			end
			READ :
			begin
				if(pixel_cnt == 72800 * 2 )
				begin
					STATE <= IDLE ;
					pixel_cnt <= 32'b0 ;
					RD_FRAME <= 1'B1 ;
				end
				else if(TX_CACHE_WRFULL == 1'b0)
				begin
					case(step_cnt)
						0 :
						begin
							ov_clk_en <= 1'b1; 
							RD_FRAME <= 1'B0 ;
							step_cnt <= step_cnt + 1'b1 ;
						end
						1 :
						begin
							cache_data[7:0] <= OV_DATA ;
							ov_clk_en <= 1'b0;
							step_cnt <= step_cnt + 1'b1 ;
						end
						2 :
						begin
							tx_cache_wrclk_en <= 1'b1 ;
							TX_CACHE_WRREQ <= 1'b1 ;
							TX_CACHE_DATA <= cache_data ;
							step_cnt <= step_cnt + 1'b1 ;
						end
						3 :
						begin
							tx_cache_wrclk_en <= 1'b0 ;
							TX_CACHE_WRREQ <= 1'b0 ;
							step_cnt <= 8'b0 ;
							pixel_cnt <= pixel_cnt + 1'b1 ;
						end
					endcase
				end
				else
				begin
					tx_cache_wrclk_en <= 1'b0 ;
					ov_clk_en <= 1'b0;
				end
			end
			default :
				STATE <= IDLE ;
		endcase
	end
end
//-------------------------------------------------------
//-- 
//-------------------------------------------------------
assign OV_RCLK = ov_clk_en == 1'b1 ? ~CLK_40M : 1'B1 ;
assign TX_CACHE_WRCLK = tx_cache_wrclk_en == 1'b1 ? ~CLK_40M : 1'B1 ;


endmodule

