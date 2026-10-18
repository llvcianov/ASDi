

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;


entity NodoB is
    Generic (
        N : integer := 16; -- Numero di locazioni di memoria (modificabile)
        M : integer := 8   -- Larghezza in bit di ogni locazione
    );
    Port (
        CLK:        in std_logic;
        RST:        in std_logic;
        RXD :       in std_logic; 
        TXD :       out std_logic             

     );
end NodoB;

architecture structuralNodoB of NodoB is

    component PO_B is
        Generic (
            N : integer := 64; -- Numero di locazioni di memoria
            M : integer := 8   -- Larghezza in bit di ogni locazione
        );
        Port ( 
            clk, rst : in std_logic;
            en_count, write : in std_logic;
            RD: in std_logic;
            dataIN : in std_logic;
            dataOUT: out std_logic;
            RDA: inout std_logic; 
            Error: out std_logic_vector(2 downto 0)   
  --        counter: out std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0)
        );
    end component;    
    
    component UC_B is
        Generic (
            N : integer := 64 -- Numero di locazioni di memoria
        );
        Port( 
            clk, rst: in std_logic;
            RDA: in std_logic; 
            error : in std_logic_vector(2 downto 0);                  
            en_count, RD, write: out std_logic
        );
    end component;
    
    signal RD_temp : std_logic := '0';
    signal Write_temp : std_logic := '0';   
    signal en_count_temp : std_logic := '0'; 
    signal Error_temp : std_logic_vector(2 downto 0) := (others => '0');
    signal RDA_temp : std_logic := '0';

    
begin

    Parte_operativa: PO_B
        generic map (
            N => N, 
            M => M
        )
        port map(
            CLK => CLK,
            RST => RST,
            en_count => en_count_temp,
            write => Write_temp,
            RD => RD_temp,
            dataIN => RXD,
            dataOUT => TXD,
            RDA => RDA_temp,
            Error => Error_temp            
        );
        
    Parte_controllo: UC_B
        generic map (
            N => N
        )    
        port map(
            CLK => CLK,
            RST => RST,
            RDA => RDA_temp, 
            Error => Error_temp,
            en_count => en_count_temp,
            RD => RD_temp,
            write => Write_temp
        );        
    
end ;

