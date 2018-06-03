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
output					RDCLK;			
output 	reg			RDREQ;



//------------------------------------------------------
//-- 内部端口
//------------------------------------------------------

reg 	[15:0] 	baud_count;						//波特率计数器
reg 	[7:0] 	bit_cnt;							//发送位计数

reg 	[1:0] 	STATE;							//发送器的状态

reg 				rdclk_en ;						//读时钟使能
reg	[7:0]		tx_data ;

//------------------------------------------------------
//-- 参数定义
//------------------------------------------------------
localparam BAUD = 115200 ;							//
localparam SYS_CLK_PERIOD = 50 ;					//
localparam IDLE = 2'D0 ,GET_DATA = 2'D1 ,SEND = 2'D2 ;
localparam BAUD_CNT_END = 1_000_000_000 / BAUD / SYS_CLK_PERIOD ;



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
		if(baud_count == BAUD_CNT_END)
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
		if(baud_count == BAUD_CNT_END)
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
					9 ,10:
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
		rdclk_en <= 1'b0 ;
		RDREQ <= 1'B0 ;
	end
	else
	begin
		case(STATE)
			IDLE :
			begin
				if(TX_REQ == 1'b0)
				begin
					STATE <= GET_DATA;
					rdclk_en <= 1'b1 ;
					RDREQ <= 1'B1 ;
				end
				else
				begin
					STATE <= IDLE;
					rdclk_en <= 1'b0 ;
					RDREQ <= 1'B0 ;
				end 
			end
			GET_DATA :
			begin
				tx_data <= DATA_IN ;
				rdclk_en <= 1'b0 ;
				RDREQ <= 1'B0 ;
				STATE <= SEND;
			end
			SEND :
			begin
				if(bit_cnt == 8'D10)
				begin
					STATE <= IDLE;
				end
				else
				begin
					STATE <= SEND;
				end
			end
			default :
				STATE <= IDLE;
		endcase
	end
end
//------------------------------------------------------
//assign RDCLK = rdclk_en == 1'b1 ? ~SYS_CLK : 1'B0 ;
assign RDCLK =  ~SYS_CLK ;




endmodule
