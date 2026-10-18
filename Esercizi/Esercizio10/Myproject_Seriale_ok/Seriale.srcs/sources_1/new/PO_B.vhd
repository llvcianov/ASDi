
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
        en_count, write : in std_logic;
        RD: in std_logic;
        dataIN : in std_logic;
        dataOUT: out std_logic;
        RDA: inout std_logic; 
        Error: out std_logic_vector(2 downto 0)   
--        counter: out std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0)
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
    

    signal temp_Address: std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0):= (others => '0');   
    signal MEM_dataIN_temp: std_logic_vector (M-1 downto 0); 
    signal temp_MEM_out: std_logic_vector(M-1 downto 0):= (others => '0');
    signal MEM_read_temp: std_logic;
    signal DBIN_temp: std_logic_vector (7 downto 0);
    signal TBE_temp: std_logic;
    signal WR_temp: std_logic;

    begin

--    counter <= temp_Address;
    
    --UART
    Uart_B : Rs232RefComp
        Port map(
            TXD => dataOUT,
            RXD	=> dataIN,			
    	    CLK => clk,	
		    DBIN => DBIN_temp,	
		    DBOUT => MEM_dataIN_temp,
		    RDA	=> RDA,
		    TBE	=> TBE_temp,
		    RD => RD, 
		    WR => WR_temp,	     
		    PE => Error(0), 
		    FE => Error(1),
		    OE => Error(2),
		    RST => rst
        );

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
            Read => MEM_read_temp,
            dataIN => MEM_dataIN_temp,
            dataOUT => temp_MEM_out
        );
            
end Structural_B;

