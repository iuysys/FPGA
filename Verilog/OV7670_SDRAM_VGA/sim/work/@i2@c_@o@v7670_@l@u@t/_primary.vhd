library verilog;
use verilog.vl_types.all;
entity I2C_OV7670_LUT is
    generic(
        SET_OV7670      : integer := 0
    );
    port(
        LUT_INDEX       : in     vl_logic_vector(7 downto 0);
        LUT_DATA        : out    vl_logic_vector(15 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of SET_OV7670 : constant is 1;
end I2C_OV7670_LUT;
