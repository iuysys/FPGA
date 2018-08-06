library verilog;
use verilog.vl_types.all;
entity UART_SDRAM_UART is
    port(
        SYS_CLK         : in     vl_logic;
        RST_N           : in     vl_logic;
        Rxd             : in     vl_logic;
        Txd             : out    vl_logic;
        SDRAM_CLK       : out    vl_logic;
        SDRAM_CKE       : out    vl_logic;
        SDRAM_CS        : out    vl_logic;
        SDRAM_RAS       : out    vl_logic;
        SDRAM_CAS       : out    vl_logic;
        SDRAM_WE        : out    vl_logic;
        SDRAM_BANK      : out    vl_logic_vector(1 downto 0);
        SDRAM_ADDR      : out    vl_logic_vector(11 downto 0);
        SDRAM_DQ        : inout  vl_logic_vector(15 downto 0);
        SDRAM_DQM       : out    vl_logic_vector(1 downto 0)
    );
end UART_SDRAM_UART;
