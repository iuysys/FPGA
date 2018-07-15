library verilog;
use verilog.vl_types.all;
entity SMG_vlg_check_tst is
    port(
        DUAN            : in     vl_logic_vector(7 downto 0);
        SEL             : in     vl_logic_vector(2 downto 0);
        sampler_rx      : in     vl_logic
    );
end SMG_vlg_check_tst;
