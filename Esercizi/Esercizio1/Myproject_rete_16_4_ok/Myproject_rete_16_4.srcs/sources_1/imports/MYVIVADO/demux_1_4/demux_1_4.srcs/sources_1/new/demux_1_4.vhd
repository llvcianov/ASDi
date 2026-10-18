----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.01.2025 15:48:17
-- Design Name: 
-- Module Name: demux_1_4 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity demux_1_4 is
    Port (
        a : in std_logic;
        s : in std_logic_vector (1 downto 0);
        y : out std_logic_vector (3 downto 0)
   );
end demux_1_4;

architecture Behavioral of demux_1_4 is
    begin
        y(0)<= a AND (NOT s(0)) AND (NOT s(1));
        y(1)<= a AND  s(0) AND (NOT s(1));
        y(2)<= a AND (NOT s(0)) AND s(1);
        y(3)<= a AND  s(0) AND s(1);                  
end Behavioral;
