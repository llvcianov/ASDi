----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.01.2025 11:48:52
-- Design Name: 
-- Module Name: mux_16_1_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity mux_16_1_tb is
--  vuoto perchè non stiamo creando un oggetto 
end mux_16_1_tb;

architecture Behavioral of mux_16_1_tb is
    component mux_16_1 is
        Port ( 
            c : in std_logic_vector (15 downto 0);
            s : in std_logic_vector (3 downto 0);
            y : out std_logic
        );
    end component;
  
    signal inputs       : std_logic_vector (15 downto 0);
    signal selections   : std_logic_vector (3 downto 0);
    signal output       : std_logic;
  
    begin
    
        uut : mux_16_1
            port map(
                c => inputs,
                s => selections,
                y => output
            );
            
    stim_proc : process
        begin

            -- Caso 1: 1° ingresso attivo, selezione "0000" (1)
            wait for 100 ns;
            inputs <= "0000000000000001";
            selections <= "0000";
            wait for 10 ns;
            ASSERT output = '1'
                REPORT "test case 1 fallito" SEVERITY failure;


            -- Caso 2: 1° ingresso attivo, selezione "1101" (14)
            selections <= "1101";
            wait for 10 ns;
            ASSERT output = '0'
                REPORT "test case 2 fallito" SEVERITY failure;


            -- Caso 3: 3°, 7°, 14° ingresso atttivo con selezione "1101" (14)
            inputs <= "0010000001000100";
            wait for 10 ns;
            ASSERT output = '1'
               REPORT "test case 3 fallito" SEVERITY failure;           

            -- Caso 4: 16° ingresso attivo, selezione "0000" (1)
            inputs <= "1000000000000000";
            selections <= "0000";
            wait for 10 ns;
            ASSERT output = '0'
                REPORT "test case 4 fallito" SEVERITY failure;

            -- Caso 5: 16° ingresso attivo, selezione "1111" (16)
            selections <= "1111";
            wait for 10 ns;
            ASSERT output = '1'
                REPORT "test case 5 fallito" SEVERITY failure;            

            -- Caso 6: 8° ingresso attivo, selezione "0111" (8)
            inputs <= "0000000010000000";
            selections <= "0111";
            wait for 10 ns;
            ASSERT output = '1'
                REPORT "test case 6 fallito" SEVERITY failure;

            -- Caso 7: Nessun ingresso attivo, verifica che l'uscita sia "0"
            inputs <= "0000000000000000";
            selections <= "0101";
            wait for 10 ns;
            ASSERT output = '0'
                REPORT "test case 7 fallito" SEVERITY failure;

            -- Caso 8: Ingressi dispari attivi, selezione "0010" (3)
            inputs <= "0101010101010101"; 
            selections <= "0010";
            wait for 10 ns;
            ASSERT output = '1'
                REPORT "test case 8 fallito" SEVERITY failure;

            -- Fine del processo di test
            wait;

    end process;


end Behavioral;
