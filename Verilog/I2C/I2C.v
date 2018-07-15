module I2C_TXD
(
	//input
	CLK,RST_N,DATA,EN,
	//output
	SDA,SCL
);
//------------------------------------------------------
//-- 外部信号
//------------------------------------------------------
input CLK;
input RST_N;
input [23:0] DATA;				//从机地址+寄存器地址+数据
input EN;

inout SDA;
output SCL;

//------------------------------------------------------
//-- 内部信号
//------------------------------------------------------
reg SDA_n;							//下一个数据位状态
reg SCL_n;							//下一个时钟信号状态
reg EN_n;							//I2C模块使能

reg SCL_en;							//时钟使能


reg [7:0] 	STATE ;				//状态机
reg [7:0] 	STATE_n ;			//状态机下一个状态

reg [7:0]	STEP_CNT;			//步骤计数

reg [23:0]	DATA_temp;			//输入数据锁存器
reg [7:0]	BUS_DATA;			//总线传输的数据锁存器

//------------------------------------------------------
//-- 参数定义
//------------------------------------------------------
parameter IDLE = 8'D0 ,START = 8'D1 ,S_ADDR = 8'D2 ,S_REG = 8'D3 ,S_DATA = 8'D4 ,STOP = 8'D5;

//------------------------------------------------------
//-- 检测使能信号
//------------------------------------------------------
always@(posedge CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		EN_n <= 1'B0;
	end
	else
	begin
		EN_n <= EN ;
	end
end
//------------------------------------------------------
//-- 状态寄存器赋值
//------------------------------------------------------
always@(posedge CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		STATE <= IDLE;
	end
	else
	begin
		STATE <= STATE_n ;
	end
end

//------------------------------------------------------
//-- 状态的判断转换
//------------------------------------------------------
always@(*)
begin
	case(STATE)
		IDLE :
		begin
			if(EN_n) STATE_n <= START;
			else STATE_n <= IDLE;
		end
		START :
		begin
			if(STEP_CNT == 0)
			begin
				STATE_n <= S_ADDR;
			end
			else
				STATE_n <= START ;
		end
		S_ADDR :
		begin
			if(STEP_CNT == 17)
			begin
				STATE_n <= S_REG;
			end
			else
				STATE_n <= S_ADDR ;
		end
		S_REG :
		begin
			if(STEP_CNT == 17)
			begin
				STATE_n <= S_DATA;
			end
			else
				STATE_n <= S_REG ;
		end
		S_DATA :
		begin
			if(STEP_CNT == 17)
			begin
				STATE_n <= STOP;
			end
			else
				STATE_n <= S_DATA ;
		end
		STOP :
		begin
			if(STEP_CNT == 1)
			begin
				STATE_n <= IDLE;
			end
			else
				STATE_n <= STOP ;
		end
		default :
			STATE_n <= IDLE;
	endcase
end
//------------------------------------------------------
//-- 产生SCL时钟
//------------------------------------------------------
always@(negedge CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		SCL_n <= 1'B1 ;
	end
	else if(STATE != IDLE && SCL_en == 1'B1)
		SCL_n <= ~ SCL_n ;
	else
		SCL_n <= 1'B1 ;
end
//------------------------------------------------------
//-- 总线传输数据寄存器赋值
//------------------------------------------------------
always@(posedge CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		BUS_DATA <= 8'B0 ;
	end
	else 
	begin
		case(STATE)
			IDLE :
			begin
				BUS_DATA <= 8'B0;
			end
			START ,S_ADDR:
			begin
				BUS_DATA <= DATA_temp[23:17];
			end
			S_REG :
			begin
				BUS_DATA <= DATA_temp[16:8];
			end
			S_DATA ,STOP:
			begin
				BUS_DATA <= DATA_temp[7:0];
			end
			default :
				BUS_DATA <= 8'B0;
		endcase
	end
end

//------------------------------------------------------
//-- 状态的输出值
//------------------------------------------------------
always@(posedge CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		STEP_CNT <= 8'B0;
		SDA_n <= 1'B1;
		SCL_en <= 1'B0;
	end
	else
	begin
		case(STATE)
			IDLE :
			begin
				SDA_n <= 1'B1;
				SCL_en <= 1'B0;
			end
			START :
			begin 
				SCL_en <= 1'B1;
				SDA_n <= 1'B0;
			end
			S_ADDR ,S_REG ,S_DATA :
			begin
				case(STEP_CNT)
					0 :
					begin
						SDA_n <= BUS_DATA[7];
						STEP_CNT <= STEP_CNT + 1'B1;
					end
					1 ,3 ,5 ,7 ,9 ,11 ,13 ,15 :
					begin
						STEP_CNT <= STEP_CNT + 1'B1;
					end
					2 :
					begin
						SDA_n <= BUS_DATA[6];
						STEP_CNT <= STEP_CNT + 1'B1;
					end
					4 :
					begin
						SDA_n <= BUS_DATA[5];
						STEP_CNT <= STEP_CNT + 1'B1;
					end
					6 :
					begin
						SDA_n <= BUS_DATA[4];
						STEP_CNT <= STEP_CNT + 1'B1;
					end
					8 :
					begin
						SDA_n <= BUS_DATA[3];
						STEP_CNT <= STEP_CNT + 1'B1;
					end
					10 :
					begin
						SDA_n <= BUS_DATA[2];
						STEP_CNT <= STEP_CNT + 1'B1;
					end
					12 :
					begin
						SDA_n <= BUS_DATA[1];
						STEP_CNT <= STEP_CNT + 1'B1;
					end
					14 :
					begin
						SDA_n <= BUS_DATA[0];
						STEP_CNT <= STEP_CNT + 1'B1;
					end
					16 :								//ACK
					begin
						SDA_n <= 1'B1;
						STEP_CNT <= STEP_CNT + 1'B1;
					end
					17 :
					begin
						STEP_CNT <= 8'B0;
					end
					default :
					begin
						SDA_n <= 1'B1;
						STEP_CNT <= 8'B0;
					end
				endcase
			end
			STOP :
			begin
				case(STEP_CNT)
					0 :
					begin
						SDA_n <= 1'B0;
						STEP_CNT <= STEP_CNT + 1'B1;
					end
					1 :
					begin
						SDA_n <= 1'B1;
						STEP_CNT <= 8'b0;
					end
					default :
					begin
						SDA_n <= 1'B1;
						STEP_CNT <= 8'B0;
					end
				endcase
			end
			default :
			begin
				SDA_n <= 1'B1;
			end
		endcase
	end
end
assign SDA = SDA_n ;
assign SCL = SCL_n ;


endmodule
