library verilog;
use verilog.vl_types.all;
entity washing_machine_vlg_check_tst is
    port(
        led_fangshui    : in     vl_logic;
        led_motor_f     : in     vl_logic;
        led_motor_o     : in     vl_logic;
        led_start       : in     vl_logic;
        led_tuoshui     : in     vl_logic;
        led_zhushui     : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end washing_machine_vlg_check_tst;
