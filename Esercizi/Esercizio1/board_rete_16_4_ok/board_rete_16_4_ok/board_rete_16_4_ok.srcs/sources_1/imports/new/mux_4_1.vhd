----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.01.2025 11:33:45
-- Design Name: 
-- Module Name: mux_4_1 - Structural
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

entity mux_4_1 is
    Port (
        b   : in std_logic_vector (3 downto 0);
        s0  : in std_logic;
        s1  : in std_logic;
        y0  : out std_logic
    );
end mux_4_1;

architecture structural of mux_4_1 is
    signal u : std_logic_vector (1 downto 0);
    
    component mux_2_1 is
        port (
            a0  : in std_logic;
            a1  : in std_logic;
            s   : in std_logic;
            y   : out std_logic
        );
    end component;
    
    begin
    
        mux_1_Layer : FOR i in 0 to 1 GENERATE m : mux_2_1
            port map (
                a0  =>  b(i*2),
                a1  =>  b(i*2 + 1),
                s   =>  s0,
                y   =>  u(i)
            );
        end GENERATE;
        
        mux_2_layer : mux_2_1 
            port map (
                a0  =>  u(0),
                a1  =>  u(1),
                s   =>  s1,
                y   =>  y0
            );

end structural;
