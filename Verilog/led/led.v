module led(clk,rst_n,ledout);  
  
input clk ;  
input rst_n ;  
output reg ledout ;  
  
always @ ( posedge clk or negedge rst_n)  
begin  
    if(!rst_n)  
        begin  
            ledout<=0;  
        end  
    else  
    begin  
            ledout<=1;  
    end  
end  
endmodule 