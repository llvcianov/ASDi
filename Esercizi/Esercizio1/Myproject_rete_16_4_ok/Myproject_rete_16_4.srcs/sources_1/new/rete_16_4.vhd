----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.01.2025 16:15:26
-- Design Name: 
-- Module Name: rete_16_4 - Structural
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
use IEEE.NUMERIC_STD.ALL;

entity rete_16_4 is
    Port ( 
        ar  : in std_logic_vector (15 downto 0);
        sr  : in std_logic_vector (5 downto 0);
        yr  : out std_logic_vector (3 downto 0)
    );
end rete_16_4;

architecture Structural of rete_16_4 is

    component mux_16_1 is
        port (
            c : in std_logic_vector (15 downto 0);
            s : in std_logic_vector (3 downto 0);
            y : out std_logic
        );
    end  component;
    
    component demux_1_4 is
        port (
            a : in std_logic;
            s : in std_logic_vector (1 downto 0);
            y : out std_logic_vector (3 downto 0)
        );
    end component;
   
   signal u : std_logic;
   
    begin
    
        LEVEL1 : mux_16_1 
            port map (
                c => ar,
                s => sr (5 downto 2),
                y => u
            );
            
        LEVEL2 : demux_1_4 
            port map (
                a => u,
                s => sr (1 downto 0),
                y => yr
            );

end Structural;
