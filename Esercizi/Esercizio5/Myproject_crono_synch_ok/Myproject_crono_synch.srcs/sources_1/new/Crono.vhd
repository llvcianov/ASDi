

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
        HrOUT:      out std_logic_vector(4 downto 0) --uscita conteggio ore         
         );
end Crono;

architecture structural of Crono is

--    component Divisore is
--        generic (
--            CLK_FREQ : integer := 10000000
--        );
--        port (
--            CLK : in std_logic;
--            RST : in std_logic;
--            CLK_1Hz : out std_logic
--        );
--    end component Divisore;

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
    
begin

--    Divisore_frequenza: Divisore
--        port map(
--            CLK => CLK,
--            RST => RST,
--            CLK_1Hz => SecClock
--        );
        
    Counter_sec: ContMod60
        port map(
            CLK => CLK,
            RST => RST,
            count => CLK,
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