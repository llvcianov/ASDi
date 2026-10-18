
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity UO is 
    Port (     
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        en_time : in STD_LOGIC;
        load_sec : in STD_LOGIC;
        load_min : in STD_LOGIC;
        load_hours : in STD_LOGIC;
        set_sec : in STD_LOGIC_VECTOR(5 downto 0);  
        set_min : in STD_LOGIC_VECTOR(5 downto 0);
        set_hours : in STD_LOGIC_VECTOR(4 downto 0);   
        anodes_out : out STD_LOGIC_VECTOR (7 downto 0);
        cathodes_out : out STD_LOGIC_VECTOR(7 downto 0));
end UO;

architecture structural of UO is
    component Crono
    Port (
        CLK:        in std_logic;
        RST:        in std_logic;      
        Secload:    in std_logic;
        Minload:    in std_logic;        
        Hrload:     in std_logic;            
        SecToset:   in std_logic_vector(5 downto 0);
        MinToset:   in std_logic_vector(5 downto 0);
        HrToset:    in std_logic_vector(4 downto 0);     
        SecOUT:     out std_logic_vector(5 downto 0);
        MinOUT:     out std_logic_vector(5 downto 0);
        HrOUT:      out std_logic_vector(4 downto 0);
        start:      in std_logic      
         );
    end component;
        
    component display_seven_segments 
    Generic( 
        CLKIN_freq : integer := 100000000; 
        CLKOUT_freq : integer := 500
    );
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           VALUE : in  STD_LOGIC_VECTOR (31 downto 0) :=(others => '0');
           ENABLE : in  STD_LOGIC_VECTOR (7 downto 0);
           DOTS : in  STD_LOGIC_VECTOR (7 downto 0);
           ANODES : out  STD_LOGIC_VECTOR (7 downto 0);
           CATHODES : out  STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component BCDConverter is
        port(
            x : in std_logic_vector(5 downto 0);
            y : out std_logic_vector(7 downto 0));
    end component;
    
    SIGNAL temp_second : STD_LOGIC_VECTOR(5 downto 0);
    SIGNAL temp_min : STD_LOGIC_VECTOR(5 downto 0);
    SIGNAL temp_hours : STD_LOGIC_VECTOR(5 downto 0);
    SIGNAL temp_hours_out : STD_LOGIC_VECTOR(4 downto 0);   
    SIGNAL orario_BCD : STD_LOGIC_VECTOR(31 downto 0);

    
begin

temp_hours <= "0" & temp_hours_out;

Cronometro: Crono
    Port map (
        CLK => CLK,
        RST => rst,       
        Secload => load_sec,
        Minload => load_min,     
        Hrload => load_hours,            
        SecToset => set_sec,
        MinToset => set_min,
        HrToset => set_hours,       
        SecOUT => temp_second,
        MinOUT => temp_min,    
        HrOUT => temp_hours_out,
        start => en_time      
    );

converter_sec: BCDConverter
    Port map (
        x => temp_second,
        y => orario_BCD(7 downto 0)
    );
    
converter_min: BCDConverter
    Port map (
        x => temp_min,
        y => orario_BCD(15 downto 8)
    );
    
converter_hours: BCDConverter
    Port map (
        x => temp_hours,
        y => orario_BCD(23 downto 16)
    );
     
Display: display_seven_segments 
    Generic map( 
        CLKIN_freq => 100000000, 
        CLKOUT_freq => 500
    )
    Port map( 
        CLK => CLK,
        RST => rst,
        VALUE => orario_BCD,
        ENABLE => "00111111",
        DOTS => "00010100", 
        ANODES => anodes_out,
        CATHODES => cathodes_out
    );
                 
end structural;

