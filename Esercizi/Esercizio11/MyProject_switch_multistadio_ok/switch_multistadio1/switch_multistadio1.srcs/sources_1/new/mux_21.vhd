
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity mux_21 is
    Port ( 
        a0  : in std_logic_vector(1 downto 0);
        a1  : in std_logic_vector(1 downto 0);
        s   : in std_logic;
        y   : out std_logic_vector(1 downto 0)
    );
end mux_21;

architecture dataflow of mux_21 is
    begin
        y <= a0 WHEN s = '0' ELSE
        a1 WHEN s = '1' ELSE
        "--";
end dataflow;
