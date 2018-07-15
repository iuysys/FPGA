`timescale 1 ns/ 1 ns  
module test_tb();  
reg clk;  
reg rst_n;                                               
wire ledout;                   
led i1 (  
    .clk(clk),  
    .ledout(ledout),  
    .rst_n(rst_n)  
);  
initial                                                  
begin                                                                                              
$display("Running testbench");        
clk=0;  
rst_n=0;  
#1000 rst_n=1;  
end                                                      
always #10 clk=~clk;                                                      
endmodule  