

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;


entity sistema is
    Generic (
        N : integer := 16; -- Numero di locazioni di memoria (modificabile)
        M : integer := 8   -- Larghezza in bit di ogni locazione
    );
    Port (
        CLK:        in std_logic;
        RST:        in std_logic;
        Start:      in std_logic;       
        stop:       out std_logic
     );
end sistema;

architecture structural_sistema of sistema is

    component NodoA is
        Generic (
            N : integer := 16; -- Numero di locazioni di memoria (modificabile)
            M : integer := 8   -- Larghezza in bit di ogni locazione
        );
        Port (
            CLK:        in std_logic;
            RST:        in std_logic;
            start:      in std_logic;
            RXD:        in std_logic;
            TXD :       out std_logic;                
            stop:       out std_logic
        );
    end component;
    
    component NodoB is
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
    end component;
    
    signal A_TXD_temp : std_logic := '0';
    signal A_RXD_temp : std_logic := '0';       
   
begin

    NODO_A: NodoA
        generic map (
            N => N, 
            M => M
        )
        port map(
            CLK => CLK,
            RST => RST,
            start => start,
            RXD => A_RXD_temp,
            TXD => A_TXD_temp,
            stop => stop
        );
 
     NODO_B: NodoB
        generic map (
            N => N, 
            M => M
        )
        port map(
            CLK => CLK,
            RST => RST,
            RXD => A_TXD_temp,
            TXD => A_RXD_temp                        
        );       
        
end ;


