module OV7670
(
	//input 
	CLK,RST_N,OV_DATA_IN,OV_VSYNC,FIFO_RCLK,FIFO_RDREQ,
	//output
	FIFO_DATA_OUT,SDA,SCL,OV_WRST,OV_RRST,OV_RCLK,OV_WEN,FIFO_EMPTY
	//control signal input
//	OV_CONF,
	//control signal output
//	OV_READY
);
//-------------------------------------------------------
//-- 
//-------------------------------------------------------
input CLK ;
input RST_N ;
input [7:0] OV_DATA_IN ;
input OV_VSYNC ;
input FIFO_RCLK ;
input FIFO_RDREQ ;
//input [3:0] OV_CONF ;					//OV配置控制信号


output [15:0] FIFO_DATA_OUT ;
output SDA ;
output SCL ;
output OV_WRST ;
output OV_RRST ;
output OV_RCLK ;
output OV_WEN  ;
output FIFO_EMPTY ;

//output OV_READY ;


reg OV_WRST ;
reg OV_RRST ;
reg OV_RCLK ;
reg OV_WEN  ;
//reg [15:0] FIFO_DATA_OUT ;

//-------------------------------------------------------
//-- 
//-------------------------------------------------------
reg [3:0] STATE;
reg [3:0] STATE_n;
reg [3:0] OV_VS_CNT ;				//场信号计数器
reg [3:0] STEP_CNT ;
reg [19:0] READ_CNT ;
reg [3:0] READ_STEP_CNT ;
reg [15:0] FIFO_DATA_IN ;
reg FIFO_WRREQ ;
reg OV_RCLK_EN;

wire init_en ;
wire init_done ;
wire fifo_full_sig ;
wire fifo_data_in ;
wire fifo_wrreq_sig ;

//-------------------------------------------------------
//-- 
//-------------------------------------------------------
localparam INIT = 4'D0 ,WTRIG = 4'D1 ,WEN = 4'D2 ,W2TRIG = 4'D3 ,WDISEN = 4'D4 ,RRST = 4'D5 ,READ = 4'D6;
//localparam IDLE = 4'D8 ,CONF = 4'D9 ,RUN = 4'D10 ;
////-------------------------------------------------------
////-- 状态寄存器
////-------------------------------------------------------
//always@(posedge CLK or negedge RST_N)
//begin
//	if(!RST_N)
//	begin
//		STATE <= INIT ;
//	end
//	else
//	begin
//		STATE <= STATE_n ;
//	end
//end

//-------------------------------------------------------
//-- 状态判断
//-------------------------------------------------------
always@(posedge CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		STATE <= INIT ;
		STEP_CNT <= 4'B0 ;
		OV_WRST <= 1'B1 ;
		OV_WEN  <= 1'B0 ;
		OV_RRST <= 1'B1 ;
	end
	else
	begin
		case(STATE)
			INIT :
			begin
				if(init_done == 1'b1)
				begin
					STATE <= WTRIG ;
				end
				else
				begin
					STATE <= INIT ;
				end
			end
			WTRIG :
			begin
				if(OV_VS_CNT == 4'D1)
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
				case(STEP_CNT)
					0 ,1 ,2 ,3 :
					begin
						OV_WRST <= 1'B0 ;
						STEP_CNT <= STEP_CNT + 1'B1 ;
					end
					4 :
					begin
						OV_WRST <= 1'B1 ;
						OV_WEN <= 1'B1 ;
						STEP_CNT <= 4'B0 ;
						STATE <= W2TRIG ;
					end
					default :
					begin
						STEP_CNT <= 4'B0 ;
					end
				endcase
			end
			W2TRIG :
			begin
				if(OV_VS_CNT == 4'D2)
				begin
					STATE <= WDISEN ;
				end
				else
				begin
					STATE <= W2TRIG ;
				end
			end
			WDISEN :
			begin
				OV_WEN <= 1'B0 ;
				STATE <= RRST ;
			end
			RRST :
			begin
				case(STEP_CNT)
					0 ,1 ,2 :
					begin
						OV_RRST <= 1'B0 ;
						STEP_CNT <= STEP_CNT + 1'B1 ;
					end
					 3:
					begin
						OV_RRST <= 1'B1 ;
						STATE <= READ ;
						STEP_CNT <= 4'B0 ;
					end
					default :
					begin
						STEP_CNT <= 4'B0 ;
					end
				endcase
			end
			READ :
			begin
				if(READ_CNT == 76800)
				begin
					STATE <= WTRIG ;
				end
				else
				begin
					STATE <= READ ;
				end
			end
			default :
			begin
				STATE <= INIT ;
			end
		endcase
	end
end

//-------------------------------------------------------
//-- 
//-------------------------------------------------------
//--
assign init_en = STATE == INIT ? 1'B1 : 1'B0 ;
//-------------------------------------------------------
//-- 从fifo读出数据
//-------------------------------------------------------
always@(posedge CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		READ_CNT <= 20'B0 ;
		READ_STEP_CNT <= 4'B0 ;
	end
	else if(STATE == READ)
	begin
		if(READ_CNT == 76800)
		begin
			READ_CNT <= 20'B0 ;
		end
		else if(fifo_full_sig == 1'b1)
		begin
			OV_RCLK_EN <= 1'B0 ;
		end
		else 
		begin
			case(READ_STEP_CNT)
				0 :
				begin
					FIFO_WRREQ <= 1'B0 ;
					OV_RCLK_EN <= 1'B1 ;
					FIFO_WRREQ <= 1'B0 ;
					READ_STEP_CNT <= READ_STEP_CNT + 1'B1 ;
				end
				1 :
				begin
					FIFO_DATA_IN[15:8] <= OV_DATA_IN ;
					READ_STEP_CNT <= READ_STEP_CNT + 1'B1 ;
				end
				2 :
				begin
					READ_STEP_CNT <= READ_STEP_CNT + 1'B1 ;
				end
				3 :
				begin
					FIFO_DATA_IN[7:0] <= OV_DATA_IN ;
					FIFO_WRREQ <= 1'B1 ;
					OV_RCLK_EN <= 1'B0 ;
					READ_STEP_CNT <= 4'B0 ;
					READ_CNT <= READ_CNT + 1'B1 ;
				end
				default :
				begin
					READ_CNT <= 20'B0 ;
					READ_STEP_CNT <= 4'B0 ;
				end
			endcase
		end
	end
	else
	begin
		READ_CNT <= 20'B0 ;
		READ_STEP_CNT <= 4'B0 ;
	end
end
assign fifo_wrreq_sig = FIFO_WRREQ ;
assign fifo_data_in = FIFO_DATA_IN ;

//-------------------------------------------------------
FIFO_IP	FIFO_IP_inst (
	.data ( fifo_data_in ),
	.rdclk ( FIFO_RCLK ),
	.rdreq ( FIFO_RDREQ ),
	.wrclk ( CLK ),
	.wrreq ( fifo_wrreq_sig ),
	.q ( FIFO_DATA_OUT ),
	.rdempty ( FIFO_EMPTY ),
	.wrfull ( fifo_full_sig )
	);
//-------------------------------------------------------
//-- 读时钟信号
//-------------------------------------------------------
always@(posedge CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		OV_RCLK <= 1'B1 ;
	end
	else if((STATE == RRST )||( STATE == READ && OV_RCLK_EN == 1'B1))
	begin
		OV_RCLK <= ~ CLK ;
	end
	else
	begin
		OV_RCLK <= 1'B1 ;
	end
end
//assign OV_RCLK = (STATE == RRST || STATE == READ) ? ~CLK : 1'B1 ;
//-------------------------------------------------------
//-- 场信号捕捉器
//-------------------------------------------------------
always@(posedge OV_VSYNC or negedge RST_N)
begin
	if(!RST_N)
	begin
		OV_VS_CNT <= 4'B0 ;
	end
	else if(STATE == WTRIG || STATE == W2TRIG )
	begin
		 if(OV_VS_CNT == 4'D2)
		begin
			OV_VS_CNT <= 4'B0 ;
		end
		else
		begin
			OV_VS_CNT <= OV_VS_CNT + 1'B1 ;
		end
	end
	else
	begin
		OV_VS_CNT <= 4'B0 ;
	end
end


//-------------------------------------------------------
//-- 
//-------------------------------------------------------
I2C_control I2C_U1
(
	//input
	.CLK(CLK),
	.RST_N(RST_N),
	.START(init_en),
	//output
	.SDA(SDA),
	.SCL(SCL),
	.DONE(init_done)
);





endmodule
