library verilog;
use verilog.vl_types.all;
entity sdram_cmd is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        ctrl_cmd        : in     vl_logic_vector(1 downto 0);
        sys_addr        : in     vl_logic_vector(21 downto 0);
        cmd_ack         : out    vl_logic;
        dq_oe           : out    vl_logic;
        sdram_init_done : out    vl_logic;
        w_fifo_rreq     : out    vl_logic;
        r_fifo_wreq     : out    vl_logic;
        SDRAM_CKE       : out    vl_logic;
        SDRAM_CS        : out    vl_logic;
        SDRAM_RAS       : out    vl_logic;
        SDRAM_CAS       : out    vl_logic;
        SDRAM_WE        : out    vl_logic;
        SDRAM_BANK      : out    vl_logic_vector(1 downto 0);
        SDRAM_ADDR      : out    vl_logic_vector(11 downto 0)
    );
end sdram_cmd;
