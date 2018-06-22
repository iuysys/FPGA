library verilog;
use verilog.vl_types.all;
entity SDRAM_AREF is
    port(
        S_CLK           : in     vl_logic;
        RST_N           : in     vl_logic;
        aref_req        : out    vl_logic;
        aref_en         : in     vl_logic;
        aref_ack        : out    vl_logic;
        aref_cmd        : out    vl_logic_vector(4 downto 0);
        aref_addr       : out    vl_logic_vector(11 downto 0);
        flag_init       : in     vl_logic
    );
end SDRAM_AREF;
