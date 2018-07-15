library verilog;
use verilog.vl_types.all;
entity clk_div_1 is
    generic(
        CLK_IN          : integer := 20000000;
        CLOCK_OUT       : integer := 1
    );
    port(
        clk             : in     vl_logic;
        clk_div         : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CLK_IN : constant is 1;
    attribute mti_svvh_generic_type of CLOCK_OUT : constant is 1;
end clk_div_1;
