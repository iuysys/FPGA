library verilog;
use verilog.vl_types.all;
entity key_mod is
    port(
        CLK             : in     vl_logic;
        RST_N           : in     vl_logic;
        key             : in     vl_logic;
        key_press       : out    vl_logic
    );
end key_mod;
