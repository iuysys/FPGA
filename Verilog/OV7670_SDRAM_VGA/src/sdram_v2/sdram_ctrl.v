
`timescale 1ns / 1ps
//---------------------------------------------------
//-- 
module sdram_ctrl(
input 							clk			,
input							rst_n		,
	
input							sys_w_req	,
input							sys_r_req	,
input				[21:0]		sys_wr_addr	,


	
input 							sdram_init_done	,
input							cmd_ack		,
output		reg		[1:0]		ctrl_cmd	,
output		reg		[21:0]		sys_addr 	
);
//---------------------------------------------------
//-- 
//---------------------------------------------------
reg					[1:0]		state		;


//---------------------------------------------------
//-- 
//---------------------------------------------------



//---------------------------------------------------
//-- 处理系统的读写请求
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin
    	state <= 'b00 ;
    	sys_addr <= 'b0 ;
    	ctrl_cmd <= 'b0 ;
    end
    else  begin
    	case (state) 
    	    2'b00 : begin
    	        if (sys_w_req) begin
    	        	state <= 'b01 ;
    	        	ctrl_cmd <= 'b01 ;
    	        	sys_addr <= sys_wr_addr ;
    	        end
    	        else if(sys_r_req) begin
    	        	state <= 'b10 ;
    	        	ctrl_cmd <= 'b10 ;
    	        	sys_addr <= sys_wr_addr ;
    	        end
    	        else begin
    	        	state <= 'b00 ;
    	        	ctrl_cmd <= 'b00 ;
    	        end
    	        
    	    end
    	    2'b01 : begin
    	    	
    	    	if (cmd_ack) begin
    	    		state <= 'b00 ;
    	    		ctrl_cmd <= 'b00 ;
    	    	end
    	    	else begin
    	    		state <= 'b01 ;
    	    		ctrl_cmd <= 'b01 ;
    	    	end
    	        
    	    end
    	    2'b10 : begin
    	        
    	    	if (cmd_ack) begin
    	    		state <= 'b00 ;
    	    		ctrl_cmd <= 'b00 ;
    	    	end
    	    	else begin
    	    		state <= 'b10 ; 
    	    		ctrl_cmd <= 'b10 ;
    	    	end
    	    end
    	    default : begin
    	        state <= 'b00 ;
    	        ctrl_cmd <= 'b00 ;
    	    end
    	endcase
    end
end




endmodule