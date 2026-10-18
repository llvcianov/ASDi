----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.01.2025 17:13:43
-- Design Name: 
-- Module Name: ripple_carry - Structural
------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity ripple_carry is 
  Port ( 
    A: in std_logic_vector (7 downto 0);
    B: in std_logic_vector (7 downto 0);
    c_in : in std_logic;
    c_out : out std_logic;
    sum : out std_logic_vector (7 downto 0)
  );
end ripple_carry;

architecture Structural of ripple_carry is
    signal c_temp : std_logic_vector (7 downto 0);
    
    component full_adder is
        port (
            op1, op2 : in std_logic;
            cin : in std_logic;
            cout, s : out std_logic
        );
    end component;
begin
    FA0 : full_adder 
    port map (
        op1  => A(0),
        op2  => B(0),
        cin  => c_in,
        cout => c_temp(0),
        s    => sum(0)
    );
    FA1_6 :  FOR i in 1 to 6 GENERATE
     FA : full_adder
        port map (
        op1  => A(i),
        op2  => B(i),
        cin  => c_temp(i-1),
        cout => c_temp(i),
        s    => sum(i)
        );
    END GENERATE;
    
    FA7 : full_adder 
    port map (
        op1  => A(7),
        op2  => B(7),
        cin  => c_temp(6),
        cout => c_out,
        s    => sum(7)
    );

end Structural;
