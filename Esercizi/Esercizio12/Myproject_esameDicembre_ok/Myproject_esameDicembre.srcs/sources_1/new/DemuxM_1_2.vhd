library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DemuxM_1_2 is
    generic (M : integer range 0 to 32 := 8);
	port( 
        dataIN : in std_logic_vector(M-1 downto 0);  -- Ingresso unico
        s : in std_logic;                           -- Selettore
        dataOUT0, dataOUT1 : out std_logic_vector(M-1 downto 0) -- Uscite
    );
end DemuxM_1_2;

architecture rtl of DemuxM_1_2 is
begin
    dataOUT0 <= dataIN when s = '0' else (others => '0');  -- Attivo su y0 se s=0
    dataOUT1 <= dataIN when s = '1' else (others => '0');  -- Attivo su y1 se s=1
end rtl;
