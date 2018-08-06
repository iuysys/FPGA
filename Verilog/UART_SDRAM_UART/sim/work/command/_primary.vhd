library verilog;
use verilog.vl_types.all;
entity command is
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
        SADDR           : in     vl_logic_vector(21 downto 0);
        NOP             : in     vl_logic;
        READA           : in     vl_logic;
        WRITEA          : in     vl_logic;
        REFRESH         : in     vl_logic;
        PRECHARGE       : in     vl_logic;
        LOAD_MODE       : in     vl_logic;
        REF_REQ         : in     vl_logic;
        INIT_REQ        : in     vl_logic;
        PM_STOP         : in     vl_logic;
        PM_DONE         : in     vl_logic;
        REF_ACK         : out    vl_logic;
        CM_ACK          : out    vl_logic;
        OE              : out    vl_logic;
        SA              : out    vl_logic_vector(11 downto 0);
        BA              : out    vl_logic_vector(1 downto 0);
        CS_N            : out    vl_logic;
        CKE             : out    vl_logic;
        RAS_N           : out    vl_logic;
        CAS_N           : out    vl_logic;
        WE_N            : out    vl_logic
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
end command;
