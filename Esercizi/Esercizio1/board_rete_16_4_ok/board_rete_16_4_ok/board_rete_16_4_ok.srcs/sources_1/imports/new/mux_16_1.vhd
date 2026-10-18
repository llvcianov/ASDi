----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.01.2025 17:19:38
-- Design Name: 
-- Module Name: mux_16_1 - Structural
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

entity mux_16_1 is
    Port ( 
        c : in std_logic_vector (15 downto 0);
        s : in std_logic_vector (3 downto 0);
        y : out std_logic
    );
end mux_16_1;

architecture structural of mux_16_1 is
    signal u : std_logic_vector(3 downto 0);
    
    component mux_4_1 is
    port (
        b   : in std_logic_vector (3 downto 0);
        s0  : in std_logic;
        s1  : in std_logic;
        y0  : out std_logic );
    end component;

    begin
    
        mux_1_Layer : FOR i in 0 to 3 GENERATE m : mux_4_1
        port map (
            b   => c(i*4+3 downto i*4),
            s0  => s(0),
            s1  => s(1),
            y0  => u(i)
        );
        end GENERATE;
    
        mux_2_Layer : mux_4_1
        port map (
            b  => u,
            s0 => s(2),
            s1 => s(3),
            y0 => y
        );


end structural;
