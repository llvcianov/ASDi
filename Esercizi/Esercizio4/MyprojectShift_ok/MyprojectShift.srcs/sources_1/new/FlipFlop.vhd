----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.01.2025 16:34:02
-- Design Name: 
-- Module Name: FlipFlop 
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FlipFlop is
    Port (
        CLK     : in std_logic;
        RST     : in std_logic; 
        D       : in std_logic;
        Q       : out std_logic   
   );
end FlipFlop;

architecture behavioural of FlipFlop is
    begin
        FlipFlop: process (CLK, RST)
        begin
            if (RST = '1') then
                Q <= '0';
            elsif (rising_edge(CLK)) then
                Q <= D; 
            end if;
        end process;
    end behavioural;
    
    
    
