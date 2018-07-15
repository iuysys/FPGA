library verilog;
use verilog.vl_types.all;
entity SDRAM_READ is
    port(
        S_CLK           : in     vl_logic;
        RST_N           : in     vl_logic;
        read_ack        : out    vl_logic;
        read_en         : in     vl_logic;
        fifo_wd_req     : out    vl_logic;
        sdram_addr      : in     vl_logic_vector(19 downto 0);
        read_addr       : out    vl_logic_vector(11 downto 0);
        read_cmd        : out    vl_logic_vector(4 downto 0)
    );
end SDRAM_READ;
