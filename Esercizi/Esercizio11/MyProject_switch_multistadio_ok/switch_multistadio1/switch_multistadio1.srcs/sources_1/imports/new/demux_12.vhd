
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity demux_12 is
  Port ( 
    a : in std_logic_vector(1 downto 0);
    sel: in std_logic;
    b0,b1 : out std_logic_vector(1 downto 0)
  );
end demux_12;

architecture dataflow of demux_12 is
begin
    b0 <= a when sel = '0' else "00";
    b1 <= a when sel = '1' else "00";
end dataflow;
