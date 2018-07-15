library verilog;
use verilog.vl_types.all;
entity SR04_vlg_sample_tst is
    port(
        CLK             : in     vl_logic;
        ECHO            : in     vl_logic;
        RST_N           : in     vl_logic;
        START           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end SR04_vlg_sample_tst;
