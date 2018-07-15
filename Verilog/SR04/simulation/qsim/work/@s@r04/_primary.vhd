library verilog;
use verilog.vl_types.all;
entity SR04 is
    port(
        CLK             : in     vl_logic;
        RST_N           : in     vl_logic;
        START           : in     vl_logic;
        ECHO            : in     vl_logic;
        TRIG            : out    vl_logic;
        distance        : out    vl_logic_vector(15 downto 0)
    );
end SR04;
