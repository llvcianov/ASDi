----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.02.2025 12:48:24
-- Design Name: 
-- Module Name: priority - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

entity priority is
  Port ( 
    s1, s2, s3, s4 : in std_logic;
    p : out std_logic_vector (1 downto 0)
  );
end priority;

architecture Behavioral of priority is

begin
    p <= "00" when s1='1' else 
        "01" when s2='1' else 
        "10" when s3='1' else 
        "11" when s4='1' else 
        "--";

end Behavioral;
