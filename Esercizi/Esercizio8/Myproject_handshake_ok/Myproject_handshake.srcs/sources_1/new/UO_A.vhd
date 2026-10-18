
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

entity UO_A is
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
end UO_A;

architecture structural_A of UO_A is

    component ContMod_N is
        Generic (
            N : integer := 64 -- Modulo del contatore
        );
        Port (
            CLK:         in std_logic;  -- clock 
            RST:         in std_logic;  -- reset asincrono
            en_count:    in std_logic; --segnale di conteggio
            dataOUT:     out std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0) -- uscita di conteggio
        );
    end component;
    
    component ROM is
    Generic (
        N : integer := 64; -- Numero di locazioni di memoria
        M : integer := 8   -- Larghezza in bit di ogni locazione
    );
    Port (
        CLK     : in std_logic;
        Address : in std_logic_vector (integer(ceil(log2(real(N))))-1 downto 0);
        Read    : in std_logic;
        dataOUT : out std_logic_vector (M-1 downto 0) 
    );
    end component;
    
    signal Address_temp: std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0):= (others => '0');

    begin
    
    counter <= Address_temp;

    --COUNTER
    ContModN_A : ContMod_N 
         Generic map(
            N => N
         )
        Port map(
            clk => clk, 
            rst => rst,
            en_count => en_count,
            dataOUT => Address_temp 
        );
    
    ROM_A : ROM 
        Generic map(
            N => N,
            M => M
        )
        Port map(
            CLK => clk,
            Address => Address_temp,
            Read => read,
            dataOUT => dataOUT
        );
    
end Structural_A;

