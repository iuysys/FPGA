library verilog;
use verilog.vl_types.all;
entity write_fifo is
    port(
        data            : in     vl_logic_vector(15 downto 0);
        rdclk           : in     vl_logic;
        rdreq           : in     vl_logic;
        wrclk           : in     vl_logic;
        wrreq           : in     vl_logic;
        q               : out    vl_logic_vector(15 downto 0);
        wrusedw         : out    vl_logic_vector(8 downto 0)
    );
end write_fifo;
