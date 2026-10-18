

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity omega is
  Port ( 
    x0, x1, x2, x3 :        in std_logic_vector (1 downto 0);
    control_vector :        in std_logic_vector (7 downto 0);
    y0, y1, y2, y3 :        out std_logic_vector(1 downto 0)
  );
end omega;

architecture Structural of omega is
    component switch
        Port ( 
            x0,x1 : in std_logic_vector (1 downto 0);
            s_mux, s_demux : in std_logic;
            y0 : out std_logic_vector(1 downto 0);
            y1 : out std_logic_vector(1 downto 0)
        );
     end component;
     
     signal u0, u1, u2, u3 : std_logic_vector(1 downto 0);
begin
    sw_0 : switch
        Port map( 
            x0 => x0,
            x1 => x2,
            s_mux => control_vector(7), 
            s_demux => control_vector(6), 
            y0 => u0,
            y1 => u1
        );
        
    sw_1 : switch
        Port map( 
            x0 => x1,
            x1 => x3,
            s_mux => control_vector(5), 
            s_demux => control_vector(4), 
            y0 => u2,
            y1 => u3
        );
        
    sw_2 : switch
        Port map( 
            x0 => u0,
            x1 => u2,
            s_mux => control_vector(3), 
            s_demux => control_vector(2), 
            y0 => y0,
            y1 => y1
        );
        
    sw_3 : switch
        Port map( 
            x0 => u1,
            x1 => u3,
            s_mux => control_vector(1), 
            s_demux => control_vector(0), 
            y0 => y2,
            y1 => y3
        );
end Structural;


