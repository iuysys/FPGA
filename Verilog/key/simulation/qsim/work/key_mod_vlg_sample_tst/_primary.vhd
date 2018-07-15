library verilog;
use verilog.vl_types.all;
entity key_mod_vlg_sample_tst is
    port(
        CLK             : in     vl_logic;
        RST_N           : in     vl_logic;
        key             : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end key_mod_vlg_sample_tst;
