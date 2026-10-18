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

entity UC_A is
    Generic (
        N : integer := 64 -- Numero di locazioni di memoria
    );
    Port( 
        clk, rst, start : in std_logic;
        TBE : in std_logic; 
        counter : in std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);                   
        en_count, read, WR, stop: out std_logic
     );
end UC_A;

architecture Behavioral of UC_A is
    type stato is (IDLE, AVVIA_LETTURA, WAIT_TBE, AVVIA_TX, FINE);
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
    
    comb: process (stato_corrente, start, counter, TBE)
    begin
    
        case stato_corrente is
            when IDLE =>
                en_count <= '0';
                WR <= '0';
                read <= '0';
                stop <= '0';
       
                if (start='0') then
                    stato_prossimo <= IDLE;
                
                elsif (start='1') then
                    stato_prossimo <= AVVIA_LETTURA;
                end if;
            
            when AVVIA_LETTURA  =>
                read <= '1';
                stato_prossimo <= AVVIA_TX;
            
           when AVVIA_TX =>
                en_count <= '1';
                WR <= '1';
                read <= '0';            
                stato_prossimo <= WAIT_TBE; 
            
            when WAIT_TBE =>
                WR <= '0';
                en_count <= '0';
                
                if (TBE = '0') then
                    stato_prossimo <= WAIT_TBE;
                
                elsif (TBE = '1' and counter /= std_logic_vector(to_unsigned(0, counter'length))) then
                    stato_prossimo <= AVVIA_LETTURA;
                 
                elsif (TBE = '1' and counter = std_logic_vector(to_unsigned(0, counter'length))) then
                    stato_prossimo <= FINE;   
                    
                end if;                
                
            when FINE =>
                stop <= '1';
                stato_prossimo <= IDLE;

            when OTHERS =>
                stato_prossimo <= IDLE;
                
        end case;       
    end process;            

end Behavioral;

