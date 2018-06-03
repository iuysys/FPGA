module UART_TXD(
	//输入
	SYS_CLK,RST_N,DATA_IN,TX_REQ,
	//输出
	TXD,RDCLK,RDREQ
);

//------------------------------------------------------
//-- 外部端口
//------------------------------------------------------
input 					SYS_CLK;					//输入系统时钟
input 					RST_N;					//复位
input		[7:0] 		DATA_IN;					//写入数据
input 					TX_REQ;					//发送请求

output	reg			TXD;						//发送引脚
output					RDCLK;					//FIFO的读时钟			
output 	reg			RDREQ;					//FIFO的读请求



//------------------------------------------------------
//-- 内部端口
//------------------------------------------------------

reg 	[15:0] 	baud_count;						//波特率计数器
reg 	[7:0] 	bit_cnt;							//发送位计数
reg 	[7:0]		step_cnt;						//步骤计数器

reg 	[1:0] 	STATE;							//发送器的状态

reg	[7:0]		tx_data ;						//TX脚将要发送的数据寄存器

//------------------------------------------------------
//-- 参数定义
//------------------------------------------------------
localparam BAUD = 256000 ;															//波特率
localparam SYS_CLK_PERIOD = 50 ;													//系统时钟周期
localparam IDLE = 2'D0 ,GET_DATA = 2'D1 ,SEND = 2'D2 ;					//状态机状态
localparam BAUD_CNT_END = 1_000_000_000 / BAUD / SYS_CLK_PERIOD ;		//波特率计数值
localparam CMD = 8'H01 ;															//串口调试助手协议选择


//------------------------------------------------------
//-- 波特率发生器
//------------------------------------------------------
always@(posedge SYS_CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		baud_count <= 16'b0;
	end
	else if(STATE == SEND )
	begin
		if(baud_count > BAUD_CNT_END - 1)
		begin
			baud_count <= 16'b0 ;
		end
		else
		begin
			baud_count <= baud_count + 1'b1 ;
		end
	end
	else 
	begin
		baud_count <= 16'b0;
	end
end
//------------------------------------------------------
//-- BIT位计数
//------------------------------------------------------
always@(posedge SYS_CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		bit_cnt <= 8'b0;
	end
	else if(STATE == SEND)
	begin
		if(baud_count > BAUD_CNT_END - 1)
			bit_cnt <= bit_cnt + 1'b1 ;
	end
	else
		bit_cnt <= 8'b0;
end
//------------------------------------------------------
//-- TXD发送信号
//------------------------------------------------------
always@(posedge SYS_CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		TXD <= 1'B1 ;
	end
	else
	begin
		case(STATE)
			IDLE :
			begin
				TXD <= 1'B1 ;
			end
			GET_DATA :
			begin
				TXD <= 1'B1 ;
			end
			SEND :
				case(bit_cnt)
					0 :
					begin
						TXD <= 1'B0 ;
					end
					1 :
					begin
						TXD <= tx_data[0];
					end
					2 :
					begin
						TXD <= tx_data[1];
					end
					3 :
					begin
						TXD <= tx_data[2];
					end
					4 :
					begin
						TXD <= tx_data[3];
					end 
					5 :
					begin
						TXD <= tx_data[4];
					end
					6 :
					begin
						TXD <= tx_data[5];
					end
					7 :
					begin
						TXD <= tx_data[6];
					end
					8 :
					begin
						TXD <= tx_data[7];
					end
					9 ,10:							//停止位--空闲位
					begin
						TXD <= 1'B1 ;
					end
					default :
						TXD <= 1'B1 ;
				endcase
			default :
				TXD <= 1'B1 ;
		endcase
	end
end

//------------------------------------------------------
//-- 状态机
//------------------------------------------------------
always@(posedge SYS_CLK or negedge RST_N)
begin
	if(!RST_N)
	begin
		STATE <= IDLE;
		RDREQ <= 1'B0 ;
		step_cnt <= 8'b0 ;
	end
	else
	begin
		case(STATE)
			IDLE :
			begin
				if(TX_REQ == 1'b0)			//FIFO非空
				begin
					STATE <= GET_DATA;
				end
				else
				begin
					STATE <= IDLE;
					RDREQ <= 1'B0 ;
					step_cnt <= 8'b0 ;
				end 
			end
			GET_DATA :
			begin
				case(step_cnt)
					0 :
						tx_data <= CMD ;
					1 :
						tx_data <= ~CMD ;
					2 , 3:
						tx_data <= 16'h0000 ;
					4 :
						tx_data <= ~CMD ;
					5 :
						tx_data <= CMD ;
					default :
						tx_data <= CMD ;
				endcase
				RDREQ <= 1'B0 ;
				STATE <= SEND ;
			end
			SEND :
			begin
				if(bit_cnt == 8'd10)
				begin
					step_cnt = step_cnt + 1'b1 ;
					if(step_cnt == 8'd2 || step_cnt == 8'd3)
					begin
						RDREQ <= 1'B1 ;
						STATE <= GET_DATA;
					end
					else if(step_cnt == 8'd6)
					begin
						STATE <= IDLE;
						step_cnt <= 8'b0 ;
					end
					else
					begin
						RDREQ <= 1'B0 ;
						STATE <= GET_DATA;
					end
				end
				
			end
			default :
				STATE <= IDLE;
		endcase
	end
end
//------------------------------------------------------
assign RDCLK =  ~SYS_CLK ;

endmodule
