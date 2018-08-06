library verilog;
use verilog.vl_types.all;
entity Sdram_Control_2Port is
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
        REF_CLK         : in     vl_logic;
        OUT_CLK         : in     vl_logic;
        RESET_N         : in     vl_logic;
        WR_DATA         : in     vl_logic_vector(15 downto 0);
        WR              : in     vl_logic;
        WR_MIN_ADDR     : in     vl_logic_vector(21 downto 0);
        WR_MAX_ADDR     : in     vl_logic_vector(21 downto 0);
        WR_LENGTH       : in     vl_logic_vector(8 downto 0);
        WR_LOAD         : in     vl_logic;
        WR_CLK          : in     vl_logic;
        write_side_fifo_rusedw: out    vl_logic_vector(8 downto 0);
        RD_DATA         : out    vl_logic_vector(15 downto 0);
        RD              : in     vl_logic;
        RD_MIN_ADDR     : in     vl_logic_vector(21 downto 0);
        RD_MAX_ADDR     : in     vl_logic_vector(21 downto 0);
        RD_LENGTH       : in     vl_logic_vector(8 downto 0);
        RD_LOAD         : in     vl_logic;
        RD_CLK          : in     vl_logic;
        read_side_fifo_wusedw: out    vl_logic_vector(8 downto 0);
        SA              : out    vl_logic_vector(11 downto 0);
        BA              : out    vl_logic_vector(1 downto 0);
        CS_N            : out    vl_logic;
        CKE             : out    vl_logic;
        RAS_N           : out    vl_logic;
        CAS_N           : out    vl_logic;
        WE_N            : out    vl_logic;
        DQ              : inout  vl_logic_vector(15 downto 0);
        DQM             : out    vl_logic_vector(1 downto 0);
        SDR_CLK         : out    vl_logic;
        Sdram_Init_Done : out    vl_logic;
        Sdram_Read_Valid: in     vl_logic;
        Sdram_PingPong_EN: in     vl_logic
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
end Sdram_Control_2Port;
