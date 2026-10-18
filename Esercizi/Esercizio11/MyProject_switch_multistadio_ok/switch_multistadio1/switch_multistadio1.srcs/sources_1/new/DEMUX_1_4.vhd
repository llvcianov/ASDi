----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.02.2025 15:17:17
-- Design Name: 
-- Module Name: DEMUX_1_4 - Behavioral
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

entity demux_1_4 is
    Port (
        a : in std_logic_vector(1 downto 0);
        s : in std_logic_vector (1 downto 0);
        y0, y1, y2, y3 : out std_logic_vector (1 downto 0)
   );
end demux_1_4;

architecture Behavioral of demux_1_4 is

begin
    process (s, a)
    begin
        case s is 
            when "00" =>
                y0 <= a;
            when "01" =>
                y1 <= a;
            when "10" =>
                y2 <= a;
            when "11" =>
                y3 <= a;
            when others =>
                y0 <= a;
            end case; 
end process;
end Behavioral;
