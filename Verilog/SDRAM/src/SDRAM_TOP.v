`timescale 1ns / 1ns
module SDRAM_TOP(
//system inout
input								S_CLK					,				//系统时钟
input								RST_N					,				//系统复位输入
//SDRAM interfaces
output								SDRAM_CLK				,			//SDRAM时钟
output		reg						SDRAM_CKE				,			//时钟使能
output		reg						SDRAM_CS				,			//片选
output		reg						SDRAM_RAS				,			//行地址选通信号,低电平
output		reg						SDRAM_CAS				,			//列地址选通信号,低电平
output		reg						SDRAM_WE				,			//写使能,低电平
output				[1:0]			SDRAM_BANK				,			//BANK选择
output		reg		[11:0]			SDRAM_ADDR				,			//地址线
inout				[15:0]			SDRAM_DQ				,			//数据线
output				[1:0]			SDRAM_DQM				,			//掩码线
//Write SDRAM fifo interfaces                                                           
input 				[15:0]			sdram_data				,			//写入SDRAM的数据
input				[19:0]			sdram_addr				,			
output								fifo_rd_req				,                                                           
//Read SDRAM fifo interfaces															

//ctrler interfaces															
input								write_req				,
output								write_ack				
	
);
//--------------------------------------------------------
//--内部信号
//--------------------------------------------------------
reg					[2:0]			STATE					;
wire								flag_init				;				//初始化完成标志
wire				[4:0]			init_cmd				;
wire				[11:0]			init_addr	            ;
                                                                       
wire								aref_req				;
wire								aref_ack				;
wire				[4:0]			aref_cmd				;
wire				[11:0]			aref_addr	            ;
reg									aref_en					;
reg									write_en				;
                                                            

wire				[4:0]			write_cmd				;
wire				[11:0]			write_addr	            ;

//--------------------------------------------------------
//--参数定义
//--------------------------------------------------------
localparam		INIT = 3'D0 ,IDLE = 3'D1 ,AREF = 3'D2 ,WRITE = 3'D3;


always@(posedge S_CLK or negedge RST_N) begin
	if(!RST_N)	begin
		STATE <= INIT ;
		aref_en <= 1'b0 ;
		write_en <= 1'b0 ;
	end
	else begin
		case(STATE)
			INIT :begin
				if(flag_init) begin
					STATE <= IDLE ;
				end
				else begin
					STATE <= INIT ;
				end
			end
			IDLE :begin
				if(aref_req) begin
					STATE <= AREF ;
				end
				else if(write_req) begin
					STATE <= WRITE ;
				end
				else begin
					STATE <= IDLE ;
				end
			end
			AREF :begin
				if(aref_ack) begin
					aref_en <= 1'b0 ;
					STATE <= IDLE ;
				end
				else begin
					aref_en <= 1'b1 ;
				end
			end
			WRITE :begin
				if(~write_req && write_ack ) begin
					STATE <= IDLE ;
					write_en <= 1'b0 ;
					
				end
				else if(aref_req && write_ack) begin
					STATE <= AREF ;
					write_en <= 1'b0 ;
				end
				else begin
					STATE <= WRITE ;
					write_en <= 1'b1 ;
				end
			end
			default :begin
				STATE <= INIT ;
			end
		endcase
	end
end

//控制线命令输出
always@(*)begin
	case(STATE)
		INIT :begin
			{SDRAM_CKE,SDRAM_CS,SDRAM_RAS,SDRAM_CAS,SDRAM_WE} <= init_cmd ;
			SDRAM_ADDR = init_addr ;
		end
		AREF :begin
			{SDRAM_CKE,SDRAM_CS,SDRAM_RAS,SDRAM_CAS,SDRAM_WE} <= aref_cmd ;
			SDRAM_ADDR = aref_addr ;
		end
		WRITE :begin
			{SDRAM_CKE,SDRAM_CS,SDRAM_RAS,SDRAM_CAS,SDRAM_WE} <= write_cmd ;
			SDRAM_ADDR = write_addr ;
		end
	endcase

end
assign	SDRAM_BANK = 2'b00 ;
assign SDRAM_CLK = ~ S_CLK ;
assign SDRAM_DQ = (STATE == WRITE) ? sdram_data : 16'bZ ;
// assign	SDRAM_DQ = sdram_data ;
assign	SDRAM_DQM = 2'b0 ;

SDRAM_init SDRAM_init_inst(
	.S_CLK			(S_CLK		)		,				//系统时钟
	.RST_N			(RST_N		)		,				//系统复位输入
                                
	.init_cmd		(init_cmd	)		,			
	.init_addr		(init_addr	)		,
                                
	.flag_init		(flag_init	)						//初始化完成信号
);



SDRAM_AREF SDRAM_AREF_inst(
	.S_CLK			(S_CLK		)	,
	.RST_N			(RST_N		)	,
	            
	.aref_req		(aref_req	)	,	//自刷新请求
	.aref_en		(aref_en	)	,	//自刷新使能
	.aref_ack		(aref_ack	)	,	//自刷新应答
	.aref_cmd		(aref_cmd	)	,	//命令寄存器
	.aref_addr		(aref_addr	)	,	//地址线寄存器
	.flag_init		(flag_init	)		//初始化完成信号	
);


SDRAM_WRITE SDRAM_WRITE_inst(
	.S_CLK					(S_CLK			),				//系统时钟
	.RST_N					(RST_N			),				//系统复位输入
	                        
	.write_ack				(write_ack		),				//写结束应答
	.write_en				(write_en		),				//仲裁模块输入的写使能信号
	.aref_req				(aref_req		),
	.fifo_rd_req			(fifo_rd_req	),
	.sdram_addr				(sdram_addr		),
	.write_addr				(write_addr		),
	.write_cmd			    (write_cmd		)
); 



endmodule