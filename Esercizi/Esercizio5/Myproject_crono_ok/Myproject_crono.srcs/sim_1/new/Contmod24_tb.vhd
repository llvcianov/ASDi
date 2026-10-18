----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.01.2025 19:54:30
-- Design Name: 
-- Module Name: ContMod24_tb - Testbench
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Testbench per ContMod24
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

--entity ContMod24_tb is
--end ContMod24_tb;

--architecture behavior of ContMod24_tb is

--    -- Component under test (CUT)
--    component ContMod24
--        Port (
--            CLK:        in std_logic;
--            RST:        in std_logic;
--            count:      in std_logic;
--            load:       in std_logic;
--            dataToset:  in std_logic_vector(4 downto 0);
--            dataOUT:    out std_logic_vector(4 downto 0)
--        );
--    end component;

--    -- Signals for testbench
--    signal CLK_tb:        std_logic := '0';
--    signal RST_tb:        std_logic := '0';
--    signal count_tb:      std_logic := '0';
--    signal load_tb:       std_logic := '0';
--    signal dataToset_tb:  std_logic_vector(4 downto 0) := (others => '0');
--    signal dataOUT_tb:    std_logic_vector(4 downto 0);

--    -- Clock period
--    constant CLK_period : time := 10 ns;

--begin

--    -- Instantiate CUT
--    uut: ContMod24
--        port map (
--            CLK       => CLK_tb,
--            RST       => RST_tb,
--            count     => count_tb,
--            load      => load_tb,
--            dataToset => dataToset_tb,
--            dataOUT   => dataOUT_tb
--        );

--    -- Clock process
--    clk_process: process
--    begin
--        while now < 999 ns loop
--            CLK_tb <= '0';
--            wait for CLK_period / 2;
--            CLK_tb <= '1';
--            wait for CLK_period / 2;
--        end loop;
--        wait;
--    end process;

--    -- Stimulus process
--    stim_proc: process
--    begin
--        -- Inizializzazione
--        RST_tb <= '1';     -- Applica reset
--        count_tb <= '0';  
--        load_tb <= '0';
--        wait for 20 ns;    -- Attendi stabilizzazione

--        RST_tb <= '0';     -- Rimuovi reset
--        wait for 20 ns;

--        -- Abilita il conteggio
--        count_tb <= '1';

--        -- Attendere il conteggio fino a 24
--        wait for 600 ns;

--        -- Forza un valore specifico con il set (es. valore 12)
--        load_tb <= '1';
--        dataToset_tb <= "01100";  -- Setta il valore a 12 (01100 in binario)
--        wait for 20 ns;
--        load_tb <= '0';   -- Disabilita il set

--        -- Continua il conteggio
--        wait for 200 ns;

--        -- Reset di nuovo
--        RST_tb <= '1';
--        wait for 10 ns;
--        RST_tb <= '0';

--        -- Fine test
--        wait;
--    end process;

--end behavior;
