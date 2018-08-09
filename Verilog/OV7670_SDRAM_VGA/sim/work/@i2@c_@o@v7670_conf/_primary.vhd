library verilog;
use verilog.vl_types.all;
entity I2C_OV7670_conf is
    port(
        S_CLK           : in     vl_logic;
        RST_N           : in     vl_logic;
        start_init      : in     vl_logic;
        init_done       : out    vl_logic;
        SCCB_req        : out    vl_logic;
        SCCB_busy       : in     vl_logic;
        LUT_INDEX       : out    vl_logic_vector(7 downto 0)
    );
end I2C_OV7670_conf;
