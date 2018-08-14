library verilog;
use verilog.vl_types.all;
entity OV7670_top is
    port(
        S_CLK           : in     vl_logic;
        RST_N           : in     vl_logic;
        SCCB_SDA        : out    vl_logic;
        SCCB_SCL        : out    vl_logic;
        OV_data         : in     vl_logic_vector(7 downto 0);
        OV_vsync        : in     vl_logic;
        OV_wrst         : out    vl_logic;
        OV_rrst         : out    vl_logic;
        OV_oe           : out    vl_logic;
        OV_wen          : out    vl_logic;
        OV_rclk         : out    vl_logic;
        w_usedw         : in     vl_logic_vector(10 downto 0);
        w_req           : out    vl_logic;
        w_clk           : out    vl_logic;
        w_data          : out    vl_logic_vector(15 downto 0)
    );
end OV7670_top;
