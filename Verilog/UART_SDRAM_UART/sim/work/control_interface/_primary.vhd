library verilog;
use verilog.vl_types.all;
entity control_interface is
    generic(
        INIT_PER        : vl_logic_vector(0 to 15) := (Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0);
        REF_PER         : vl_logic_vector(0 to 15) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi0, Hi1, Hi0);
        SC_CL           : integer := 3;
        SC_RCD          : integer := 3;
        SC_PM           : integer := 1;
        SC_BL           : integer := 1;
        SDR_BL          : vl_notype;
        SDR_BT          : vl_logic := Hi0;
        SDR_CL          : vl_notype
    );
    port(
        CLK             : in     vl_logic;
        RESET_N         : in     vl_logic;
        CMD             : in     vl_logic_vector(1 downto 0);
        ADDR            : in     vl_logic_vector(21 downto 0);
        REF_ACK         : in     vl_logic;
        CM_ACK          : in     vl_logic;
        NOP             : out    vl_logic;
        READA           : out    vl_logic;
        WRITEA          : out    vl_logic;
        REFRESH         : out    vl_logic;
        PRECHARGE       : out    vl_logic;
        LOAD_MODE       : out    vl_logic;
        SADDR           : out    vl_logic_vector(21 downto 0);
        REF_REQ         : out    vl_logic;
        INIT_REQ        : out    vl_logic;
        CMD_ACK         : out    vl_logic;
        Sdram_Init_Done : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of INIT_PER : constant is 1;
    attribute mti_svvh_generic_type of REF_PER : constant is 1;
    attribute mti_svvh_generic_type of SC_CL : constant is 1;
    attribute mti_svvh_generic_type of SC_RCD : constant is 1;
    attribute mti_svvh_generic_type of SC_PM : constant is 1;
    attribute mti_svvh_generic_type of SC_BL : constant is 1;
    attribute mti_svvh_generic_type of SDR_BL : constant is 3;
    attribute mti_svvh_generic_type of SDR_BT : constant is 1;
    attribute mti_svvh_generic_type of SDR_CL : constant is 3;
end control_interface;
