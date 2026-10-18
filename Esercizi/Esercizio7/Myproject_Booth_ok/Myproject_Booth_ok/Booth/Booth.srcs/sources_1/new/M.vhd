----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.01.2025 18:02:19
-- Design Name: 
-- Module Name: M - Behavioral
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
entity M is
  Port ( 
     clk, rst, load : in std_logic;
     data_in : in std_logic_vector(7 downto 0);
     data_out : out std_logic_vector(7 downto 0)
  );
end M;

architecture Behavioral of M is

    signal temp : std_logic_vector (7 downto 0);
    
begin

    process (clk)
    begin
        if (rising_edge(clk)) then
            if rst='1' then 
                temp <= (others => '0');
            elsif load='1' then
                temp <= data_in;
            end if;
        end if;
    end process;
    
    data_out <= temp;
        
end Behavioral;






