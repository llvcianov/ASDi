----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.02.2025 16:22:47
-- Design Name: 
-- Module Name: M_machine - 
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Machine is
  Port ( 
    data_in : in std_logic_vector (7 downto 0);
    data_out: out std_logic_vector (3 downto 0)
  );
end Machine;

architecture Behavioral of Machine is
begin
    convert_data : process (data_in)
    begin
        -- Controlla se il LSB è 0 (pari) o 1 (dispari)
        if (data_in(0) = '0') then
            data_out <= "0010";  -- Restituisce 2 se il numero è pari
        else
            data_out <= "0011";  -- Restituisce 3 se il numero è dispari
        end if;
    end process;
end Behavioral;
