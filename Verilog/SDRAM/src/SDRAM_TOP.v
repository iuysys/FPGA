`timescale 1ns / 1ns
module SDRAM_TOP(
//system inout
input								S_CLK					,			//系统时钟
input								RST_N					,			//系统复位输入
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
input 				[15:0]			sys_write_data			,			//写入SDRAM的数据
input				[1:0]			sys_bank				,
input				[19:0]			sdram_addr				,			//读写SDRAM的地址			
output								fifo_rd_req				,			//读写fifo请求 
output								fifo_rd_clk				,			//写fifo的读时钟  
output 								fifo_wd_req				,           //写读fifo请求
output								fifo_wd_clk				,			//fifo的写时钟
output				[15:0]			sys_read_data			,    		                                         
														

//ctrler interfaces															
input								write_req				,			//控制器输入写SDRAM请求
input								read_req				,			//控制器输入读SDRAM请求
output								write_ack				,			//SDRAM突发写结束
output								read_ack							//SDRAM突发读结束
	
);
//--------------------------------------------------------
//--内部信号
//--------------------------------------------------------
reg					[2:0]			STATE					;
reg					[2:0]			STATE_n					;
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


reg									read_en		            ;
wire				[11:0]			read_addr	            ;
wire				[4:0]			read_cmd	            ;
//--------------------------------------------------------
//--参数定义
//--------------------------------------------------------
localparam		INIT = 3'D0 ,IDLE = 3'D1 ,AREF = 3'D2 ,WRITE = 3'D3,READ = 3'D4;
//---------------------------------------------------
//-- 
//---------------------------------------------------

always @ (posedge S_CLK or negedge RST_N)begin
    if(!RST_N) begin
    	STATE <= INIT ;
    end
    else begin
    	STATE <= STATE_n ;
    end
end

//---------------------------------------------------
//-- 
//---------------------------------------------------

always@(*) begin
	case(STATE)
		INIT :begin
			if(flag_init) begin
				STATE_n <= IDLE ;
			end
			else begin
				STATE_n <= INIT ;
			end
		end
		IDLE :begin
			if(aref_req) begin
				STATE_n <= AREF ;
			end
			else if(write_req) begin
				STATE_n <= WRITE ;
			end
			else if(read_req) begin
				STATE_n <= READ ;
			end
			else begin
				STATE_n <= IDLE ;
			end
		end
		AREF :begin
			if(aref_ack) begin
				STATE_n <= IDLE ;
			end
			else begin
				STATE_n <= AREF ;
			end
		end
		WRITE :begin
			if(aref_req && write_ack) begin
				STATE_n <= AREF ;
			end
			else if(write_ack ) begin
				STATE_n <= IDLE ;				
			end
			else begin
				STATE_n <= WRITE ;
			end
		end
		READ :begin
			if(aref_req && read_ack) begin
				STATE_n <= AREF ;
			end
			else if(read_ack ) begin
				STATE_n <= IDLE ;
			end
			else begin
				STATE_n <= READ ;
			end
		end
		default :begin
			STATE_n <= INIT ;
		end
	endcase
end
//---------------------------------------------------
//-- 
//---------------------------------------------------
always@(posedge S_CLK or negedge RST_N) begin
	if (!RST_N) begin
		
	end
	else begin
		case(STATE_n)
			IDLE :begin
				aref_en <= 1'b0 ;
				write_en <= 1'b0 ;
				read_en <= 1'b0 ;
			end
			AREF :begin
				aref_en <= 1'b1 ;
				write_en <= 1'b0 ;
				read_en <= 1'b0 ;
			end
			WRITE :begin
				aref_en <= 1'b0 ;
				write_en <= 1'b1 ;
				read_en <= 1'b0 ;
			end
			READ :begin
				aref_en <= 1'b0 ;
				write_en <= 1'b0 ;
				read_en <= 1'b1 ;
			end
			default :begin
				aref_en <= 1'b0 ;
				write_en <= 1'b0 ;
				read_en <= 1'b0 ;
			end
		endcase
	end
end

//---------------------------------------------------
//-- 控制线命令输出
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
		READ :begin
			{SDRAM_CKE,SDRAM_CS,SDRAM_RAS,SDRAM_CAS,SDRAM_WE} <= read_cmd ;
			SDRAM_ADDR = read_addr ;
		end
	endcase

end
//---------------------------------------------------
//-- 
//---------------------------------------------------

assign	SDRAM_BANK = sys_bank ;
assign SDRAM_CLK = ~ S_CLK ;
assign SDRAM_DQ = (STATE == WRITE) ? sys_write_data : 16'bZ ;
assign	sys_read_data = SDRAM_DQ ;
assign	SDRAM_DQM = 2'b0 ;
assign fifo_rd_clk = S_CLK ;
assign fifo_wd_clk = S_CLK ;
//---------------------------------------------------
//-- 
SDRAM_init SDRAM_init_inst(
	.S_CLK			(S_CLK		)		,				//系统时钟
	.RST_N			(RST_N		)		,				//系统复位输入
                                
	.init_cmd		(init_cmd	)		,			
	.init_addr		(init_addr	)		,
                                
	.flag_init		(flag_init	)						//初始化完成信号
);


//---------------------------------------------------
//-- 
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

//---------------------------------------------------
//-- 
SDRAM_WRITE SDRAM_WRITE_inst(
	.S_CLK					(S_CLK			),				//系统时钟
	.RST_N					(RST_N			),				//系统复位输入
	                        
	.write_ack				(write_ack		),				//写结束应答
	.write_en				(write_en		),				//仲裁模块输入的写使能信号
	// .aref_req				(aref_req		),
	.fifo_rd_req			(fifo_rd_req	),
	.sdram_addr				(sdram_addr		),
	.write_addr				(write_addr		),
	.write_cmd			    (write_cmd		)
); 
//---------------------------------------------------
//-- 
SDRAM_READ SDRAM_READ_inst(
	.S_CLK					(S_CLK			),				//系统时钟
	.RST_N					(RST_N			),				//系统复位输入
	
	.read_ack				(read_ack		),				//读结束应答
	.read_en				(read_en		),				//仲裁模块输入的读使能信号
	// .aref_req				(aref_req		),
	.fifo_wd_req			(fifo_wd_req	),
	.sdram_addr				(sdram_addr		),
	.read_addr				(read_addr		),
	.read_cmd				(read_cmd		)
);


endmodule