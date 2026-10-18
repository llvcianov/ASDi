----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.01.2025 10:52:00
-- Design Name: 
-- Module Name: ROM - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 16 locazioni da 8 bit ciascuna, indirizzo A da 4 bit
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ROM is
    Port (
        A       : in std_logic_vector (3 downto 0);
        data    : out std_logic_vector (7 downto 0) 
        --dato contenuto nella locazione di memoria di indirizzo A
    );
end ROM;

architecture Behavioral of ROM is   

    type MEMORY_16_8 is array (0 TO 15) of std_logic_vector(7 downto 0);
    constant ROM : MEMORY_16_8 := (
        b"01000001",
        b"01100111", 
        b"11010010", 
        b"10001101", 
        b"00111010", 
        b"01000100", 
        b"00101100", 
        b"01000100",
        b"11001101", 
        b"01101011", 
        b"10001110", 
        b"11101011", 
        b"10011111", 
        b"01001101", 
        b"11001100", 
        b"00111011"
    );

begin
    get_data : process (A)
    begin
        data <= ROM (to_integer(unsigned(A)));

    end process get_data;
end Behavioral;


