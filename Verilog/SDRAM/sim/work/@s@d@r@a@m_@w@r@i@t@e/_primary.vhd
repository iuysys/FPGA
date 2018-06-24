library verilog;
use verilog.vl_types.all;
entity SDRAM_WRITE is
    port(
        S_CLK           : in     vl_logic;
        RST_N           : in     vl_logic;
        write_ack       : out    vl_logic;
        write_en        : in     vl_logic;
        aref_req        : in     vl_logic;
        fifo_rd_req     : out    vl_logic;
        sdram_addr      : in     vl_logic_vector(19 downto 0);
        write_addr      : out    vl_logic_vector(11 downto 0);
        write_cmd       : out    vl_logic_vector(4 downto 0)
    );
end SDRAM_WRITE;
