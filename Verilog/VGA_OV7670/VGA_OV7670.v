module VGA_OV7670
(
	//输入
	CLK,RST_N,
	//I2C输出端口
	SDA,SCL,
	//OV7670输入输出出端口
	OV_DATA,OV_VS,OV_WRST,OV_WREN,OV_RCLK,OV_RRST,
	//VGA输出端口
	HSYNC,VSYNC,VGA_OUT,VGA_CLK
);
//------------------------------------------------------
//-- 外部信号
//------------------------------------------------------
input CLK;
input RST_N;
input OV_VS ;				//OV7670的场同步信号
input [7:0] OV_DATA;

output SDA;
output SCL;
output OV_WREN;
output OV_WRST;
output OV_RCLK;
output OV_RRST;
output HSYNC;
output VSYNC;
output [15:0] VGA_OUT;
output VGA_CLK;

//------------------------------------------------------
//-- 内部信号
//------------------------------------------------------

reg OV_WREN_n;
reg OV_WRST_n;
reg OV_RCLK_n;
reg OV_RRST_n;

reg [7:0] STATE;

reg [3:0] OV_VS_CNT ;		//OV7670场同步计数器

reg init_en;			//初始化信号
wire init_en_single;
reg init_done;		//初始化完成
wire init_done_single;

wire CLK_40M;

reg [7:0] STEP_CNT ;			//步骤计数器
reg READ_n ;
wire READ_single;

reg [15:0] OV_READ_DATA;
wire [15:0] VGA_DATA_IN;

reg [31:0] R_CNT;

//------------------------------------------------------
//-- 常量定义
//------------------------------------------------------
parameter INIT = 8'd0,WTRIG = 8'd2,WEN = 8'd3,W2TRIG = 8'd4,WDISEN = 8'd5,READ = 8'd6,RRST = 8'D7;


//------------------------------------------------------
//-- 
//------------------------------------------------------
assign OV_WREN = OV_WREN_n;
assign OV_WRST = OV_WRST_n;
assign OV_RCLK = OV_RCLK_n;
assign OV_RRST = OV_RRST_n;
//------------------------------------------------------
//-- 
//------------------------------------------------------
always@(posedge CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		STATE <= INIT ;
		init_en <= 1'b0;
		OV_WRST_n <= 1'B1 ;
		OV_WREN_n <= 1'B0 ;
		STEP_CNT <= 8'B0;
	end
	else
	begin
		case(STATE)
			INIT :
			begin
				if(init_done_single)
				begin
					STATE <= WTRIG;
					init_en <= 1'b0;
				end
				else
				begin
					STATE <= INIT;
					init_en <= 1'b1;
				end
			end
				
			WTRIG :
			begin
				if(OV_VS_CNT == 4'D1)
				begin
					STATE <= WEN;
				end
				else
				begin
					STATE <= WTRIG;
				end
			end
			WEN :
			begin
				case(STEP_CNT)
					0 :
					begin
						OV_WRST_n <= 0;
						STEP_CNT <= STEP_CNT + 1'B1 ;
					end
					1 :
					begin
						OV_WRST_n <= 1 ;
					end
					2 :
					begin
						OV_WREN_n <= 1 ;
					end
					3 :
					begin
						STEP_CNT <= 8'B0;
						STATE <= W2TRIG;
					end
					default :
					begin
						STEP_CNT <= 8'B0;
					end
				endcase
			end
			W2TRIG :
			begin
				if(OV_VS_CNT == 4'D2)
				begin
					STATE <= WDISEN;
				end
				else
				begin
					STATE <= W2TRIG;
				end
			end
			WDISEN :
			begin
				OV_WREN_n <= 1'B0 ;
				STATE <= READ;
			end
			RRST :
			begin
				case(STEP_CNT)
					0 :
					begin
						OV_RRST_n <= 0;
						STEP_CNT <= STEP_CNT + 1'B1 ;
					end
					1 :
					begin
						OV_RRST_n <= 1 ;
					end
					2 :
					begin
						OV_RRST_n <= 0 ;
					end
					3 :
					begin
						STEP_CNT <= 8'B0;
						STATE <= W2TRIG;
						OV_RRST_n <= 1 ;
					end
					default :
					begin
						STEP_CNT <= 8'B0;
					end
				endcase
			end
			
			READ :
			begin
				if(R_CNT == 76800)
				begin
					STATE <= WTRIG;
				end
				else
				begin
					STATE <= READ ;
				end
			end
			default:
			begin
				STATE <= INIT;
			end
		endcase
	end
end
//------------------------------------------------------
//-- 
//------------------------------------------------------
always@( negedge CLK_40M or negedge RST_N)
begin
	if(!RST_N)
	begin
		OV_RCLK_n <= 1'B1;
	end
	else if(STATE == READ) //给读复位分频
	begin
		OV_RCLK_n <= ~ OV_RCLK_n ;
	end
	else
		OV_RCLK_n <= 1'B1;
end
//------------------------------------------------------
assign OV_RCLK = OV_RCLK_n ;
//------------------------------------------------------
//-- 
//------------------------------------------------------
always@( posedge CLK_40M or negedge RST_N)
begin
	if(!RST_N)
	begin
		R_CNT <= 32'B0;
	end
	else if(STATE == READ)
	begin
		case(R_CNT)
			0 :
				OV_READ_DATA <= OV_DATA;
			1 :
				OV_READ_DATA <= OV_READ_DATA << 7 ;
			2 :
			begin
				OV_READ_DATA <= OV_DATA;
				R_CNT <= R_CNT + 1'B1;
			end
		endcase
	end
	else
		R_CNT <= 32'B0;
end
assign VGA_DATA_IN = OV_READ_DATA ;
//------------------------------------------------------
//-- 
//------------------------------------------------------
assign init_en_single = init_en;



//------------------------------------------------------
//-- 获取场同步信号
//------------------------------------------------------
always@( posedge OV_VS or negedge RST_N)
begin
	if(!RST_N)
	begin
		OV_VS_CNT <= 4'B0;
	end
	else if(STATE == WTRIG || STATE == W2TRIG)
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
end





//------------------------------------------------------
//-- 
//------------------------------------------------------
PLL_IP	PLL_IP_inst (
	.inclk0 ( CLK ),
	.c0 ( CLK_40M )
	);


//------------------------------------------------------
VGA VGA1
(
	//输入端口
	.CLK_40M(CLK_40M),
	.RST_N(RST_N),
	.DATA_IN(VGA_DATA_IN),
	//输出端口
	.VSYNC(VSYNC),
	.HSYNC(HSYNC),
	.ADDRESS(),
	.DATA_OUT(VGA_OUT)
);


//------------------------------------------------------
//-- 
//------------------------------------------------------
I2C_control C1
(
	//input
	.CLK(CLK),
	.RST_N(RST_N),
	.START(init_en_single),
	//output
	.SDA(SDA),
	.SCL(SCL),
	.DONE(init_done_single)
);



endmodule


