library verilog;
use verilog.vl_types.all;
entity SMG_vlg_sample_tst is
    port(
        CLK             : in     vl_logic;
        DATA            : in     vl_logic_vector(15 downto 0);
        RST_N           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end SMG_vlg_sample_tst;
