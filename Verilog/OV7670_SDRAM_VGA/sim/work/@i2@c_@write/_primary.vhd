library verilog;
use verilog.vl_types.all;
entity I2C_Write is
    port(
        CLK             : in     vl_logic;
        RST_N           : in     vl_logic;
        data_in         : in     vl_logic_vector(23 downto 0);
        SCCB_req        : in     vl_logic;
        SCCB_SDA        : out    vl_logic;
        SCCB_SCL        : out    vl_logic;
        SCCB_busy       : out    vl_logic
    );
end I2C_Write;
