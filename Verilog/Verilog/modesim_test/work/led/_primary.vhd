library verilog;
use verilog.vl_types.all;
entity led is
    port(
        clk             : in     vl_logic;
        led_out         : out    vl_logic_vector(3 downto 0)
    );
end led;
