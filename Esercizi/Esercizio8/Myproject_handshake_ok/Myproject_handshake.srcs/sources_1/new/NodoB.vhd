

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
        REQ:        in std_logic;
        dataIN :    in std_logic_vector(M-1 downto 0);        
        ACK:        out std_logic        

     );
end NodoB;

architecture structuralNodoB of NodoB is

    component UO_B is
        Generic (
            N : integer := 64; -- Numero di locazioni di memoria
            M : integer := 8   -- Larghezza in bit di ogni locazione
        );
        Port ( 
            clk, rst : in std_logic;
            en_count, read, write, loadA, loadB : in std_logic;
            dataIN : in std_logic_vector(M-1 downto 0);    
            counter: out std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0)
        );
    end component;
    
    component UC_B is
        Generic (
            N : integer := 64 -- Numero di locazioni di memoria
        );
        Port( 
            clk, rst, REQ : in std_logic; 
            counter : in std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);                 
            en_count, read, write, loadA, loadB, ACK: out std_logic
        );
    end component;
    
    signal Read_temp : std_logic := '0';
    signal Write_temp : std_logic := '0';
    signal counter_temp : std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0):= (others => '0');    
    signal en_count_temp : std_logic := '0'; 
    signal loadA_temp : std_logic := '0';
    signal loadB_temp : std_logic := '0';

    
begin

    Parte_operativa: UO_B
        generic map (
            N => N, 
            M => M
        )
        port map(
            CLK => CLK,
            RST => RST,
            en_count => en_count_temp,
            Read => Read_temp,
            Write => Write_temp,
            loadA => loadA_temp,
            loadB => loadB_temp,
            dataIN => dataIN,
            counter => counter_temp            
        );
        
    Parte_controllo: UC_B
        generic map (
            N => N
        )    
        port map(
            CLK => CLK,
            RST => RST,
            REQ => REQ, 
            counter => counter_temp,
            en_count => en_count_temp,
            Read => Read_temp,
            Write => Write_temp,
            loadA => loadA_temp,
            loadB => loadB_temp,  
            ACK => ACK
        );        
    
end ;

