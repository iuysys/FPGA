library verilog;
use verilog.vl_types.all;
entity UART_Txd_CTRL is
    port(
        SYS_CLK         : in     vl_logic;
        RST_N           : in     vl_logic;
        data_in         : in     vl_logic_vector(15 downto 0);
        rd_fifo_usedw   : in     vl_logic_vector(8 downto 0);
        rd_clk          : out    vl_logic;
        rd_req          : out    vl_logic;
        data_out        : out    vl_logic_vector(7 downto 0);
        tx_req          : out    vl_logic;
        tx_busy         : in     vl_logic
    );
end UART_Txd_CTRL;