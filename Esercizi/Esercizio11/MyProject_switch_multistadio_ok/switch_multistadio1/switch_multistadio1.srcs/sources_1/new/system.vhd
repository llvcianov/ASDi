
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity system is
  Port ( 
    A0, A1, A2, A3 : in std_logic_vector(5 downto 0);
    enable0, enable1, enable2, enable3 : in std_logic;
    B0, B1, B2, B3 : out std_logic_vector(1 downto 0)
  );
end system;

architecture Structural of system is
    component control_unit
        Port ( 
            A0, A1 , A2, A3 : in std_logic_vector(5 downto 0);
            enable0, enable1, enable2, enable3 : in std_logic;
            B0, B1, B2, B3 : out std_logic_vector(1 downto 0);
            control_vector : out std_logic_vector (7 downto 0)    
        );
    end component;
    
    component omega
        Port ( 
            x0, x1, x2, x3 :        in std_logic_vector (1 downto 0);
            control_vector :        in std_logic_vector (7 downto 0);
            y0, y1, y2, y3 :        out std_logic_vector(1 downto 0)
        );
    end component;
    
    signal temp1, temp2, temp3, temp4 : std_logic_vector(1 downto 0);
    signal source, destination : std_logic_vector(1 downto 0);
    signal temp_control_vector : std_logic_vector (7 downto 0);
    
begin
    UC : control_unit
        Port map( 
            A0 => A0, 
            A1 => A1, 
            A2 => A2, 
            A3 => A3 ,
            enable0 => enable0, 
            enable1 => enable1, 
            enable2 => enable2, 
            enable3 => enable3,
            B0 => temp1, 
            B1 => temp2, 
            B2 => temp3, 
            B3 => temp4,
            control_vector => temp_control_vector         
        );

    UO : omega
        Port map( 
            x0 => temp1, 
            x1 => temp2, 
            x2 => temp3, 
            x3 => temp4,
            control_vector => temp_control_vector,
            y0 => B0, 
            y1 => B1, 
            y2 => B2, 
            y3 => B3
        );

end Structural;
