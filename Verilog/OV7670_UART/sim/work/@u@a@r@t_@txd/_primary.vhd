library verilog;
use verilog.vl_types.all;
entity UART_Txd is
    port(
        SYS_CLK         : in     vl_logic;
        RST_N           : in     vl_logic;
        data_in         : in     vl_logic_vector(7 downto 0);
        tx_req          : in     vl_logic;
        Txd             : out    vl_logic;
        tx_busy         : out    vl_logic
    );
end UART_Txd;
