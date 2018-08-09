module OV7670_top(
input							S_CLK		,
input							RST_N		,
                                            
output							SCCB_SDA	,
output							SCCB_SCL	,

input 				[7:0]		OV_data		,
input							OV_vsync	,			
output							OV_wrst		,
output							OV_rrst		,
output							OV_oe		,
output							OV_wen		,
output							OV_rclk		,
				
input				[8:0]		w_usedw		,
output							w_req		,
output							w_clk		,
output				[15:0]		w_data		

);

wire						CLK_DIV			;

wire						start_init		;
wire						init_done		;
											

wire						SCCB_busy		;


wire	[23:0] 				data_in			;
wire						SCCB_req		;


wire	[7:0]				LUT_INDEX		;
wire	[15:0]				LUT_DATA		;



assign data_in = {8'h42,LUT_DATA};



CLK_DIV_EVEN 	CLK_DIV_EVEN_inst(
.CLK_IN			(S_CLK					),
.RST_N			(RST_N					),
                
.CLK_DIV		(CLK_DIV				)	
);


I2C_OV7670_conf		I2C_OV7670_conf_inst(
.S_CLK			(S_CLK					),
.RST_N			(RST_N					),

.start_init		(start_init				),
.init_done		(init_done				),

.SCCB_req		(SCCB_req				),
.SCCB_busy		(SCCB_busy				),

.LUT_INDEX      (LUT_INDEX				)

);


I2C_Write		I2C_Write_inst(
.CLK			(CLK_DIV				),				//3MHz > CLK > 1.1MHz
.RST_N			(RST_N					),
.data_in		(data_in				),				//从机地址+寄存器地址+数据
.SCCB_req		(SCCB_req				),

.SCCB_SDA		(SCCB_SDA				),				
.SCCB_SCL		(SCCB_SCL				),				//输入时钟/4
.SCCB_busy		(SCCB_busy				)			
);


I2C_OV7670_LUT	I2C_OV7670_LUT_inst(
	.LUT_INDEX	(LUT_INDEX				),
	.LUT_DATA   (LUT_DATA				)
);


OV7670_Capture	OV7670_Capture_inst(
.S_CLK			(S_CLK					),
.RST_N			(RST_N					),

// .init_done		(1'b1				),
.init_done		(init_done				),
.start_init		(start_init				),

.OV_data		(OV_data				),
.OV_vsync		(OV_vsync				),			
.OV_wrst		(OV_wrst				),
.OV_rrst		(OV_rrst				),
.OV_oe			(OV_oe					),
.OV_wen			(OV_wen					),
.OV_rclk		(OV_rclk				),
                 
.w_usedw		(w_usedw				),
.w_req			(w_req					),
.w_clk			(w_clk					),
.w_data		    (w_data					)

);












endmodule