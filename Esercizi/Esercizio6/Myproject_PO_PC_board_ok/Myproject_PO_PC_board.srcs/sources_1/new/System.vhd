
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;


entity PO_PC_system is
    Generic (
        N : integer := 16 -- Numero di locazioni di memoria (modificabile)
    );
    Port (
        CLK:            in std_logic;
        RST:            in std_logic;
        Start_system:   in std_logic;
        Read_system:    in std_logic;
        led :           out STD_LOGIC_VECTOR(3 downto 0)
     );
end PO_PC_system;

architecture structural of PO_PC_system is

    component PO is
        Generic (
            N : integer := 64 -- Numero di locazioni di memoria (modificabile)
        );
        Port ( 
            CLK:        in std_logic;
            RST:        in std_logic;
            Read:       in std_logic;
            Write:      in std_logic;
            en_count:   in std_logic;      
            counter:    out std_logic_vector (integer(ceil(log2(real(N))))-1 downto 0);
            led :           out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;
    
    component PC is
        Generic (
            N : integer := 64 -- Numero di locazioni di memoria (modificabile)
        );
        Port (
            CLK:        in std_logic;
            RST:        in std_logic;
            Start:      in std_logic;
            counter:    in std_logic_vector (integer(ceil(log2(real(N))))-1 downto 0);
            Read:       in std_logic;
            Write:      out std_logic;
            en_count:   out std_logic      
        );
    end component;
    
    signal Read_temp : std_logic := '0';
    signal Write_temp : std_logic := '0';    
    signal en_count_temp : std_logic := '0';   
    signal counter_temp : std_logic_vector (integer(ceil(log2(real(N))))-1 downto 0);
    
begin

    Read_temp <= Read_system;

    Parte_operativa: PO
        generic map (
            N => N  
        )
        port map(
            CLK => CLK,
            RST => RST,
            Read => Read_temp,
            Write => Write_temp,
            en_count => en_count_temp,     
            counter => counter_temp,
            led => led
        );
        
    Parte_controllo: PC
        generic map (
            N => N  
        )
        port map(
            CLK => CLK,
            RST => RST,
            Start => Start_system,
            Read => Read_temp,
            Write => Write_temp,
            en_count => en_count_temp,     
            counter => counter_temp
        );        
    
end ;
