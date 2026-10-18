----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.01.2025 15:29:06
-- Design Name: 
-- Module Name: cont_8 - structural
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
use IEEE.NUMERIC_STD.ALL;

entity cont_8 is
  Port (
    clk, rst : in std_logic;
    en_cont : in std_logic;
    counter : out std_logic_vector (3 downto 0)
   );
end cont_8;

architecture behavioral of cont_8 is
    signal temp_counter : std_logic_vector (3 downto 0) := "0000";
    
begin
    process (clk)
    begin
        if(rising_edge(clk)) then
            if rst='1' then
                temp_counter <= (others => '0');
                
            elsif en_cont='1' then
                temp_counter <= std_logic_vector(unsigned(temp_counter)+1);
            end if;
        end if;
    end process;

    counter <= temp_counter;
    
end behavioral;
