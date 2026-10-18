
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;
use ieee.std_logic_unsigned.all;

entity BCDConverter is
    port(
        x : in std_logic_vector(5 downto 0);
        y : out std_logic_vector(7 downto 0));
end BCDConverter;

architecture Behavioral of BCDConverter is
    begin
    
    process(x)
        variable tmp : integer;
        variable tmp2 : integer;
        begin
            tmp := conv_integer(x) mod 10;
            tmp2 := (conv_integer(x)/10) mod 10;
            y(3 downto 0) <= std_logic_vector(to_unsigned(tmp,4));
            y(7 downto 4) <= std_logic_vector(to_unsigned(tmp2,4));
    end process;
    
    
end Behavioral;