library verilog;
use verilog.vl_types.all;
entity I2C_Write is
    generic(
        IDLE            : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        START           : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1);
        S_ADDR          : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0);
        S_REG           : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1);
        S_DATA          : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0);
        STOP            : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1)
    );
    port(
        CLK             : in     vl_logic;
        RST_N           : in     vl_logic;
        data_in         : in     vl_logic_vector(23 downto 0);
        SCCB_req        : in     vl_logic;
        SCCB_SDA        : out    vl_logic;
        SCCB_SCL        : out    vl_logic;
        SCCB_busy       : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IDLE : constant is 1;
    attribute mti_svvh_generic_type of START : constant is 1;
    attribute mti_svvh_generic_type of S_ADDR : constant is 1;
    attribute mti_svvh_generic_type of S_REG : constant is 1;
    attribute mti_svvh_generic_type of S_DATA : constant is 1;
    attribute mti_svvh_generic_type of STOP : constant is 1;
end I2C_Write;
