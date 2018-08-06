library verilog;
use verilog.vl_types.all;
entity sdram_ctrl is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        sys_w_req       : in     vl_logic;
        sys_r_req       : in     vl_logic;
        sys_wr_addr     : in     vl_logic_vector(21 downto 0);
        sdram_init_done : in     vl_logic;
        cmd_ack         : in     vl_logic;
        ctrl_cmd        : out    vl_logic_vector(1 downto 0);
        sys_addr        : out    vl_logic_vector(21 downto 0)
    );
end sdram_ctrl;
