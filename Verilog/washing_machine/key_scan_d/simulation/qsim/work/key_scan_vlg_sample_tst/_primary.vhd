library verilog;
use verilog.vl_types.all;
entity key_scan_vlg_sample_tst is
    port(
        CLK             : in     vl_logic;
        RST_N           : in     vl_logic;
        key_p           : in     vl_logic;
        key_s           : in     vl_logic;
        key_w           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end key_scan_vlg_sample_tst;
