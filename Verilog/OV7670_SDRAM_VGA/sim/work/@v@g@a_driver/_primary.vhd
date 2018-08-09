library verilog;
use verilog.vl_types.all;
entity VGA_driver is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        vga_rgb_in      : in     vl_logic_vector(15 downto 0);
        vga_display_en  : out    vl_logic;
        vga_x_pos       : out    vl_logic_vector(9 downto 0);
        vga_y_pos       : out    vl_logic_vector(9 downto 0);
        vga_blank       : out    vl_logic;
        vga_sync        : out    vl_logic;
        vga_clk         : out    vl_logic;
        vga_hsync       : out    vl_logic;
        vga_vsync       : out    vl_logic;
        vga_rgb_out     : out    vl_logic_vector(15 downto 0)
    );
end VGA_driver;
