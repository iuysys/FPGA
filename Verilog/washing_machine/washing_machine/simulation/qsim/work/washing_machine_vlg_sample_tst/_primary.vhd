library verilog;
use verilog.vl_types.all;
entity washing_machine_vlg_sample_tst is
    port(
        CLK             : in     vl_logic;
        fangshui_signal : in     vl_logic;
        key_p           : in     vl_logic;
        key_s           : in     vl_logic;
        key_w           : in     vl_logic;
        RST_N           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end washing_machine_vlg_sample_tst;
