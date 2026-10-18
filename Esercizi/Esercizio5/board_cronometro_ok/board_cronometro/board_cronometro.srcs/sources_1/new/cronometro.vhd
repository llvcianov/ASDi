

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Crono is
    Port (
        CLK:        in std_logic; --clock
        RST:        in std_logic; --reset
        Secload:       in std_logic; --segnale di set dei secondi
        Minload:       in std_logic; --segnale di set dei minuti        
        Hrload:       in std_logic; --segnale di set delle ore       
        SecToset:   in std_logic_vector(5 downto 0); --secondi da settare
        MinToset:   in std_logic_vector(5 downto 0); --minuti da settare
        HrToset:    in std_logic_vector(4 downto 0); --ore da settare
        SecOUT:     out std_logic_vector(5 downto 0); --uscita conteggio secondi
        MinOUT:     out std_logic_vector(5 downto 0); --uscita conteggio minuti     
        HrOUT:      out std_logic_vector(4 downto 0); --uscita conteggio ore         
        start : in std_logic        
         );
end Crono;

architecture structural of Crono is

    component clock_filter is
	 generic(
			CLKIN_freq : integer := 100000000; --clock board 100MHz
			CLKOUT_freq : integer := 500       --frequenza desiderata 
				);
    Port ( 
           clock_in : in  STD_LOGIC;
		   reset : in STD_LOGIC;
           clock_out : out  STD_LOGIC -- attenzione: non è un vero clock ma un impulso che sarà usato come enable
    ); 
    end component;

    component ContMod60 is 
        port(
            CLK:        in std_logic;
            RST:        in std_logic;
            count:      in std_logic;
            load:       in std_logic;
            dataToset:  in std_logic_vector(5 downto 0); 
            dataOUT:    out std_logic_vector(5 downto 0); 
            Umax:       out std_logic              
        );
    end component ContMod60;
    
    component ContMod24 is 
        port(
            CLK:        in std_logic;
            RST:        in std_logic;
            count:      in std_logic;
            load:       in std_logic;
            dataToset:  in std_logic_vector(4 downto 0); 
            dataOUT:    out std_logic_vector(4 downto 0)              
        );
    end component ContMod24;
    
    signal MinClock: std_logic;
    signal Hrclock: std_logic;
    signal Umaxsec: std_logic;
    signal Umaxmin: std_logic;
    signal SecClock: std_logic;
    signal abilita: std_logic :='0';
    
begin

    abilita <= SecClock AND start;

    Divisore_frequenza: clock_filter
        generic map(
            CLKIN_freq => 100000000,
            CLKOUT_freq => 1
--            CLKOUT_freq => 5000000
        )
        port map(
            clock_in => CLK,
            reset => RST,
            clock_out => SecClock
        );
                 
    Counter_sec: ContMod60
        port map(
            CLK => CLK,
            RST => RST,
            count => abilita,
            load => Secload,
            dataToset => SecToset,
            dataOUT => SecOUT,
            Umax => Umaxsec
        );
        
    Counter_min: ContMod60
        port map(
            CLK => CLK,
            RST => RST,
            count => MinClock,
            load => Minload,
            dataToset => MinToset,
            dataOUT => MinOUT,
            Umax => Umaxmin
        );
               
    Counter_Hr: ContMod24
        port map(
            CLK => CLK,
            RST => RST,
            count => HrClock,
            load => Hrload,
            dataToset => HrToset,
            dataOUT => HrOUT
        );
    
    --collego in parallelo
    MinClock <= Umaxsec and CLK;
    HrClock <= Umaxsec and Umaxmin and CLK;
        
end ;