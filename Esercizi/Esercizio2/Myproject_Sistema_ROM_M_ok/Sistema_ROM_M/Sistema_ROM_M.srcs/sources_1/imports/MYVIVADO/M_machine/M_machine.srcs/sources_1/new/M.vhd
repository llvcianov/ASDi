----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.01.2025 11:09:05
-- Design Name: 
-- Module Name: M - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description:
 -------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity M is
  Port ( 
    data_in : in std_logic_vector (7 downto 0);
    data_out: out std_logic_vector (3 downto 0)
  );
end M;

architecture Behavioral of M is
begin
--  se il LSB di data in è 0 inoltra i primi 4 bit più significativi
    convert_data : process (data_in)
    begin
    case data_in(0) is
        when '0' => data_out <= data_in(7) & data_in(6) & data_in(5) & data_in(4);      
        when '1' => data_out <= data_in(3) & data_in(2)& data_in(1) & data_in(0);   
        when others => data_out <= "----";
    end case;
    end process;

end Behavioral;
