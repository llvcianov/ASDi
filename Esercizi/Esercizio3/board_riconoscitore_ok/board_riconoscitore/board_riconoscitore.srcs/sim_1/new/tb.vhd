LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY riconoscitore_tb IS
END riconoscitore_tb;

ARCHITECTURE test OF riconoscitore_tb IS

    -- Dichiarazione del componente da testare
    COMPONENT riconoscitore_board
        PORT (
            i, rst, m   : IN std_logic;
            A           : IN std_logic;
            Bi, Bm      : IN std_logic;
            y           : OUT std_logic
        );
    END COMPONENT;
    
    -- Segnali di test
    SIGNAL i_tb, rst_tb, m_tb : std_logic := '0';
    SIGNAL A_tb               : std_logic := '0';
    SIGNAL Bi_tb, Bm_tb       : std_logic := '0';
    SIGNAL y_tb               : std_logic;
    
    -- Periodo del clock
    CONSTANT periodo_clock : TIME := 10 ns;
    
BEGIN
    
    -- Istanziazione del riconoscitore
    DUT: riconoscitore_board PORT MAP (
        i => i_tb,
        rst => rst_tb,
        m => m_tb,
        A => A_tb,
        Bi => Bi_tb,
        Bm => Bm_tb,
        y => y_tb
    );
    
    -- Generazione del clock
    process
    begin
        while true loop
            A_tb <= '0';
            wait for periodo_clock / 2;
            A_tb <= '1';
            wait for periodo_clock / 2;
        end loop;
    end process;
    
    -- Processo di test
    process
    begin
        -- Reset iniziale
        rst_tb <= '1';
        wait for 20 ns;
        rst_tb <= '0';
        
        -- Test defaut modalità non sovrapposte
        m_tb <= '0';
        i_tb <= '1';
        Bi_tb <= '1';
        wait for 10 ns;
        Bi_tb <= '0';
        wait for 20 ns;
        i_tb <= '0';
        wait for 20 ns;
        i_tb <= '1';
        wait for 20 ns;
        i_tb <= '0';
        wait for 20 ns;
        Bi_tb <= '1';
        wait for 10 ns;
        Bi_tb <= '0';
        wait for 20 ns;
        i_tb <= '1';
        wait for 20 ns;
        Bi_tb <= '1';   --qui ho uscita alta
        wait for 10 ns;
        Bi_tb <= '0';
        wait for 20 ns;
        i_tb <= '0';
        
        -- cambio: Test modalità sovrapposte
        wait for 20 ns;
        m_tb <= '1';
        wait for 20ns;
        i_tb <= '1';
        wait for 20 ns;
        Bi_tb <= '1';
        wait for 10 ns;
        Bi_tb <= '0';
        wait for 20 ns;
        i_tb <= '0';
        wait for 20 ns;
        Bm_tb <= '1';
        wait for 10 ns;
        Bm_tb <= '0';
        wait for 20 ns;
        i_tb <= '1';
        wait for 20 ns;
        Bi_tb <= '1';
        wait for 10 ns;
        Bi_tb <= '0';
        i_tb <= '0';
        
        
        -- Fine test
        wait;
    end process;
    
END test;
