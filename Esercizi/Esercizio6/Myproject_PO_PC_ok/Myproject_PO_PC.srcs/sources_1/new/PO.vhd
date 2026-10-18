

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;


entity PO is
    Generic (
        N : integer := 64 -- Numero di locazioni di memoria (modificabile)
    );
    Port ( 
        CLK:        in std_logic;
        RST:        in std_logic;
        Read:       in std_logic;
        Write:      in std_logic;
        en_count:   in std_logic;      
        counter:    out std_logic_vector (integer(ceil(log2(real(N))))-1 downto 0)
  );
end PO;

architecture structural of PO is
    
    component ROM_M is
        Generic (
            N : integer := 64 -- Numero di locazioni di memoria (modificabile)
        );
        Port (
            CLK     : in std_logic;
            Address : in std_logic_vector (integer(ceil(log2(real(N))))-1 downto 0);
            Read    : in std_logic;
            dataOUT : out std_logic_vector (3 downto 0) 
        );
    end component;
    
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
            N : integer := 64 -- Numero di locazioni di memoria (modificabile)
        );
        Port (
            CLK     : in std_logic;
            Address : in std_logic_vector (integer(ceil(log2(real(N))))-1 downto 0);
            Write   : in std_logic;
            dataIN  : in std_logic_vector (3 downto 0) 
        );
    end component;
    
    signal Address_temp: std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);
    signal data_temp: std_logic_vector(3 downto 0);
    
    begin
    
    counter <= Address_temp;
        
    Contatore: ContMod_N
        generic map (
            N => N)
        port map(
            CLK => CLK,  
            RST => RST,
            en_count => en_count,
            dataOUT => Address_temp);  
        
    ROM_sys: ROM_M
        generic map (
            N => N)    
        port map(
            CLK => CLK,
            Address => Address_temp,
            Read    => Read,
            dataOUT => data_temp);
        
    Memory: MEM
        generic map (
            N => N)    
        port map(
            CLK => CLK,
            Address => Address_temp,
            Write   => Write,
            dataIN  => data_temp);

end ;
