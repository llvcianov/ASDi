----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.01.2025 11:29:55
-- Design Name: 
-- Module Name: sistema - structural
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

entity sistema is
    Port (
        address : in std_logic_vector (3 downto 0);
        y       : out std_logic_vector (3 downto 0)
    );
end sistema;

architecture structural of sistema is
    signal u : std_logic_vector (7 downto 0) :=(others => '0');
    
    component ROM is
        port (
            A   : in std_logic_vector (3 downto 0);
            data: out std_logic_vector (7 downto 0)
        );
    end component;
    
    component M is
        port (
            data_in : in std_logic_vector (7 downto 0);
            data_out: out std_logic_vector (3 downto 0)
        );
    end component;
   
    begin
    LEVEL1 : ROM 
        port map (
            A => address ,
            data => u 
        );
        
     LEVEL2 : M
     port map (
        data_in  => u ,
        data_out => y 
     );

end structural;
