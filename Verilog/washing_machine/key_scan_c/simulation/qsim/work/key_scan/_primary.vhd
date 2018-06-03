library verilog;
use verilog.vl_types.all;
entity key_scan is
    port(
        CLK             : in     vl_logic;
        RST_N           : in     vl_logic;
        key_s           : in     vl_logic;
        key_w           : in     vl_logic;
        key_p           : in     vl_logic;
        key_value       : out    vl_logic_vector(2 downto 0)
    );
end key_scan;
