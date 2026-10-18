
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity mux_41 is
    Port (
        b0,b1,b2,b3   : in std_logic_vector (1 downto 0);
        s0  : in std_logic;
        s1  : in std_logic;
        y0  : out std_logic_vector(1 downto 0)
    );
end mux_41;

architecture structural of mux_41 is
    signal u0 : std_logic_vector (1 downto 0);
    signal u1 : std_logic_vector (1 downto 0);
    
    component mux_21 is
        Port ( 
        a0  : in std_logic_vector(1 downto 0);
        a1  : in std_logic_vector(1 downto 0);
        s   : in std_logic;
        y   : out std_logic_vector(1 downto 0)
    );
    end component;
    
    begin
    
        mux_1 : mux_21
        Port map( 
            a0  => b0,
            a1  => b1,
            s   => s0,
            y   => u0
        );
        mux_2 : mux_21
        Port map( 
            a0  => b2,
            a1  => b3,
            s   => s0,
            y   => u1
        );
        
        mux_2_layer : mux_21 
        Port map (
            a0  =>  u0,
            a1  =>  u1,
            s   =>  s1,
            y   =>  y0
            );

end structural;