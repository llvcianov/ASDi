----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.02.2025 15:19:39
-- Design Name: 
-- Module Name: ROM_M - 
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
use IEEE.math_real.all;


entity ROM_M is
    Generic (
        N : integer := 64 -- Numero di locazioni di memoria (modificabile)
    );
    Port (
        CLK     : in std_logic;
        Address : in std_logic_vector (integer(ceil(log2(real(N))))-1 downto 0);
        Read    : in std_logic;
        dataOUT : out std_logic_vector (3 downto 0) 
    );
end ROM_M;

architecture structural of ROM_M is
    signal temp : std_logic_vector (7 downto 0) :=(others => '0');
    
    component ROM is
        Generic (
            N : integer := 64 -- Numero di locazioni di memoria (modificabile)
        );
        port (
            CLK     : in std_logic;
            Address : in std_logic_vector (integer(ceil(log2(real(N))))-1 downto 0);
            Read    : in std_logic;
            dataOUT : out std_logic_vector (7 downto 0) 
        );
    end component;
    
    component Machine is
        port (
            data_in : in std_logic_vector (7 downto 0);
            data_out: out std_logic_vector (3 downto 0)
        );
    end component;
   
    begin
    LEVEL1 : ROM 
        generic map (
            N => N  
        )    
        port map (
            CLK => CLK,
            Address => Address,
            Read => Read,
            dataOUT => temp 
        );
        
     LEVEL2 : Machine
     port map (
        data_in  => temp,
        data_out => dataOUT 
     );

end structural;