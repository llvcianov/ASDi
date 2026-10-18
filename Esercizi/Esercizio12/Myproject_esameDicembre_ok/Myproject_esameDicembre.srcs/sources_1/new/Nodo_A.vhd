
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;


entity NodoA is
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
end NodoA;

architecture structuralNodoA of NodoA is

    component PO_A is
        Generic (
            N : integer := 64; -- Numero di locazioni di memoria
            M : integer := 8   -- Larghezza in bit di ogni locazione
        );
        Port ( 
            clk, rst : in std_logic;
            en_count, read : in std_logic;
            dataOUT : out std_logic_vector(M-1 downto 0);
            counter: out std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0)
        );
    end component;
    
    component UC_A is
        Generic (
            N : integer := 64 -- Numero di locazioni di memoria
        );
        Port( 
            clk, rst, start, ACK : in std_logic; 
            counter : in std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);                   
            en_count, read, REQ, stop: out std_logic
        );
    end component;
    
    signal Read_temp : std_logic := '0';
    signal counter_temp : std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0):= (others => '0');    
    signal en_count_temp : std_logic := '0';   

    
begin

    Parte_operativa: PO_A
        generic map (
            N => N, 
            M => M
        )
        port map(
            CLK => CLK,
            RST => RST,
            en_count => en_count_temp,
            Read => Read_temp,
            dataOUT => dataOUT,
            counter => counter_temp
        );
        
    Unita_controllo: UC_A
        generic map (
            N => N
        )    
        port map(
            CLK => CLK,
            RST => RST,
            Start => Start,
            ACK => ACK,
            counter => counter_temp,
            en_count => en_count_temp,
            Read => Read_temp,
            REQ => REQ,
            stop => stop
        );        
    
end ;

