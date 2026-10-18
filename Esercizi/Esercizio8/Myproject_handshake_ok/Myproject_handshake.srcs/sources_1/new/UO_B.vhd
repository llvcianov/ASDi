
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

entity UO_B is
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
end UO_B;

architecture structural_B of UO_B is

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
    
    component MEM is
        Generic (
            N : integer := 64;  -- Numero di locazioni di memoria (modificabile)
            M : integer := 8    -- Numero di bit per locazione di memoria (modificabile)
        );
        Port (
            CLK     : in std_logic;
            Address : in std_logic_vector (integer(ceil(log2(real(N))))-1 downto 0);
            Write   : in std_logic;
            Read    : in std_logic;
            dataIN  : in std_logic_vector (M-1 downto 0);
            dataOUT : out std_logic_vector (M-1 downto 0)
        );
    end component;
    
    component Adder is
        Generic (
            M : integer := 8  -- Numero di bit (default: 8)
        );
        Port (
            A, B   : in  std_logic_vector(M-1 downto 0); -- Operandi M-bit
            SUM    : out std_logic_vector(M-1 downto 0)  -- Somma M-bit
        );
    end component;
    
    component REG_M is 
        Generic (
            M : integer := 8
        );  -- Parametro per la larghezza del registro
        Port (
            dataIN  : in std_logic_vector(M-1 downto 0);
            clk, rst, load : in std_logic;
            dataOUT : out std_logic_vector(M-1 downto 0)
        );
    end component;
    
    signal temp_Address: std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0):= (others => '0');
    signal temp_MEM_out: std_logic_vector(M-1 downto 0):= (others => '0');
    signal temp_REG_A_out: std_logic_vector(M-1 downto 0):= (others => '0');
    signal temp_REG_B_out: std_logic_vector(M-1 downto 0):= (others => '0');
    signal temp_adder_out: std_logic_vector(M-1 downto 0):= (others => '0');

    begin

    counter <= temp_Address;

    --COUNTER
    ContModN_B : ContMod_N 
         Generic map(
            N => N
         )
        Port map(
            Clk => clk, 
            rst => rst,
            en_count => en_count,
            dataOUT => temp_Address
        );
    
    MEM_B : MEM 
        Generic map(
            N => N,
            M => M
        )
        Port map(
            CLK => clk,
            Address => temp_Address,
            Write => write,
            Read => read,
            dataIN => temp_adder_out,
            dataOUT => temp_MEM_out
        );
        
    M_adder : Adder 
        Generic map(
            M => M
        )
        Port map(
            A => temp_REG_A_out,
            B => temp_REG_B_out,
            SUM => temp_adder_out   
        );
        
    REG_A : REG_M  
        Generic map (
            M => M
        )
        Port map(
            dataIN => temp_MEM_out,
            clk => clk,
            rst => rst,
            load => loadA,
            dataOUT => temp_REG_A_out
        );
        
    REG_B : REG_M  
        Generic map (
            M => M
        )
        Port map(
            dataIN => dataIN,
            clk => clk,
            rst => rst,
            load => loadB,
            dataOUT => temp_REG_B_out
        );        
     
end Structural_B;

