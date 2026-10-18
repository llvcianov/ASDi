library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Adder is
    Generic (
        M : integer := 8  -- Numero di bit (default: 8)
    );
    Port (
        A, B   : in  std_logic_vector(M-1 downto 0); -- Operandi M-bit
        SUM    : out std_logic_vector(M-1 downto 0)  -- Somma M-bit
    );
end Adder;

architecture Behavioral of Adder is
begin
    process(A, B)
    begin
        SUM <= std_logic_vector(unsigned(A) + unsigned(B));
    end process;
end Behavioral;

