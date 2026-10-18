library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity orario_decimale is
    Port (
        clk : in std_logic;
        secondi : in std_logic_vector(5 downto 0);
        minuti  : in std_logic_vector(5 downto 0);
        ore     : in std_logic_vector(4 downto 0);
        orario  : out std_logic_vector(31 downto 0)
    );
end orario_decimale;

architecture Behavioral of orario_decimale is
    signal secondi_u, secondi_d : integer;
    signal minuti_u, minuti_d   : integer;
    signal ore_u, ore_d         : integer;
    signal secondi_tot, minuti_tot, ore_tot : std_logic_vector(7 downto 0);

begin
    process(secondi, minuti, ore)
--    process(clk)
    begin
--        if(rising_edge(clk)) then
        -- Conversione in BCD
        secondi_u <= to_integer(unsigned(secondi)) mod 10;
        secondi_d <= to_integer(unsigned(secondi)) / 10;
        
        minuti_u  <= to_integer(unsigned(minuti)) mod 10;
        minuti_d  <= to_integer(unsigned(minuti)) / 10;
        
        ore_u     <= to_integer(unsigned(ore)) mod 10;
        ore_d     <= to_integer(unsigned(ore)) / 10;
        
        -- Formattazione BCD
        secondi_tot(3 downto 0) <= std_logic_vector(to_unsigned(secondi_u, 4));
        secondi_tot(7 downto 4) <= std_logic_vector(to_unsigned(secondi_d, 4));
        minuti_tot(3 downto 0)  <= std_logic_vector(to_unsigned(minuti_u, 4));
        minuti_tot(7 downto 4)  <= std_logic_vector(to_unsigned(minuti_d, 4));
        ore_tot(3 downto 0)     <= std_logic_vector(to_unsigned(ore_u, 4));
        ore_tot(7 downto 4)     <= std_logic_vector(to_unsigned(ore_d, 4));
        
        -- Assegnazione all'output, con gli ultimi 8 bit forzati a 0
        orario <= (others => '0'); -- Imposta tutto a 0 inizialmente
        orario(7 downto 0)   <= secondi_tot;
        orario(15 downto 8)  <= minuti_tot;
        orario(23 downto 16) <= ore_tot;
--        end if;
    end process;
    
end Behavioral;
