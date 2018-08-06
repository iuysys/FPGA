library verilog;
use verilog.vl_types.all;
entity SDRAM_CTRL is
    port(
        clk             : in     vl_logic;
        RST_N           : in     vl_logic;
        sys_data_in     : in     vl_logic_vector(15 downto 0);
        w_fifo_usedw    : in     vl_logic_vector(10 downto 0);
        w_fifo_rclk     : out    vl_logic;
        w_fifo_rreq     : out    vl_logic;
        sys_data_out    : out    vl_logic_vector(15 downto 0);
        r_fifo_usedw    : in     vl_logic_vector(10 downto 0);
        r_fifo_clk      : out    vl_logic;
        r_fifo_req      : out    vl_logic;
        sdram_clk       : out    vl_logic;
        sdram_cke       : out    vl_logic;
        sdram_cs_n      : out    vl_logic;
        sdram_ras_n     : out    vl_logic;
        sdram_cas_n     : out    vl_logic;
        sdram_we_n      : out    vl_logic;
        sdram_ba        : out    vl_logic_vector(1 downto 0);
        sdram_addr      : out    vl_logic_vector(11 downto 0);
        sdram_data      : inout  vl_logic_vector(15 downto 0)
    );
end SDRAM_CTRL;
