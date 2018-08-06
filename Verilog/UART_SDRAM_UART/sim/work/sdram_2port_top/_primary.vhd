library verilog;
use verilog.vl_types.all;
entity sdram_2port_top is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        sdram_clk_in    : in     vl_logic;
        w_fifo_wreq     : in     vl_logic;
        w_fifo_wclk     : in     vl_logic;
        sys_w_data      : in     vl_logic_vector(15 downto 0);
        w_fifo_wusedw   : out    vl_logic_vector(10 downto 0);
        r_fifo_rreq     : in     vl_logic;
        r_fifo_rclk     : in     vl_logic;
        sys_r_data      : out    vl_logic_vector(15 downto 0);
        r_fifo_rusedw   : out    vl_logic_vector(10 downto 0);
        SDRAM_CLK       : out    vl_logic;
        SDRAM_CKE       : out    vl_logic;
        SDRAM_CS        : out    vl_logic;
        SDRAM_RAS       : out    vl_logic;
        SDRAM_CAS       : out    vl_logic;
        SDRAM_WE        : out    vl_logic;
        SDRAM_BANK      : out    vl_logic_vector(1 downto 0);
        SDRAM_DQ        : inout  vl_logic_vector(15 downto 0);
        SDRAM_DQM       : out    vl_logic_vector(1 downto 0);
        SDRAM_ADDR      : out    vl_logic_vector(11 downto 0)
    );
end sdram_2port_top;
