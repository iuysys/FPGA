/*-------------------------------------------------------------------------
This confidential and proprietary software may be only used as authorized
by a licensing agreement from CrazyBingo.www.cnblogs.com/crazybingo
(C) COPYRIGHT 2012 CrazyBingo. ALL RIGHTS RESERVED
Filename			:		led_matrix_display.v
Author				:		CrazyBingo
Data				:		2012-01-18
Version				:		1.0
Description			:		I2C Configure Data of OV7670.
Modification History	:
Data			By			Version			Change Description
===========================================================================
12/05/11		CrazyBingo	1.0				Original
12/05/13		CrazyBingo	1.1				Modification
12/06/01		CrazyBingo	1.4				Modification
12/06/05		CrazyBingo	1.5				Modification
--------------------------------------------------------------------------*/

`timescale 1ns/1ns
module	I2C_OV7670_LUT(
	input		[7:0]	LUT_INDEX,
	output	reg	[15:0]	LUT_DATA
);


//parameter	Read_DATA	=	0;			//Read data LUT Address
parameter	SET_OV7670	=	0;			//SET_OV LUT Adderss
/////////////////////	Config Data LUT	  //////////////////////////	
always@(*)
begin
	case(LUT_INDEX)
	//Audio Config Data
	//Read Data Index
//	Read_DATA + 0 :		LUT_DATA	=	{8'h0A, 8'h76};	//PID	厂商高位识别号 （只读） 
//	Read_DATA + 1 :		LUT_DATA	=	{8'h0B, 8'h73};	//VER	厂商低位识别号 （只读）
	// Read_DATA + 0 :		LUT_DATA	=	{8'h1C, 8'h7F};	//MIDH	厂商识别字节-高（只读）
	// Read_DATA + 1 :		LUT_DATA	=	{8'h1D, 8'hA2};	//MIDL	厂商识别字节-低（只读）
	//OV7670 : VGA RGB565
	SET_OV7670 + 0 	: 	LUT_DATA	= 	{8'h3a, 8'h04};	
	SET_OV7670 + 1 	: 	LUT_DATA	= 	{8'h40, 8'hd0};
	SET_OV7670 + 2 	: 	LUT_DATA	= 	{8'h12, 8'h14};	
	SET_OV7670 + 3 	: 	LUT_DATA	= 	{8'h32, 8'h80};	
	SET_OV7670 + 4 	: 	LUT_DATA	= 	{8'h17, 8'h16};	
	SET_OV7670 + 5 	: 	LUT_DATA	= 	{8'h18, 8'h04};	
	SET_OV7670 + 6 	: 	LUT_DATA	= 	{8'h19, 8'h02};	
	SET_OV7670 + 7 	: 	LUT_DATA	= 	{8'h1a, 8'h7b};	
	SET_OV7670 + 8 	: 	LUT_DATA	= 	{8'h03, 8'h06};	
	SET_OV7670 + 9 	: 	LUT_DATA	= 	{8'h0c, 8'h00};
	SET_OV7670 + 10 : 	LUT_DATA	= 	{8'h15, 8'h00};
	SET_OV7670 + 11 : 	LUT_DATA	= 	{8'h3e, 8'h00};			//
	SET_OV7670 + 12 : 	LUT_DATA	= 	{8'h70, 8'h3a};	
	SET_OV7670 + 13 : 	LUT_DATA	= 	{8'h71, 8'h35};
	SET_OV7670 + 14 : 	LUT_DATA	= 	{8'h72, 8'h11};
	SET_OV7670 + 15 : 	LUT_DATA	= 	{8'h73, 8'h00};
	SET_OV7670 + 16 : 	LUT_DATA	= 	{8'ha2, 8'h02};	
	SET_OV7670 + 17 : 	LUT_DATA	= 	{8'h11, 8'h81};
	SET_OV7670 + 18 : 	LUT_DATA	= 	{8'h7a, 8'h20};
	SET_OV7670 + 19 : 	LUT_DATA	= 	{8'h7b, 8'h1c};
	SET_OV7670 + 20 : 	LUT_DATA	= 	{8'h7c, 8'h28};
	SET_OV7670 + 21 : 	LUT_DATA	= 	{8'h7d, 8'h3c};
	SET_OV7670 + 22 : 	LUT_DATA	= 	{8'h7e, 8'h55};
	SET_OV7670 + 23 : 	LUT_DATA	= 	{8'h7f, 8'h68};
	SET_OV7670 + 24 : 	LUT_DATA	= 	{8'h80, 8'h76};
	SET_OV7670 + 25 : 	LUT_DATA	= 	{8'h81, 8'h80};
	SET_OV7670 + 26 : 	LUT_DATA	= 	{8'h82, 8'h88};
	SET_OV7670 + 27 : 	LUT_DATA	= 	{8'h83, 8'h8f};
	SET_OV7670 + 28 : 	LUT_DATA	= 	{8'h84, 8'h96};
	SET_OV7670 + 29 : 	LUT_DATA	= 	{8'h85, 8'ha3};
	SET_OV7670 + 30 : 	LUT_DATA	= 	{8'h86, 8'haf};
	SET_OV7670 + 31 : 	LUT_DATA	= 	{8'h87, 8'hc4};
	SET_OV7670 + 32 : 	LUT_DATA	= 	{8'h88, 8'hd7};
	SET_OV7670 + 33 : 	LUT_DATA	= 	{8'h89, 8'he8};
	SET_OV7670 + 34 : 	LUT_DATA	= 	{8'h13, 8'he0};
	SET_OV7670 + 35 : 	LUT_DATA	= 	{8'h00, 8'h00};
	SET_OV7670 + 36 : 	LUT_DATA	= 	{8'h10, 8'h00};
	SET_OV7670 + 37 : 	LUT_DATA	= 	{8'h0d, 8'h00};	
	SET_OV7670 + 38 : 	LUT_DATA	= 	{8'h14, 8'h28};
	SET_OV7670 + 39 : 	LUT_DATA	= 	{8'ha5, 8'h05};
	SET_OV7670 + 40 : 	LUT_DATA	= 	{8'hab, 8'h07};
	SET_OV7670 + 41 : 	LUT_DATA	= 	{8'h24, 8'h75};
	SET_OV7670 + 42 : 	LUT_DATA	= 	{8'h25, 8'h63};
	SET_OV7670 + 43 : 	LUT_DATA	= 	{8'h26, 8'hA5};
	SET_OV7670 + 44 : 	LUT_DATA	= 	{8'h9f, 8'h78};
	SET_OV7670 + 45 : 	LUT_DATA	= 	{8'ha0, 8'h68};
	SET_OV7670 + 46 : 	LUT_DATA	= 	{8'ha1, 8'h03};
	SET_OV7670 + 47 : 	LUT_DATA	= 	{8'ha6, 8'hdf};
	SET_OV7670 + 48 : 	LUT_DATA	= 	{8'ha7, 8'hdf};
	SET_OV7670 + 49 : 	LUT_DATA	= 	{8'ha8, 8'hf0};
	SET_OV7670 + 50 : 	LUT_DATA	= 	{8'ha9, 8'h90};
	SET_OV7670 + 51 : 	LUT_DATA	= 	{8'haa, 8'h94};	
	SET_OV7670 + 52 : 	LUT_DATA	= 	{8'h13, 8'he5};
	SET_OV7670 + 53 : 	LUT_DATA	= 	{8'h0e, 8'h61};
	SET_OV7670 + 54 : 	LUT_DATA	= 	{8'h0f, 8'h4b};
	SET_OV7670 + 55 : 	LUT_DATA	= 	{8'h16, 8'h02};
	                                    
	SET_OV7670 + 56 : 	LUT_DATA	= 	{8'h1e, 8'h04};
	SET_OV7670 + 57 : 	LUT_DATA	= 	{8'h21, 8'h02};
	SET_OV7670 + 58 : 	LUT_DATA	= 	{8'h22, 8'h91};
	SET_OV7670 + 59 : 	LUT_DATA	= 	{8'h29, 8'h07};
	SET_OV7670 + 60 : 	LUT_DATA	= 	{8'h33, 8'h0b};
	SET_OV7670 + 61 : 	LUT_DATA	= 	{8'h35, 8'h0b};
	SET_OV7670 + 62 : 	LUT_DATA	= 	{8'h37, 8'h1d};
	SET_OV7670 + 63 : 	LUT_DATA	= 	{8'h38, 8'h71};
	SET_OV7670 + 64 : 	LUT_DATA	= 	{8'h39, 8'h2a};
	SET_OV7670 + 65 : 	LUT_DATA	= 	{8'h3c, 8'h78};
	SET_OV7670 + 66 : 	LUT_DATA	= 	{8'h4d, 8'h40};
	SET_OV7670 + 67 : 	LUT_DATA	= 	{8'h4e, 8'h20};
	SET_OV7670 + 68 : 	LUT_DATA	= 	{8'h69, 8'h00};
	SET_OV7670 + 69 : 	LUT_DATA	= 	{8'h6b, 8'h40};			//
	SET_OV7670 + 70 : 	LUT_DATA	= 	{8'h74, 8'h19};
	SET_OV7670 + 71 : 	LUT_DATA	= 	{8'h8d, 8'h4f};
	SET_OV7670 + 72 : 	LUT_DATA	= 	{8'h8e, 8'h00};
	SET_OV7670 + 73 : 	LUT_DATA	= 	{8'h8f, 8'h00};
	SET_OV7670 + 74 : 	LUT_DATA	= 	{8'h90, 8'h00};
	SET_OV7670 + 75 : 	LUT_DATA	= 	{8'h91, 8'h00};
	SET_OV7670 + 76 : 	LUT_DATA	= 	{8'h92, 8'h00};
	SET_OV7670 + 77 : 	LUT_DATA	= 	{8'h96, 8'h00};
	SET_OV7670 + 78 : 	LUT_DATA	= 	{8'h9a, 8'h80};
	SET_OV7670 + 79 : 	LUT_DATA	= 	{8'hb0, 8'h84};
	SET_OV7670 + 80 : 	LUT_DATA	= 	{8'hb1, 8'h0c};
	SET_OV7670 + 81 : 	LUT_DATA	= 	{8'hb2, 8'h0e};
	SET_OV7670 + 82 : 	LUT_DATA	= 	{8'hb3, 8'h82};
                                        
	SET_OV7670 + 83  :	LUT_DATA	=	{8'hb8, 8'h0a};
	SET_OV7670 + 84  :	LUT_DATA	=	{8'h43, 8'h14};
	SET_OV7670 + 85  :	LUT_DATA	=	{8'h44, 8'hf0};
	SET_OV7670 + 86  :	LUT_DATA	=	{8'h45, 8'h34};
	SET_OV7670 + 87  :	LUT_DATA	=	{8'h46, 8'h58};
	SET_OV7670 + 88  :	LUT_DATA	=	{8'h47, 8'h28};
	SET_OV7670 + 89  :	LUT_DATA	=	{8'h48, 8'h3a};
	SET_OV7670 + 90  :	LUT_DATA	=	{8'h59, 8'h88};
	SET_OV7670 + 91  :	LUT_DATA	=	{8'h5a, 8'h88};
	SET_OV7670 + 92  :	LUT_DATA	=	{8'h5b, 8'h44};
	SET_OV7670 + 93  :	LUT_DATA	=	{8'h5c, 8'h67};
	SET_OV7670 + 94  :	LUT_DATA	=	{8'h5d, 8'h49};
	SET_OV7670 + 95  :	LUT_DATA	=	{8'h5e, 8'h0e};
	SET_OV7670 + 96  :	LUT_DATA	=	{8'h64, 8'h04};
	SET_OV7670 + 97  :	LUT_DATA	=	{8'h65, 8'h20};
	SET_OV7670 + 98  :	LUT_DATA	=	{8'h66, 8'h05};
	SET_OV7670 + 99  :	LUT_DATA	=	{8'h94, 8'h04};
	SET_OV7670 + 100 :	LUT_DATA	=	{8'h95, 8'h08};
	SET_OV7670 + 101 :	LUT_DATA	=	{8'h6c, 8'h0a};
	SET_OV7670 + 102 :	LUT_DATA	=	{8'h6d, 8'h55};
	SET_OV7670 + 103 :	LUT_DATA	=	{8'h4f, 8'h80};
	SET_OV7670 + 104 :	LUT_DATA	=	{8'h50, 8'h80};
	SET_OV7670 + 105 :	LUT_DATA	=	{8'h51, 8'h00};
	SET_OV7670 + 106 :	LUT_DATA	=	{8'h52, 8'h22};
	SET_OV7670 + 107 :	LUT_DATA	=	{8'h53, 8'h5e};
	SET_OV7670 + 108 :	LUT_DATA	=	{8'h54, 8'h80};
	                                    
	                                    
	SET_OV7670 + 109 :	LUT_DATA	= 	{8'h09, 8'h03};
	SET_OV7670 + 110 :	LUT_DATA	= 	{8'h6e, 8'h11};
	SET_OV7670 + 111 :	LUT_DATA	= 	{8'h6f, 8'h9f};
	SET_OV7670 + 112 :	LUT_DATA	= 	{8'h55, 8'h00};
	SET_OV7670 + 113 :	LUT_DATA	= 	{8'h56, 8'h40};
	SET_OV7670 + 114 :	LUT_DATA	= 	{8'h57, 8'h40};
	SET_OV7670 + 115 :	LUT_DATA	= 	{8'h6a, 8'h40};
	                                    
	                                    
	SET_OV7670 + 116 : 	LUT_DATA	=	{8'h01, 8'h40};
	SET_OV7670 + 117 : 	LUT_DATA	=	{8'h02, 8'h40};
	SET_OV7670 + 118 : 	LUT_DATA	=	{8'h13, 8'he7};
	SET_OV7670 + 119 : 	LUT_DATA	=	{8'h15, 8'h00};
	SET_OV7670 + 120 : 	LUT_DATA	=	{8'h58, 8'h9e};
	SET_OV7670 + 121 : 	LUT_DATA	=	{8'h41, 8'h08};
	SET_OV7670 + 122 : 	LUT_DATA	=	{8'h3f, 8'h00};
	SET_OV7670 + 123 : 	LUT_DATA	=	{8'h75, 8'h05};
	SET_OV7670 + 124 : 	LUT_DATA	=	{8'h76, 8'he1};
	SET_OV7670 + 125 : 	LUT_DATA	=	{8'h4c, 8'h00};
	SET_OV7670 + 126 : 	LUT_DATA	=	{8'h77, 8'h01};
	                                    
	                                    
	SET_OV7670 + 127 : 	LUT_DATA	=	{8'h3d, 8'hc2};
	SET_OV7670 + 128 : 	LUT_DATA	=	{8'h4b, 8'h09};
	SET_OV7670 + 129 : 	LUT_DATA	=	{8'hc9, 8'h60};	//
	SET_OV7670 + 130 : 	LUT_DATA	=	{8'h41, 8'h38};
	SET_OV7670 + 131 : 	LUT_DATA	=	{8'h34, 8'h11};
	SET_OV7670 + 132 : 	LUT_DATA	=	{8'h3b, 8'h02};
	SET_OV7670 + 133 : 	LUT_DATA	=	{8'ha4, 8'h89};
	SET_OV7670 + 134 : 	LUT_DATA	=	{8'h96, 8'h00};
	SET_OV7670 + 135 : 	LUT_DATA	=	{8'h97, 8'h30};
	SET_OV7670 + 136 : 	LUT_DATA	=	{8'h98, 8'h20};
	SET_OV7670 + 137 : 	LUT_DATA	=	{8'h99, 8'h30};
	SET_OV7670 + 138 : 	LUT_DATA	=	{8'h9a, 8'h84};
	SET_OV7670 + 139 : 	LUT_DATA	=	{8'h9b, 8'h29};
	                                    
	                                    
	SET_OV7670 + 140 :	LUT_DATA	=	{8'h9c, 8'h03};
	SET_OV7670 + 141 :	LUT_DATA	= 	{8'h9d, 8'h4c};
	SET_OV7670 + 142 :	LUT_DATA	= 	{8'h9e, 8'h3f};
	SET_OV7670 + 143 :	LUT_DATA	= 	{8'h78, 8'h04};
	SET_OV7670 + 144 :	LUT_DATA	= 	{8'h79, 8'h01};
	SET_OV7670 + 145 :	LUT_DATA	= 	{8'hc8, 8'hf0};
	SET_OV7670 + 146 :	LUT_DATA	= 	{8'h79, 8'h0f};
	SET_OV7670 + 147 :	LUT_DATA	= 	{8'hc8, 8'h00};
	SET_OV7670 + 148 :	LUT_DATA	= 	{8'h79, 8'h10};
	SET_OV7670 + 149 :	LUT_DATA	= 	{8'hc8, 8'h7e};
	SET_OV7670 + 150 :	LUT_DATA	= 	{8'h79, 8'h0a};
	SET_OV7670 + 151 :	LUT_DATA	= 	{8'hc8, 8'h80};
	SET_OV7670 + 152 :	LUT_DATA	= 	{8'h79, 8'h0b};
	SET_OV7670 + 153 :	LUT_DATA	= 	{8'hc8, 8'h01};
	SET_OV7670 + 154 :	LUT_DATA	= 	{8'h79, 8'h0c};
	SET_OV7670 + 155 :	LUT_DATA	= 	{8'hc8, 8'h0f};
	SET_OV7670 + 156 :	LUT_DATA	= 	{8'h79, 8'h0d};
	SET_OV7670 + 157 :	LUT_DATA	= 	{8'hc8, 8'h20};
	SET_OV7670 + 158 :	LUT_DATA	= 	{8'h79, 8'h09};
	SET_OV7670 + 159 :	LUT_DATA	= 	{8'hc8, 8'h80};
	SET_OV7670 + 160 :	LUT_DATA	= 	{8'h79, 8'h02};
	SET_OV7670 + 161 :	LUT_DATA	= 	{8'hc8, 8'hc0}; 
	SET_OV7670 + 162 :	LUT_DATA	= 	{8'h79, 8'h03};
	                                    
	SET_OV7670 + 163 :	LUT_DATA	= 	{8'hc8, 8'h40};
	SET_OV7670 + 164 :	LUT_DATA	= 	{8'h79, 8'h05};
	SET_OV7670 + 165 :	LUT_DATA	=	{8'hc8, 8'h30};
	SET_OV7670 + 166 :	LUT_DATA	=   {8'h79, 8'h26};
	SET_OV7670 + 167 :	LUT_DATA	=   {8'h09, 8'h00};
	default		 :	LUT_DATA	= {8'h00,8'haf};  
	endcase                             
end                                     

endmodule
