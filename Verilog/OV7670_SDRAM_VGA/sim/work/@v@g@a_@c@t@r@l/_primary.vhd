library verilog;
use verilog.vl_types.all;
entity VGA_CTRL is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        r_fifo_usedw    : in     vl_logic_vector(10 downto 0);
        vga_r_req       : out    vl_logic;
        vga_r_clk       : out    vl_logic;
        vga_r_data_in   : in     vl_logic_vector(15 downto 0);
        vga_display_en  : in     vl_logic;
        vga_x_pos       : in     vl_logic_vector(9 downto 0);
        vga_y_pos       : in     vl_logic_vector(9 downto 0);
        vga_r_data_out  : out    vl_logic_vector(15 downto 0)
    );
end VGA_CTRL;
