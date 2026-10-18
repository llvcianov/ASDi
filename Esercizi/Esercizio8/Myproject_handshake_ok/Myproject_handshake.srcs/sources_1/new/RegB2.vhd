library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Registro parallelo-parallelo generico su M bit
entity REG_M is 
    Generic (M : integer := 8);  -- Parametro per la larghezza del registro
    Port (
        dataIN  : in std_logic_vector(M-1 downto 0);
        clk, rst, load : in std_logic;
        dataOUT : out std_logic_vector(M-1 downto 0)
    );
end REG_M;

architecture behavioural of REG_M is
    signal temp_data: std_logic_vector(M-1 downto 0);
    
begin
    R_PP: process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                temp_data <= (others => '0');
            elsif load = '1' then
                temp_data <= dataIN;
            end if;
        end if;
    end process;
    
    dataOUT <= temp_data;
end behavioural;