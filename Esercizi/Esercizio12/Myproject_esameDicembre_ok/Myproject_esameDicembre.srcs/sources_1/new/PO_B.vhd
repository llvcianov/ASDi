
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

entity PO_B is
    Generic (
        N : integer := 64; -- Numero di locazioni di memoria
        M : integer := 8   -- Larghezza in bit di ogni locazione
    );
    Port ( 
        clk, rst : in std_logic;
        en_count, loadA, loadB, loadC, Sel_R : in std_logic;
        dataIN : in std_logic_vector(M-1 downto 0);    
        counter: out std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0)
    );
end PO_B;

architecture structural_B of PO_B is

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
    
    component Adder_M is
        Generic (
            M : integer := 8  -- Numero di bit (default: 8)
        );
        Port (
            A  : in  std_logic_vector(M-1 downto 0);
            B   : in  std_logic_vector(2*M-1 downto 0);
            SUM    : out std_logic_vector(2*M-1 downto 0)  -- Somma M-bit
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
    
    component DemuxM_1_2 is
        generic (M : integer range 0 to 32 := 8);
	    port( 
            dataIN : in std_logic_vector(M-1 downto 0);  -- Ingresso unico
            s : in std_logic;                           -- Selettore
            dataOUT0, dataOUT1 : out std_logic_vector(M-1 downto 0) -- Uscite
        );
    end component;
    
    signal temp_REG_C_in: std_logic_vector(2*M-1 downto 0):= (others => '0');
    signal temp_REG_B_in: std_logic_vector(2*M-1 downto 0):= (others => '0');
    signal temp_MEM_out: std_logic_vector(M-1 downto 0):= (others => '0');
    signal temp_REG_A_out: std_logic_vector(M-1 downto 0):= (others => '0');
    signal temp_REG_B_out: std_logic_vector(2*M-1 downto 0):= (others => '0');
    signal temp_REG_C_out: std_logic_vector(2*M-1 downto 0):= (others => '0');
    signal temp_adder_out: std_logic_vector(2*M-1 downto 0):= (others => '0');

    begin

    ContModN_B : ContMod_N 
         Generic map(
            N => N
         )
        Port map(
            clk => clk, 
            rst => rst,
            en_count => en_count,
            dataOUT => counter
        );
        
    Adder_B : Adder_M 
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
            dataIN => dataIN,
            clk => clk,
            rst => rst,
            load => loadA,
            dataOUT => temp_REG_A_out
        );
        
    REG_B : REG_M  
        Generic map (
            M => 2*M
        )
        Port map(
            dataIN => temp_REG_B_in,
            clk => clk,
            rst => rst,
            load => loadB,
            dataOUT => temp_REG_B_out
        ); 
        
   REG_C : REG_M  
        Generic map (
            M => 2*M
        )
        Port map(
            dataIN => temp_REG_C_in,
            clk => clk,
            rst => rst,
            load => loadC,
            dataOUT => temp_REG_C_out
        );
        
    Demux_B : DemuxM_1_2
        Generic map (
            M => 2*M
        )
	    Port Map( 
            dataIN => temp_adder_out,
            s => Sel_R,
            dataOUT0 => temp_REG_B_in, 
            dataOUT1 => temp_REG_C_in 
        );
        
           
     
end Structural_B;

