library verilog;
use verilog.vl_types.all;
entity SDRAM_CTRL is
    port(
        S_CLK           : in     vl_logic;
        RST_N           : in     vl_logic;
        image_rd_en     : in     vl_logic;
        fifo_rd_en      : out    vl_logic;
        addr            : out    vl_logic_vector(19 downto 0);
        bank            : out    vl_logic_vector(1 downto 0);
        write_ack       : in     vl_logic;
        write_en        : out    vl_logic;
        read_ack        : in     vl_logic;
        read_en         : out    vl_logic
    );
end SDRAM_CTRL;
