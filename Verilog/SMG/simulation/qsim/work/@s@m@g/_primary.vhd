library verilog;
use verilog.vl_types.all;
entity SMG is
    port(
        CLK             : in     vl_logic;
        RST_N           : in     vl_logic;
        DATA            : in     vl_logic_vector(15 downto 0);
        SEL             : out    vl_logic_vector(2 downto 0);
        DUAN            : out    vl_logic_vector(7 downto 0)
    );
end SMG;
