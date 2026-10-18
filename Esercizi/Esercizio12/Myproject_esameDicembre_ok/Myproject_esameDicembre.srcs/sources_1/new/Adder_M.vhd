library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Adder_M is
    Generic (
        M : integer := 8  -- Numero di bit (default: 8)
    );
    Port (
        A  : in  std_logic_vector(M-1 downto 0); 
        B : in  std_logic_vector(2*M-1 downto 0); 
        SUM    : out std_logic_vector(2*M-1 downto 0)  
    );
end Adder_M;

architecture Behavioral of Adder_M is
begin
    process(A, B)
    begin
        SUM <= std_logic_vector(unsigned(A) + unsigned(B));
    end process;
end Behavioral;

