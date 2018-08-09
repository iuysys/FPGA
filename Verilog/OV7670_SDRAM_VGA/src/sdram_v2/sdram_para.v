//---------------------------------------------------
//-- 
`define		ROWSIZE			12
`define		COLSIZE			8
`define		DATASIZE		16
`define		BANKSIZE		2
`define		DQMSIZE			2
`define		CLK_FREQ		100				//MHz
`define		BURST_LENGTH	256
`define		CAS_LATENCY		2	
`define		WRITE_LENGTH	320	
`define		READ_LENGTH		320		
//---------------------------------------------------
//-- 控制线命令CKE-CS-RAS-CAS-WE
`define 	MRS			5'b1_0000
`define 	NOP			5'b1_0111
`define 	ACT			5'b1_0011
`define 	READ		5'b1_0101
`define 	WRITE		5'b1_0100
`define 	PRE			5'b1_0010
`define 	AREF		5'b1_0001
`define		BURST_STOP	5'b1_0110
//---------------------------------------------------
//-- 时间参数:N个时钟
`define		POWER_ON_WAIT_TIME	200 * `CLK_FREQ			//上电等待时间
`define		Trp			2								//18ns
`define		Trc			8								//60ns
`define		Tmrd		2								//12ns
`define		Trcd		2								//20ns
`define		AUTO_REF_TIME	15000/10						
//---------------------------------------------------
//-- 


