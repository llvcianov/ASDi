
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

entity PO_A is
    Generic (
        N : integer := 64; -- Numero di locazioni di memoria
        M : integer := 8   -- Larghezza in bit di ogni locazione
    );
    Port ( 
        clk, rst : in std_logic;
        en_count, read : in std_logic;
        dataOUT : out std_logic;
        dataIN : in std_logic;
        WR : in std_logic;
        TBE : inout std_logic;
        counter: out std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0)
    );
end PO_A;

architecture structural_A of PO_A is

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
    
    component ROM_N_M is
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
    
    component Rs232RefComp is
    Port ( 
		    TXD 	: out std_logic  	:= '1';
    	    RXD 	: in  std_logic;					
    	    CLK 	: in  std_logic;					--Master Clock
		    DBIN 	: in  std_logic_vector (7 downto 0);--Data Bus in
		    DBOUT : out std_logic_vector (7 downto 0);	--Data Bus out
		    RDA	: inout std_logic;						--Read Data Available(1 quando il dato è disponibile nel registro rdReg)
		    TBE	: inout std_logic 	:= '1';				--Transfer Bus Empty(1 quando il dato da inviare è stato caricato nello shift register)
		    RD		: in  std_logic;					--Read Strobe(se 1 significa "leggi" --> fa abbassare RDA)
		    WR		: in  std_logic;					--Write Strobe(se 1 significa "scrivi" --> fa abbassare TBE)
		    PE		: out std_logic;					--Parity Error Flag
		    FE		: out std_logic;					--Frame Error Flag
		    OE		: out std_logic;					--Overwrite Error Flag
		    RST		: in  std_logic	:= '0');			--Master Reset
    end component;
    
    signal Address_temp: std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0):= (others => '0');
    signal ROM_dataOUT_temp: std_logic_vector (M-1 downto 0);
    signal DBOUT_temp: std_logic_vector (7 downto 0);
    signal RDA_temp: std_logic;
    signal RD_temp: std_logic;
    signal Error_temp: std_logic_vector(2 downto 0);

    begin
    
    counter <= Address_temp;
    
    --UART
    Uart_A : Rs232RefComp
        Port map(
            TXD => dataOUT,
            RXD	=> dataIN,			
    	    CLK => clk,	
		    DBIN => ROM_dataOUT_temp,	
		    DBOUT => DBOUT_temp,
		    RDA	=> RDA_temp,
		    TBE	=> TBE, 
		    RD => RD_temp,
		    WR => WR, 
		    PE => Error_temp(0), 
		    FE => Error_temp(1),
		    OE => Error_temp(2),
		    RST => rst
        ); 

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
    
    ROM_A : ROM_N_M 
        Generic map(
            N => N,
            M => M
        )
        Port map(
            CLK => clk,
            Address => Address_temp,
            Read => read,
            dataOUT => ROM_dataOUT_temp
        );
    
end Structural_A;

