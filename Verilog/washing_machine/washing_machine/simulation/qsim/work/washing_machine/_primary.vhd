library verilog;
use verilog.vl_types.all;
entity washing_machine is
    port(
        led_start       : out    vl_logic;
        CLK             : in     vl_logic;
        RST_N           : in     vl_logic;
        fangshui_signal : in     vl_logic;
        key_s           : in     vl_logic;
        key_w           : in     vl_logic;
        key_p           : in     vl_logic;
        led_zhushui     : out    vl_logic;
        led_motor_f     : out    vl_logic;
        led_motor_o     : out    vl_logic;
        led_fangshui    : out    vl_logic;
        led_tuoshui     : out    vl_logic
    );
end washing_machine;
