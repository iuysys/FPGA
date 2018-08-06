library verilog;
use verilog.vl_types.all;
entity UART_Rxd_CTRL is
    port(
        SYS_CLK         : in     vl_logic;
        RST_N           : in     vl_logic;
        rx_data_in      : in     vl_logic_vector(7 downto 0);
        rx_busy         : in     vl_logic;
        w_req           : out    vl_logic;
        w_clk           : out    vl_logic;
        rx_data_out     : out    vl_logic_vector(15 downto 0)
    );
end UART_Rxd_CTRL;
