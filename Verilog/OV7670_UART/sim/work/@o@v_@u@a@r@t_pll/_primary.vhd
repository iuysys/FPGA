library verilog;
use verilog.vl_types.all;
entity OV_UART_pll is
    port(
        inclk0          : in     vl_logic;
        c0              : out    vl_logic;
        c1              : out    vl_logic
    );
end OV_UART_pll;