library verilog;
use verilog.vl_types.all;
entity CLK_DIV_EVEN is
    port(
        CLK             : in     vl_logic;
        RST_N           : in     vl_logic;
        CLK_OUT         : out    vl_logic
    );
end CLK_DIV_EVEN;
