library verilog;
use verilog.vl_types.all;
entity FIFO_T is
    port(
        CLK             : in     vl_logic;
        RST_N           : in     vl_logic;
        WRREQ           : in     vl_logic;
        RDREQ           : in     vl_logic;
        DATA_OUT        : out    vl_logic_vector(7 downto 0);
        EMPTY           : out    vl_logic;
        FULL            : out    vl_logic
    );
end FIFO_T;
