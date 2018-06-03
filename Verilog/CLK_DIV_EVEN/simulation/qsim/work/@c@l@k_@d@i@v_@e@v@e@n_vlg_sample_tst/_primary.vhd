library verilog;
use verilog.vl_types.all;
entity CLK_DIV_EVEN_vlg_sample_tst is
    port(
        CLK             : in     vl_logic;
        RST_N           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end CLK_DIV_EVEN_vlg_sample_tst;
