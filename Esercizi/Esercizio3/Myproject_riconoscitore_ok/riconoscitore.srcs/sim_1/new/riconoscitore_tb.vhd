----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.01.2025 17:28:20
-- Design Name: 
-- Module Name: riconoscitore_tb - bench
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

entity tb_riconoscitore is
end tb_riconoscitore;

architecture behavioral of tb_riconoscitore is

    component riconoscitore_m
        port(
            i   : in std_logic;         -- ingresso
            rst : in std_logic;        -- reset
            m   : in std_logic;        -- modalità
            A   : in std_logic;        -- clock
            y   : out std_logic        -- uscita
        );               
    end component;

    -- Dichiarazione dei segnali
    signal i : std_logic := '0';       -- ingresso
    signal rst : std_logic := '0';      -- reset
    signal m : std_logic := '0';        -- modalità
    signal A : std_logic := '0';        -- clock
    signal y : std_logic;               -- uscita

    -- Periodo del clock
    constant clk_period : time := 10 ns;
    
begin

    -- Istanza del modulo riconoscitore
    uut: entity work.riconoscitore
        port map (
            i => i,
            rst => rst,
            m => m,
            A => A,
            y => y
        );

    -- Generazione del clock
    clk_process : process
    begin
        A <= '0';
        wait for clk_period / 2;
        A <= '1';
        wait for clk_period / 2;
    end process;

    -- Stimoli di ingresso (sequenza di test)
    stim_proc: process
    begin

        -- Test con sequenza di valori di i
        m <= '0';  -- modalità non sovrapposte
        i <= '0';
        wait for 10 ns;
        i <= '1';
        wait for 10 ns;
        i <= '0';
        wait for 10 ns;
        i <= '1';
        wait for 10 ns;
        i <= '0';
        wait for 10 ns;
        i <= '1';
        wait for 10 ns;
        i <= '0';
        wait for 10 ns;
        i <= '1';
        wait for 30 ns;
        i <= '0';
        wait for 10 ns;
        i <= '1';
        wait for 10 ns;
        i <= '0';
        wait for 10 ns;
        i <= '1';
        wait for 10 ns;
        
        -- Cambio modalità a '1' (sovrapposte parzialmente)
        m <= '1'; 
        i <= '0';
        wait for 10 ns;
        i <= '1';
        wait for 10 ns;
        i <= '0';
        wait for 10 ns;
        i <= '1';
        wait for 10 ns;
        i <= '0';
        wait for 10 ns;
        i <= '1';
        wait for 10 ns;
        i <= '0';
        wait for 10 ns;
        i <= '1';
        wait for 30 ns;
        i <= '0';
        wait for 10 ns;
        i <= '1';
        wait for 10 ns;
        i <= '0';
        wait for 10 ns;
        i <= '1';
        wait for 10 ns;        
         
        -- Completamento simulazione
        wait;
    end process;

end;
