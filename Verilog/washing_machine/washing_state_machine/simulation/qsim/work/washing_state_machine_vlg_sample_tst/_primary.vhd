library verilog;
use verilog.vl_types.all;
entity washing_state_machine_vlg_sample_tst is
    port(
        CLK             : in     vl_logic;
        RST_N           : in     vl_logic;
        fangshui_flag   : in     vl_logic;
        key             : in     vl_logic_vector(2 downto 0);
        sampler_tx      : out    vl_logic
    );
end washing_state_machine_vlg_sample_tst;
