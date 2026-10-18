

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
        CLK_A:      in std_logic;
        CLK_B:      in std_logic;
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
            Start:      in std_logic;
            ACK:        in std_logic;        
            stop:       out std_logic;
            REQ:        out std_logic;
            dataOUT :   out std_logic_vector(M-1 downto 0)
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
            REQ:        in std_logic;
            dataIN :    in std_logic_vector(M-1 downto 0);        
            ACK:        out std_logic        
        );
    end component;
    
    signal REQ_temp : std_logic := '0';
    signal ACK_temp : std_logic := '0';    
    signal data_temp : std_logic_vector(M-1 downto 0) := (others => '0');    
   

    
begin

    NODO_A: NodoA
        generic map (
            N => N, 
            M => M
        )
        port map(
            CLK => CLK_A,
            RST => RST,
            start => start,
            ACK => ACK_temp,
            stop => stop,
            REQ => REQ_temp,
            dataOUT => data_temp
        );
 
     NODO_B: NodoB
        generic map (
            N => N, 
            M => M
        )
        port map(
            CLK => CLK_B,
            RST => RST,
            REQ => REQ_temp,
            dataIN => data_temp,                        
            ACK => ACK_temp

        );       
        
end ;


