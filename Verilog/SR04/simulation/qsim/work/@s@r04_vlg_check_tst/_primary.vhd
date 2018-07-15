library verilog;
use verilog.vl_types.all;
entity SR04_vlg_check_tst is
    port(
        TRIG            : in     vl_logic;
        distance        : in     vl_logic_vector(15 downto 0);
        sampler_rx      : in     vl_logic
    );
end SR04_vlg_check_tst;
