----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.01.2025 14:30:47
-- Design Name: 
-- Module Name: add_sub - Structural
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity add_sub is
  Port ( 
    x , y : in std_logic_vector(7 downto 0);
    en_sub : in std_logic;
    cout : out std_logic;
    z: out std_logic_vector (7 downto 0) 
  );
end add_sub;

architecture Structural of add_sub is
    component ripple_carry is
        port (
            A : in std_logic_vector (7 downto 0);
            B : in std_logic_vector (7 downto 0);
            c_in : in std_logic;
            c_out : out std_logic;
            sum : out std_logic_vector (7 downto 0)
            );
    end component;
    
    signal compl_y : std_logic_vector (7 downto 0);
    
begin
    complemento_y : FOR i in 0 to 7 GENERATE
        compl_y(i) <= y(i) xor en_sub;
     END GENERATE;
     
    RA : ripple_carry 
        port map(
            A => x, 
            B => compl_y, 
            c_in => en_sub , 
            c_out => cout, 
            sum => z
        );

end Structural;
