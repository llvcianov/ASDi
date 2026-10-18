
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity switch is
  Port ( 
    x0,x1 : in std_logic_vector (1 downto 0);
    s_mux, s_demux : in std_logic;
    y0 : out std_logic_vector(1 downto 0);
    y1 : out std_logic_vector(1 downto 0)
  );
end switch;

architecture Structural of switch is
    component mux_21 
    Port ( 
        a0  : in std_logic_vector(1 downto 0);
        a1  : in std_logic_vector(1 downto 0);
        s   : in std_logic;
        y   : out std_logic_vector(1 downto 0));
    end component;
    
    component demux_12 
    Port ( 
        a : in std_logic_vector(1 downto 0);
        sel: in std_logic;
        b0, b1 : out std_logic_vector(1 downto 0));
    end component;
    
    signal temp : std_logic_vector(1 downto 0);
    
begin
    mux : mux_21 
    Port map( 
        a0  => x0,
        a1  => x1,
        s   => s_mux,
        y   => temp );

    demux :  demux_12 
    Port map( 
        a => temp,
        sel => s_demux,
        b0  => y0, 
        b1  =>  y1 ); 

end Structural;


