library verilog;
use verilog.vl_types.all;
entity UART_Rxd is
    port(
        SYS_CLK         : in     vl_logic;
        RST_N           : in     vl_logic;
        Rxd             : in     vl_logic;
        rx_data         : out    vl_logic_vector(7 downto 0);
        rx_busy         : out    vl_logic
    );
end UART_Rxd;
