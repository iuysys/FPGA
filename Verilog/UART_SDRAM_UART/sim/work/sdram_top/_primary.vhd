library verilog;
use verilog.vl_types.all;
entity sdram_top is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        sdram_wr_req    : in     vl_logic;
        sdram_rd_req    : in     vl_logic;
        sdram_wr_ack    : out    vl_logic;
        sdram_rd_ack    : out    vl_logic;
        sys_wraddr      : in     vl_logic_vector(21 downto 0);
        sys_rdaddr      : in     vl_logic_vector(21 downto 0);
        sys_data_in     : in     vl_logic_vector(15 downto 0);
        sys_data_out    : out    vl_logic_vector(15 downto 0);
        sdwr_byte       : in     vl_logic_vector(8 downto 0);
        sdrd_byte       : in     vl_logic_vector(8 downto 0);
        sdram_clk       : out    vl_logic;
        sdram_cke       : out    vl_logic;
        sdram_cs_n      : out    vl_logic;
        sdram_ras_n     : out    vl_logic;
        sdram_cas_n     : out    vl_logic;
        sdram_we_n      : out    vl_logic;
        sdram_ba        : out    vl_logic_vector(1 downto 0);
        sdram_addr      : out    vl_logic_vector(11 downto 0);
        sdram_data      : inout  vl_logic_vector(15 downto 0);
        sdram_init_done : out    vl_logic
    );
end sdram_top;
