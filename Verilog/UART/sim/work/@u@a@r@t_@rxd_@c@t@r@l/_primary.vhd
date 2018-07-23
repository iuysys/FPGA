library verilog;
use verilog.vl_types.all;
entity UART_Rxd_CTRL is
    port(
        SYS_CLK         : in     vl_logic;
        RST_N           : in     vl_logic;
        rx_busy         : in     vl_logic;
        w_req           : out    vl_logic;
        w_clk           : out    vl_logic
    );
end UART_Rxd_CTRL;
