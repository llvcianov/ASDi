----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.02.2025 09:47:10
-- Design Name: 
-- Module Name: booth_tb - Behavioral

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity booth_tb is
end booth_tb;

architecture behavioural of booth_tb is

    -- Dichiarazione del componente da testare
    component booth is
        Port ( 
            clk, rst, start : in std_logic;
            X, Y : in std_logic_vector(7 downto 0);
            P : out std_logic_vector (15 downto 0);
            stop: out std_logic
        );
    end component;

    -- Segnali per i test
    signal clk, rst, start : std_logic;
    signal X, Y : std_logic_vector(7 downto 0);
    signal P : std_logic_vector(15 downto 0);
    signal stop : std_logic;
    
    constant clk_period : time := 20 ns;
    signal end_sim : std_logic := '0';
    
begin

    -- Istanza del DUT (Device Under Test)
    uut: booth port map(
        clk => clk, 
        rst => rst, 
        start => start, 
        X => X, 
        Y => Y, 
        P => P, 
        stop => stop
    );

    -- Generazione del clock
    clk_process : process
    begin
        while (end_sim = '0') loop
            clk <= '1';
            wait for clk_period / 2;
            clk <= '0';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    -- Stimoli per il testbench
    sim: process
    begin
        wait for 100 ns;
        
        -- Reset
        rst <= '1';
        wait for 20 ns;
        rst <= '0';

        -- ------------------- Operazione 1:  5 * -3 = -15 (FFF1)
        X <= "00000101"; -- 5
        Y <= "11111101"; -- -3
        
        wait for 40 ns;
        start <= '1';
        wait for 20 ns;
        start <= '0';
        wait for 700 ns;

        -- Reset
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 20 ns;

        -- ------------------- Operazione 2:  -5 * 3 = -15 (FFF1)
        X <= "11111011"; -- -5
        Y <= "00000011"; -- 3
        
        wait for 40 ns;
        start <= '1';
        wait for 20 ns;
        start <= '0';
        wait for 600 ns;

        -- Reset
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 20 ns;

        -- ------------------- Operazione 3:  -3 * 3 = -9 (FFF7)
        X <= "11111101"; -- -3
        Y <= "00000011"; -- 3
        
        wait for 40 ns;
        start <= '1';
        wait for 20 ns;
        start <= '0';
        wait for 600 ns;

        -- Reset
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 20 ns;

        -- ------------------- Operazione 4:  -3 * -5 = 15 (000F)
        X <= "11111101"; -- -3
        Y <= "11111011"; -- -5
        
        wait for 40 ns;
        start <= '1';
        wait for 20 ns;
        start <= '0';
        wait for 600 ns;

        -- Reset
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 20 ns;

        -- ------------------- Operazione 5:  -128 * -128 = 16384 (4000)
        X <= "10000000"; -- -128
        Y <= "10000000"; -- -128
        
        wait for 40 ns;
        start <= '1';
        wait for 20 ns;
        start <= '0';
        wait for 600 ns;

        -- Fine della simulazione
        end_sim <= '1';
        wait;
    end process;

end behavioural;
