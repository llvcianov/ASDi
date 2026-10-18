----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    30.01.2025 
-- Design Name: 
-- Module Name:    Divisore - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
--     Questo modulo divide una frequenza di ingresso arbitraria per ottenere 
--     un'uscita di 1 Hz.
-- Dependencies: 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Divisore is
    generic (
        CLK_FREQ : integer := 50_000_000  -- Frequenza di clock in Hz (es. 50 MHz)
    );
    Port (
        CLK    : in  std_logic;  -- Clock di ingresso
        RST    : in  std_logic;  -- Reset asincrono
        CLK_1Hz : out std_logic  -- Clock diviso a 1 Hz
    );
end Divisore;

architecture Behavioral of Divisore is
    constant MAX_COUNT : integer := CLK_FREQ / 2;  -- Numero di cicli per mezzo periodo
    signal counter : integer := 0;
    signal clk_div : std_logic := '0';
begin

    process(CLK, RST)
    begin
        if RST = '1' then
            counter <= 0;
            clk_div <= '0';
        elsif rising_edge(CLK) then
            if counter = MAX_COUNT - 1 then
                counter <= 0;
                clk_div <= not clk_div;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    CLK_1Hz <= clk_div;

end Behavioral;
