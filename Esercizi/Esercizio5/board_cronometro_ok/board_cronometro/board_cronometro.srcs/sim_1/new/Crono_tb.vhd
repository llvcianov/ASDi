----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.02.2025 12:26:01
-- Design Name: 
-- Module Name: Crono_tb - 
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

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY Crono_tb IS
END Crono_tb;

ARCHITECTURE behavior OF Crono_tb IS 

    -- Component under test (CUT)
    COMPONENT Crono
        PORT (
            CLK:        IN std_logic;
            RST:        IN std_logic;
            Secload:    IN std_logic;
            Minload:    IN std_logic;
            Hrload:     IN std_logic;
            SecToset:   IN std_logic_vector(5 downto 0);
            MinToset:   IN std_logic_vector(5 downto 0);
            HrToset:    IN std_logic_vector(4 downto 0);
            SecOUT:     OUT std_logic_vector(5 downto 0);
            MinOUT:     OUT std_logic_vector(5 downto 0);
            HrOUT:      OUT std_logic_vector(4 downto 0)
        );
    END COMPONENT;

    -- Signals for testbench
    SIGNAL CLK_tb:      std_logic := '0';
    SIGNAL RST_tb:      std_logic := '0';
    SIGNAL Secload_tb:  std_logic := '0';
    SIGNAL Minload_tb:  std_logic := '0';
    SIGNAL Hrload_tb:   std_logic := '0';
    SIGNAL SecToset_tb: std_logic_vector(5 downto 0) := (others => '0');
    SIGNAL MinToset_tb: std_logic_vector(5 downto 0) := (others => '0');
    SIGNAL HrToset_tb:  std_logic_vector(4 downto 0) := (others => '0');
    SIGNAL SecOUT_tb:   std_logic_vector(5 downto 0);
    SIGNAL MinOUT_tb:   std_logic_vector(5 downto 0);
    SIGNAL HrOUT_tb:    std_logic_vector(4 downto 0);

    -- Clock period (simuliamo un clock rapido per velocizzare il test)
    CONSTANT CLK_period : time := 10 ns;

BEGIN

    -- Instanziazione del componente Crono
    uut: Crono
        PORT MAP (
            CLK       => CLK_tb,
            RST       => RST_tb,
            Secload   => Secload_tb,
            Minload   => Minload_tb,
            Hrload    => Hrload_tb,
            SecToset  => SecToset_tb,
            MinToset  => MinToset_tb,
            HrToset   => HrToset_tb,
            SecOUT    => SecOUT_tb,
            MinOUT    => MinOUT_tb,
            HrOUT     => HrOUT_tb
        );

    -- Clock process
    clk_process: PROCESS
    BEGIN
        WHILE NOW < 10000 ns LOOP  -- Simulazione fino a 10.000 ns
            CLK_tb <= '0';
            WAIT FOR CLK_period / 2;
            CLK_tb <= '1';
            WAIT FOR CLK_period / 2;
        END LOOP;
        WAIT;
    END PROCESS;

    -- Stimulus process
    stim_proc: PROCESS
    BEGIN
        -- **1 RESET iniziale**
        RST_tb <= '1';
        WAIT FOR 20 ns;
        RST_tb <= '0';
        WAIT FOR 20 ns;

        -- **2 Conteggio naturale fino a 23:59:59 ? 00:00:00**
        WAIT FOR 600 ns; -- Aspettiamo il passaggio del tempo

        -- **3 Settaggio manuale: 23:45:50**
        Secload_tb <= '1';
        SecToset_tb <= "110010";  -- 50 in binario
        WAIT FOR 10 ns;
        Secload_tb <= '0';

        Minload_tb <= '1';
        MinToset_tb <= "101101";  -- 45 in binario
        WAIT FOR 10 ns;
        Minload_tb <= '0';

        Hrload_tb <= '1';
        HrToset_tb <= "10111";    -- 23 in binario
        WAIT FOR 10 ns;
        Hrload_tb <= '0';

        -- **4 Aspettiamo il passaggio 23:59:59 ? 00:00:00**
        WAIT FOR 600 ns;

        -- **5 Reset del sistema**
        RST_tb <= '1';
        WAIT FOR 10 ns;
        RST_tb <= '0';
        
        WAIT FOR 600 ns;
        
        Secload_tb <= '1';
        SecToset_tb <= "110010";  -- 50 in binario
        WAIT FOR 10 ns;
        Secload_tb <= '0';

        Minload_tb <= '1';
        MinToset_tb <= "111011";  -- 59 in binario
        WAIT FOR 10 ns;
        Minload_tb <= '0';

        Hrload_tb <= '1';
        HrToset_tb <= "10111";    -- 23 in binario
        WAIT FOR 10 ns;
        Hrload_tb <= '0';        
        
        -- **6 Verifica che il conteggio riparta da 00:00:00**
        WAIT FOR 600 ns;

        -- Fine test
        WAIT;
    END PROCESS;
END behavior;


