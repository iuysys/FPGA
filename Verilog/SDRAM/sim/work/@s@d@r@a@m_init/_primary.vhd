library verilog;
use verilog.vl_types.all;
entity SDRAM_init is
    port(
        S_CLK           : in     vl_logic;
        RST_N           : in     vl_logic;
        init_cmd        : out    vl_logic_vector(4 downto 0);
        init_addr       : out    vl_logic_vector(11 downto 0);
        flag_init       : out    vl_logic
    );
end SDRAM_init;
