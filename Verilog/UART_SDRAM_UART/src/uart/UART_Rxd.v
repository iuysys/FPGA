//---------------------------------------------------
//-- 
//---------------------------------------------------
//1.需要优化超高量字节接收丢帧的BUG		---- 2018-08-09 17:27:26 August Thursday	

//---------------------------------------------------
//-- 
//---------------------------------------------------

module UART_Rxd(
input 							SYS_CLK			,
input							RST_N			,
input							Rxd				,						
                                              
output	reg		[7:0]			rx_data			,					//接收字节数据
output 	reg 					rx_busy								//单字节接收完成信号
);
//-------------------------------------------------------
//-- 
//-------------------------------------------------------


//-------------------------------------------------------
//-- 内部信号定义
//-------------------------------------------------------
reg		[1:0] 					state				;
reg		[1:0]					state_n				;
reg 	[15:0] 					baud_count			;				//波特率计数器
reg								n_edge_now 			;
reg								n_edge_pre			;
reg		[4:0]					bit_cnt				;

wire							flag_half_buad		;

reg		[7:0]					shift_data			;				//移位寄存器
reg		[7:0]					shift_data_n		;				//移位寄存器

wire							rx_start			;

//-------------------------------------------------------
//-- 常量定义
//-------------------------------------------------------
localparam BAUD = 115200 ;														//波特率
localparam SYS_CLK_PERIOD = 50 ;													//系统时钟周期
localparam BAUD_CNT_END = 1_000_000_000 / BAUD / SYS_CLK_PERIOD ;					//波特率计数值
localparam HALF_BAUD_CNT = BAUD_CNT_END / 2 ;										//采样点

localparam IDLE = 2'd0 ,READ = 2'd1 ,STOP = 2'd2 ;									//状态

//------------------------------------------------------
//-- 波特率发生器
//------------------------------------------------------
always@(posedge SYS_CLK or negedge RST_N) begin
	if(!RST_N) begin
		baud_count <= 16'b0;
	end
	else if(state_n != IDLE) begin
		if(baud_count == BAUD_CNT_END ) begin
			baud_count <= 16'b0 ;
		end
		else begin
			baud_count <= baud_count + 1'b1 ;
		end
	end
	else begin
		baud_count <= 16'b0;
	end
end
//-- 产生采样信号
assign flag_half_buad = (baud_count == HALF_BAUD_CNT) ? 1'b1 : 1'b0 ;

//-------------------------------------------------------
//-- 起始信号检测
//-------------------------------------------------------
always @(posedge SYS_CLK or negedge RST_N ) begin
	if(!RST_N) begin
		n_edge_now <= 1'b1 ;
		n_edge_pre <= 1'b1 ;
	end
	else begin
		n_edge_now <= Rxd ;
		n_edge_pre <= n_edge_now ;
	end
end
//-- 组合逻辑输出
assign rx_start = ( n_edge_pre == 1'b1 && n_edge_now == 1'b0) ? 1'b1 : 1'b0 ;
//------------------------------------------------------
//-- 状态转换
//------------------------------------------------------
always@(posedge SYS_CLK or negedge RST_N) begin
	if(!RST_N) begin
		state <= IDLE ;
	end
	else begin
		state <= state_n ;
	end
end
//------------------------------------------------------
//-- 状态判断
//------------------------------------------------------
always@(*) begin
	case(state)
		IDLE : begin
			if(rx_start) begin
				state_n = READ ;
			end
			else begin
				state_n = IDLE ;
			end
		end
		READ : begin
			if(bit_cnt == 'd9 && baud_count == BAUD_CNT_END) begin
				state_n = STOP ;
			end
			else begin
				state_n = READ ;
			end
		end
		STOP : begin
			if(baud_count == BAUD_CNT_END) begin
				state_n = IDLE ;
			end
			else begin
				state_n = STOP ;
			end 
		end
		default : begin
			state_n = IDLE ;
		end
	endcase
end
//------------------------------------------------------
//-- 
//------------------------------------------------------
always@(posedge SYS_CLK or negedge RST_N) begin
	if(!RST_N) begin
		bit_cnt <= 'b0 ;
		shift_data <= 'b0 ;
		rx_data <= 'b0 ;
	end
	else begin
		case(state_n)
			IDLE : begin
				rx_busy <= 1'b0 ;
				bit_cnt <= 'b0 ;
				shift_data <= 'b0 ;
			end
			READ : begin
				if(flag_half_buad) begin
					shift_data <= shift_data_n ;
					bit_cnt <= bit_cnt + 1'b1 ;
				end
				rx_busy <= 1'b1 ;
			end
			STOP : begin
				rx_data <= shift_data ;
			end
		endcase
	end
end
//------------------------------------------------------
//-- 采样并移位
//------------------------------------------------------
always@(*) begin
	if(flag_half_buad) begin
		shift_data_n = {Rxd,shift_data[7:1]};
	end
	else begin
		shift_data_n = shift_data ;
	end
end



endmodule
































