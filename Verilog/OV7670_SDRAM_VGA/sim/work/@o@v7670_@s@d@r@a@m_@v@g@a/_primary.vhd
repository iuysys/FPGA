library verilog;
use verilog.vl_types.all;
entity OV7670_SDRAM_VGA is
    port(
        sys_clk         : in     vl_logic;
        rst_n           : in     vl_logic;
        OV_data         : in     vl_logic_vector(7 downto 0);
        OV_vsync        : in     vl_logic;
        OV_wrst         : out    vl_logic;
        OV_rrst         : out    vl_logic;
        OV_oe           : out    vl_logic;
        OV_wen          : out    vl_logic;
        OV_rclk         : out    vl_logic;
        SCCB_SDA        : out    vl_logic;
        SCCB_SCL        : out    vl_logic;
        vga_blank       : out    vl_logic;
        vga_sync        : out    vl_logic;
        vga_clk         : out    vl_logic;
        vga_hsync       : out    vl_logic;
        vga_vsync       : out    vl_logic;
        vga_rgb_out     : out    vl_logic_vector(15 downto 0);
        SDRAM_CLK       : out    vl_logic;
        SDRAM_CKE       : out    vl_logic;
        SDRAM_CS        : out    vl_logic;
        SDRAM_RAS       : out    vl_logic;
        SDRAM_CAS       : out    vl_logic;
        SDRAM_WE        : out    vl_logic;
        SDRAM_BANK      : out    vl_logic_vector(1 downto 0);
        SDRAM_DQ        : inout  vl_logic_vector(15 downto 0);
        SDRAM_DQM       : out    vl_logic_vector(1 downto 0);
        SDRAM_ADDR      : out    vl_logic_vector(11 downto 0)
    );
end OV7670_SDRAM_VGA;
