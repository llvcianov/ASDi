----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.02.2025 15:19:39
-- Design Name: 
-- Module Name: MEM - 
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all; 

entity MEM is
    Generic (
        N : integer := 64 -- Numero di locazioni di memoria (modificabile)
    );
    Port (
        CLK     : in std_logic;
        Address : in std_logic_vector (integer(ceil(log2(real(N))))-1 downto 0);
        Write   : in std_logic;
        dataIN  : in std_logic_vector (3 downto 0) 
    );
end MEM;

architecture Behavioral of MEM is

    type MEMORY_TYPE is array (0 TO N-1) of std_logic_vector(3 downto 0);

    -- Dichiarazione della memoria come segnale
    signal MEM : MEMORY_TYPE := (
        others => "0000"  -- Tutte le altre locazioni con 0
    );

begin

    set_data : process (CLK)
    begin
        if rising_edge(CLK) then
            if(Write = '1') then
                MEM(to_integer(unsigned(Address))) <= dataIN;
            end if;
        end if;
    end process set_data;

end Behavioral;