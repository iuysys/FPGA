library verilog;
use verilog.vl_types.all;
entity OV7670_UART is
    port(
        SYS_CLK         : in     vl_logic;
        RST_N           : in     vl_logic;
        OV_data         : in     vl_logic_vector(7 downto 0);
        OV_vsync        : in     vl_logic;
        OV_wrst         : out    vl_logic;
        OV_rrst         : out    vl_logic;
        OV_oe           : out    vl_logic;
        OV_wen          : out    vl_logic;
        OV_rclk         : out    vl_logic;
        SCCB_SDA        : out    vl_logic;
        SCCB_SCL        : out    vl_logic;
        Txd             : out    vl_logic;
        c1              : out    vl_logic
    );
end OV7670_UART;
