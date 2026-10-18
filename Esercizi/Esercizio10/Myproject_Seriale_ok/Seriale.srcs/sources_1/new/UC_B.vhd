----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.02.2025 11:08:02
-- Design Name: 
-- Module Name: unita_controllo - Behavioral
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

entity UC_B is
    Generic (
        N : integer := 64 -- Numero di locazioni di memoria
    );
    Port( 
        clk, rst: in std_logic;
        RDA: in std_logic; 
        error : in std_logic_vector(2 downto 0);                  
        en_count, RD, write: out std_logic
     );
end UC_B;

architecture Behavioral of UC_B is
    type stato is (IDLE, AVVIA_RX, AVVIA_SCRITTURA);
    signal stato_corrente : stato := IDLE;
    signal stato_prossimo : stato := stato_corrente;
    
    begin
    
    mem_stato: process (clk, rst)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                stato_corrente <= idle;
            else
                stato_corrente <= stato_prossimo;                
            end if;
        end if;
    end process;
    
    comb: process (stato_corrente, RDA)
    begin
    
        case stato_corrente is
            when IDLE =>
                en_count <= '0';
                RD <= '0';
                write <= '0';
       
                if (RDA = '0') then
                    stato_prossimo <= IDLE;
                
                elsif (RDA = '1') then
                    stato_prossimo <= AVVIA_RX;
                end if;
            
            when AVVIA_RX  =>
                RD <= '1';
                stato_prossimo <= AVVIA_SCRITTURA;
            
            when AVVIA_SCRITTURA =>
                RD <= '0';
                write <= '1';
                en_count <= '1';
                stato_prossimo <= IDLE;                    

            when OTHERS =>
                stato_prossimo <= IDLE;
                
        end case;       
    end process;            

end Behavioral;

