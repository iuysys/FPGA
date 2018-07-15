library verilog;
use verilog.vl_types.all;
entity SDRAM_TOP is
    port(
        S_CLK           : in     vl_logic;
        RST_N           : in     vl_logic;
        SDRAM_CLK       : out    vl_logic;
        SDRAM_CKE       : out    vl_logic;
        SDRAM_CS        : out    vl_logic;
        SDRAM_RAS       : out    vl_logic;
        SDRAM_CAS       : out    vl_logic;
        SDRAM_WE        : out    vl_logic;
        SDRAM_BANK      : out    vl_logic_vector(1 downto 0);
        \SDRAM_ADDR\    : out    vl_logic_vector(11 downto 0);
        SDRAM_DQ        : inout  vl_logic_vector(15 downto 0);
        SDRAM_DQM       : out    vl_logic_vector(1 downto 0);
        sys_write_data  : in     vl_logic_vector(15 downto 0);
        sys_bank        : in     vl_logic_vector(1 downto 0);
        sdram_addr      : in     vl_logic_vector(19 downto 0);
        fifo_rd_req     : out    vl_logic;
        fifo_rd_clk     : out    vl_logic;
        fifo_wd_req     : out    vl_logic;
        fifo_wd_clk     : out    vl_logic;
        sys_read_data   : out    vl_logic_vector(15 downto 0);
        write_req       : in     vl_logic;
        read_req        : in     vl_logic;
        write_ack       : out    vl_logic;
        read_ack        : out    vl_logic
    );
end SDRAM_TOP;
