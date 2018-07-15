`timescale 10 ns/ 1 ns
module led_vlg_tst();
// constants                                           
// general purpose registers
reg eachvec;
// test vector input registers
reg clk;
// wires                                               
wire [3:0]  led_out;

// assign statements (if any)                          
led i1 (
// port map - connection between master ports and signals/registers   
	.clk(clk),
	.led_out(led_out)
);
initial                                                
begin                                                  
// code that executes only once                        
// insert code here --> begin    
	clk = 1'b0;                                                    
// --> end                                             
$display("Running testbench");                       
end                                                    
always                                                 
// optional sensitivity list                           
// @(event1 or event2 or .... eventn)                  
begin                                                  
// code executes for every event on sensitivity list   
// insert code here --> begin    
	#1 clk =~clk;
                                                       
@eachvec;                                              
// --> end                                             
end 
                                                   
endmodule