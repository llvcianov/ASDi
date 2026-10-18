----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.01.2025 12:18:15
-- Design Name: 
-- Module Name: sistema_tb - Behavioral
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

entity tb_sistema is
end tb_sistema;

architecture Behavioral of tb_sistema is
    -- Componenti da testare
    component sistema is
        Port (
            address : in std_logic_vector (3 downto 0);
            y       : out std_logic_vector (3 downto 0)
        );
    end component;

    -- Segnali locali per il test
    signal tb_address : std_logic_vector(3 downto 0);
    signal tb_y       : std_logic_vector(3 downto 0);
    

    begin
    -- Instanza del DUT (Device Under Test)
    uut: sistema
        port map (
            address => tb_address,
            y       => tb_y
        );

    -- Processo di stimolo
    stimulus: process
    begin
        
        wait for 100 ns;
        -- Test Case 1: Address = 0000
        tb_address <= "0000";
        wait for 10 ns;
        ASSERT tb_y = "0001" 
            REPORT "Caso 1 fallito: Uscita non corrisponde a 0000" SEVERITY failure;

        -- Test Case 2: Address = 0001
        tb_address <= "0001";
        wait for 10 ns;
        ASSERT tb_y = "0111"  
            REPORT "Caso 2 fallito: Uscita non corrisponde a 0001" SEVERITY failure;

        -- Test Case 3: Address = 0010
        tb_address <= "0010";
        wait for 10 ns;
        ASSERT tb_y = "1101"  
            REPORT "Caso 3 fallito: Uscita non corrisponde a 0010" SEVERITY failure;

        -- Test Case 4: Address = 0110
        tb_address <= "0110";
        wait for 10 ns;
        ASSERT tb_y = "0010"  
            REPORT "Caso 4 fallito: Uscita non corrisponde a 1111" SEVERITY failure;

            -- Test Case 4: Address = 0110
        tb_address <= "0110";
        wait for 10 ns;
        ASSERT tb_y = "0010"  
            REPORT "Caso 4 fallito: Uscita non corrisponde a 1111" SEVERITY failure;
        -- Fine della simulazione
        
            -- Test Case 5: Address = 1111
        tb_address <= "1111";
        wait for 10 ns;
        ASSERT tb_y = "1011"  
            REPORT "Caso 5 fallito: Uscita non corrisponde a 1111" SEVERITY failure;
        -- Fine della simulazione        
        
        
        wait;
    end process;

end Behavioral;



