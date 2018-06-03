library verilog;
use verilog.vl_types.all;
entity key_mod_vlg_check_tst is
    port(
        key_press       : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end key_mod_vlg_check_tst;
