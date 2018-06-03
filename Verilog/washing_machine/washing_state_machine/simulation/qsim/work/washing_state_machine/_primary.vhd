library verilog;
use verilog.vl_types.all;
entity washing_state_machine is
    port(
        CLK             : in     vl_logic;
        RST_N           : in     vl_logic;
        key             : in     vl_logic_vector(2 downto 0);
        fangshui_flag   : in     vl_logic;
        led_start       : out    vl_logic;
        led_zhushui     : out    vl_logic;
        led_motor_f     : out    vl_logic;
        led_motor_o     : out    vl_logic;
        led_fangshui    : out    vl_logic;
        led_tuoshui     : out    vl_logic
    );
end washing_state_machine;
