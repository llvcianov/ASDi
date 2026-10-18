----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: Divisore_frequenza - Behavioral
-- Project Name: 
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity Divisore is
        generic (
            CLK_FREQ : integer := 100000000
        );
        port (
            CLK : in std_logic;
            RST : in std_logic;
            CLK_1Hz : out std_logic
        );
end Divisore;

architecture Behavioral of Divisore is
    signal counter : integer range 0 to (CLK_FREQ/2)-1 := 0;
    signal clk_reg : std_logic := '0';
begin
    CLK_1Hz <= clk_reg;

    process(CLK, RST)
    begin
        if RST = '1' then
            counter <= 0;
            clk_reg <= '0';
        elsif rising_edge(CLK) then
            if counter = (CLK_FREQ/2)-1 then
                counter <= 0;
                clk_reg <= not clk_reg;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
end Behavioral;
