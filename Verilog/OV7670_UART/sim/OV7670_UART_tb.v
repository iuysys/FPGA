`timescale 1 ns / 1 ps

module OV7670_UART_tb();

reg					SYS_CLK		;
reg					RST_N		;

wire				SCCB_SDA	;
wire				SCCB_SCL	;

reg	[7:0]			OV_data		;
reg					OV_vsync	;
wire				OV_wrst		;
wire				OV_rrst		;
wire				OV_oe		;
wire				OV_wen		;
wire				OV_rclk		;

wire				Txd			;

wire				c1			;

initial begin
	SYS_CLK = 'b0 ;
	RST_N = 'b0 ;
	OV_vsync = 1'b0 ;
	#500 RST_N = 'b1 ;
	$display("Begin Simulation!");
end

always #25 SYS_CLK = ~SYS_CLK ;

always begin
	#90000 OV_vsync = 1'b1 ;
	#40	OV_vsync = 1'b0 ;
end

always@(negedge OV_rclk or negedge RST_N) begin
	if(!RST_N) begin
		OV_data <= 'b0 ;
	end
	else begin
		OV_data <= OV_data + 1'b1 ;
	end
end


OV7670_UART	OV7670_UART_inst(
.SYS_CLK		(SYS_CLK			),
.RST_N			(RST_N				),

.OV_data		(OV_data			),
.OV_vsync		(OV_vsync			),			
.OV_wrst		(OV_wrst			),
.OV_rrst		(OV_rrst			),
.OV_oe			(OV_oe				),
.OV_wen			(OV_wen				),
.OV_rclk		(OV_rclk			),

.SCCB_SDA		(SCCB_SDA			),
.SCCB_SCL		(SCCB_SCL			),
  
.Txd			(Txd				),
.c1				(c1)
);

endmodule