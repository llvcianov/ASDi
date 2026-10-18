----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.01.2025 16:57:04
-- Design Name: 
-- Module Name: rete_16_4_tb - Behavioral
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

entity rete_16_4_tb is
-- Vuoto perché non stiamo creando un oggetto
end rete_16_4_tb;

architecture Behavioral of rete_16_4_tb is

    -- Dichiarazione del componente sotto test
    component rete_16_4 is
        Port (
            ar : in std_logic_vector (15 downto 0); -- 16 ingressi (1-16)
            sr : in std_logic_vector (5 downto 0);  -- 6 bit di selezione (4 per il mux, 2 per il demux)
            yr : out std_logic_vector (3 downto 0)  -- 4 uscite del demux (1-4)
        );
    end component;

    -- Segnali di test
    signal ar : std_logic_vector (15 downto 0); -- 16 ingressi
    signal sr : std_logic_vector (5 downto 0);  -- 6 bit di selezione
    signal yr : std_logic_vector (3 downto 0);  -- 4 uscite

begin

    -- Istanziazione della rete sotto test
    UUT: rete_16_4
        port map (
            ar => ar,
            sr => sr,
            yr => yr
        );

    -- Processo di stimolo
    stimulus: process
    begin
        -- Caso 1: Ingresso 1 attivo, selezione mux 1, demux 1
        wait for 100 ns;
        ar <= "0000000000000001"; -- Ingresso 1 attivo (bit 0)
        sr <= "000000";          -- Mux: 1 (0000), Demux: 1 (00)
        wait for 10 ns;
        ASSERT yr = "0001"       -- Uscita 1 attiva
            REPORT "Caso 1 fallito" SEVERITY failure;

        -- Caso 2: Ingresso 15 attivo, selezione mux 15, demux 4
        ar <= "0100000000000000"; -- Ingresso 15 attivo (bit 14)
        sr <= "111011";          -- Mux: 15 (1110), Demux: 4 (11)
        wait for 10 ns;
        ASSERT yr = "1000"       -- Uscita 4 attiva
            REPORT "Caso 2 fallito" SEVERITY failure;

        -- Caso 3: Ingressi pari attivi, selezione mux 6, demux 2
        ar <= "1010101010101010"; -- Ingressi pari attivi (2, 4, 6, ...)
        sr <= "010101";          -- Mux: 6 (0101), Demux: 2 (01)
        wait for 10 ns;
        ASSERT yr = "0010"       -- Uscita 2 attiva
            REPORT "Caso 3 fallito" SEVERITY failure;

        -- Caso 4: Nessun ingresso attivo, selezione mux 16, demux 3
        ar <= "0000000000000000"; -- Nessun ingresso attivo
        sr <= "111110";          -- Mux: 16 (1111), Demux: 3 (10)
        wait for 10 ns;
        ASSERT yr = "0000"       -- Nessuna uscita attiva
            REPORT "Caso 4 fallito" SEVERITY failure;

        -- Caso 5: Ingresso 8 attivo, selezione mux 8, demux 3
        ar <= "0000000010000000"; -- Ingresso 8 attivo (bit 7)
        sr <= "011110";          -- Mux: 8 (0111), Demux: 3 (10)
        wait for 10 ns;
        ASSERT yr = "0100"       -- Uscita 3 attiva
            REPORT "Caso 5 fallito" SEVERITY failure;

        -- Caso 6: Ingressi dispari attivi, selezione mux 3, demux 4
        ar <= "0101010101010101"; -- Ingressi dispari attivi (1, 3, 5, ...)
        sr <= "001011";          -- Mux: 3 (0010), Demux: 4 (11)
        wait for 10 ns;
        ASSERT yr = "1000"       -- Uscita 4 attiva
            REPORT "Caso 6 fallito" SEVERITY failure;

        -- Caso 7: Ingresso 16 attivo, selezione mux 16, demux 1
        ar <= "1000000000000000"; -- Ingresso 16 attivo (bit 15)
        sr <= "111100";          -- Mux: 16 (1111), Demux: 1 (00)
        wait for 10 ns;
        ASSERT yr = "0001"       -- Uscita 1 attiva
            REPORT "Caso 7 fallito" SEVERITY failure;

        -- Fine del test
        wait;
    end process;

end Behavioral;


