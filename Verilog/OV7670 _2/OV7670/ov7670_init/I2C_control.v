module I2C_control
(
	//input
	CLK,RST_N,START,
	//output
	SDA,SCL,DONE
);
//------------------------------------------------------
//-- 外部信号
//------------------------------------------------------
input CLK;
input RST_N;
input START;			//启动初始化信号

output SDA;				
output SCL;
output DONE;			//完成初始化信号


//------------------------------------------------------
//-- 内部信号
//------------------------------------------------------
wire clk_iic;					//IIC时钟
wire [7:0] LUT_INDEX;		//配置序号
wire [15:0] LUT_DATA;		//寄存器初始化数据
wire [23:0] IIC_DATA;		//从机地址+LUT_DATA

wire T_DONE;					//IIC发送模块单次传输完成信号
reg [7:0] LUT_CNT;			//寄存器计数器

reg [7:0] STATE;				//状态机

reg DONE_n;						//完成初始化信号锁存器

wire [7:0] REG_CNT;			//寄存器计数器

reg IIC_GO_n;					//启动IIC传输状态寄存器
wire IIC_GO;					//启动IIC传输信号

//------------------------------------------------------
//-- 参数定义
//------------------------------------------------------
parameter IDLE = 8'D0 ,RUN = 8'D1 ,STOP = 8'D2 ;

//------------------------------------------------------
//-- 
//------------------------------------------------------


//------------------------------------------------------
//-- 
//------------------------------------------------------
always@(posedge CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		STATE <= IDLE ;
		IIC_GO_n <= 1'B0 ;
		DONE_n <= 1'B0 ;
	end
	else 
	begin
		case(STATE)
			IDLE :
			begin
				if(START == 1'B1)
				begin
					STATE <= RUN ;
					IIC_GO_n <= 1'B1;
				end
				else
				begin
					DONE_n <= 1'B0 ;
				end
			end
			RUN :
			begin
				if(LUT_CNT == 165)
				begin
					STATE <= STOP ;
					IIC_GO_n <= 1'B0 ;
				end
				else
				begin
					STATE <= RUN ;
				end
			end
			STOP :
			begin
				DONE_n <= 1'B1 ;
			end
			default :
			begin
				DONE_n <= 1'B0 ;
				IIC_GO_n <= 1'B0 ;
			end
		endcase
	end
end

//------------------------------------------------------
//-- 获取单次传输完成信号,并指示下一次传输
//------------------------------------------------------
always@(posedge T_DONE or negedge RST_N)
begin
	if(!RST_N)
		LUT_CNT <= 8'B0 ;
	else if(STATE == RUN ||STATE == STOP )
	begin
		if(LUT_CNT == 165)
		begin
			LUT_CNT <= 8'B0;
		end
		else
		begin
			LUT_CNT <= LUT_CNT + 1'B1;
		end
	end
	else
	begin
		LUT_CNT <= 8'B0;
	end
end
//------------------------------------------------------
//-- 
//------------------------------------------------------
assign REG_CNT = LUT_CNT ;
assign IIC_GO = IIC_GO_n ;
assign DONE = DONE_n ;
assign IIC_DATA = {8'H42,LUT_DATA};
//------------------------------------------------------
//-- 
//------------------------------------------------------
CLK_DIV_EVEN #(
	//偶分频系数=输入/输出/2
	.N (50)
)
CLK_DIV1
(
	//输入
	.CLK(CLK),
	.RST_N(RST_N),
	//输出
	.CLK_OUT(clk_iic)
);

I2C_T u1
(
	//input
	.CLK(clk_iic),
	.RST_N(RST_N),
	.DATA(IIC_DATA),
	.EN(IIC_GO),
	//output
	.SDA(SDA),
	.SCL(SCL),
	.T_DONE(T_DONE)
);



I2C_OV7670_Config inset1
(
	.LUT_INDEX(REG_CNT),
	.LUT_DATA(LUT_DATA)
);



endmodule
