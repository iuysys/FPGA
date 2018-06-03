library verilog;
use verilog.vl_types.all;
entity key_scan_vlg_check_tst is
    port(
        key_value       : in     vl_logic_vector(2 downto 0);
        sampler_rx      : in     vl_logic
    );
end key_scan_vlg_check_tst;
