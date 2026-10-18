----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.02.2025 16:22:47
-- Design Name: 
-- Module Name: ROM - 
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

entity ROM is
    Generic (
        N : integer := 64 -- Numero di locazioni di memoria (modificabile)
    );
    Port (
        CLK     : in std_logic;
        Address : in std_logic_vector (integer(ceil(log2(real(N))))-1 downto 0);
        Read    : in std_logic;
        dataOUT : out std_logic_vector (7 downto 0) 
    );
end ROM;

architecture Behavioral of ROM is

    type MEMORY_TYPE is array (0 TO N-1) of std_logic_vector(7 downto 0);

    -- Inizializzazione della memoria con valori specifici per le prime 32 locazioni
    constant ROM : MEMORY_TYPE := (
        0  => "01000001", -- 65 (decimale)
        1  => "01100111", -- 103 (decimale)
        2  => "11010010", -- 210 (decimale)
        3  => "10001101", -- 141 (decimale)
        4  => "00111010", -- 58 (decimale)
        5  => "01000100", -- 68 (decimale)
        6  => "00101100", -- 44 (decimale)
        7  => "01000100", -- 68 (decimale)
        8  => "11001101", -- 205 (decimale)
        9  => "01101011", -- 107 (decimale)
        10 => "10001110", -- 142 (decimale)
        11 => "11101011", -- 235 (decimale)
        12 => "10011111", -- 159 (decimale)
        13 => "01001101", -- 77 (decimale)
        14 => "11001100", -- 204 (decimale)
        15 => "00111011", -- 59 (decimale)
--        16 => "01010101", -- 85 (decimale)
--        17 => "00110011", -- 51 (decimale)
--        18 => "11110000", -- 240 (decimale)
--        19 => "01011001", -- 89 (decimale)
--        20 => "10010010", -- 146 (decimale)
--        21 => "01111010", -- 122 (decimale)
--        22 => "10000011", -- 131 (decimale)
--        23 => "11100001", -- 225 (decimale)
--        24 => "00011001", -- 25 (decimale)
--        25 => "10101110", -- 174 (decimale)
--        26 => "01100110", -- 102 (decimale)
--        27 => "10111001", -- 185 (decimale)
--        28 => "01011010", -- 90 (decimale)
--        29 => "11000011", -- 195 (decimale)
--        30 => "10010101", -- 149 (decimale)
--        31 => "00110010", -- 50 (decimale)
        others => "00000000"  -- Tutte le altre locazioni con 0
    );

begin

    get_data : process (CLK)
    begin
        if(rising_edge(CLK)) then
            if(Read = '1') then                
                dataOUT <= ROM(to_integer(unsigned(Address)));
            end if;
        end if;
    end process get_data;

end Behavioral;
