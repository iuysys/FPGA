module ov7670_read
(
	//
	CLK_40M,RST_N,READ_EN,OV_DATA,CACHE_RCLK,CACHE_RREQ,
	//
	RD_FRAME,OV_RRST,OV_RCLK,CACHE_RD_EN,CACHE_DATA
);

//-------------------------------------------------------
//-- 
//-------------------------------------------------------
input 							CLK_40M;
input								RST_N;
input								READ_EN;
input			[7:0]				OV_DATA;
input								CACHE_RCLK;
input								CACHE_RREQ;

output 		reg 				RD_FRAME;
output		reg				OV_RRST;
output		 					OV_RCLK;
output		[15:0]			CACHE_DATA ;
output							CACHE_RD_EN ;

//-------------------------------------------------------
//-- 
//-------------------------------------------------------
reg 			[1:0] 	STATE ;
reg			[7:0]		step_cnt;
reg 						ov_clk_en;
reg						cache_clk_en;
reg 						wrreq;
wire 						wrreq_sig;
reg 			[15:0]	cache_data ;
wire			[15:0]	cache_data_sig ;
wire						cache_clk ;
reg 			[16:0]	pixel_cnt ;
wire						cache_full_sig ;
wire						cache_rdempty_sig ;
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
		cache_clk_en <= 1'b0 ;
		pixel_cnt <= 17'b0 ;
		RD_FRAME <= 1'B1 ;
		wrreq <= 1'b0 ;
		OV_RRST <= 1'b1 ;
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
				if(pixel_cnt == 76800)
				begin
					STATE <= IDLE ;
					pixel_cnt <= 17'b0 ;
					RD_FRAME <= 1'B1 ;
				end
				else if(1)//(cache_full_sig == 1'b0)
				begin
					case(step_cnt)
						0 :
						begin
							ov_clk_en <= 1'b1; 
							cache_clk_en <= 1'b0 ;
							RD_FRAME <= 1'B0 ;
							step_cnt <= step_cnt + 1'b1 ;
						end
						1 :
						begin
							cache_data[15:8] <= OV_DATA ;
							step_cnt <= step_cnt + 1'b1 ;
						end
						2 :
						begin
							cache_data[7:0] <= OV_DATA ;
							step_cnt <= step_cnt + 1'b1 ;
						end
						3 :
						begin
							ov_clk_en <= 1'b0; 
							cache_clk_en <= 1'b1 ;
							wrreq <= 1'b1 ;
							step_cnt <= 8'b0 ;
							pixel_cnt <= pixel_cnt + 1'b1 ;
						end
					endcase
				end
				else
				begin
					cache_clk_en <= 1'b0 ;
					wrreq <= 1'b0 ;
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
assign cache_clk = cache_clk_en == 1'b1 ? ~CLK_40M : 1'B1 ;
assign cache_data_sig = cache_data ;
assign CACHE_RD_EN = ((pixel_cnt > 720)&&(~cache_rdempty_sig)) ? 1'b1 :1'b0 ;
assign wrreq_sig = wrreq;
//-------------------------------------------------------
//-- 
//-------------------------------------------------------
FIFO_IP	FIFO_IP_inst (
	.data ( cache_data_sig ),
	.rdclk ( CACHE_RCLK ),
	.rdreq ( CACHE_RREQ ),
	.wrclk ( cache_clk ),
	.wrreq ( wrreq_sig ),
	.q ( CACHE_DATA ),
	.rdempty ( cache_rdempty_sig ),
	.wrfull ( cache_full_sig )
	);
endmodule

