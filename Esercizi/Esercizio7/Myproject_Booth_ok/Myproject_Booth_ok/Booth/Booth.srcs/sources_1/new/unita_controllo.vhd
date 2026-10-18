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

entity unita_controllo is
    Port( 
        clk, rst, start : in std_logic;
        LSB_Q : in std_logic_vector (1 downto 0); 
        counter : in std_logic_vector (3 downto 0);                   
        en_count, en_shift, en_sub, loadM, loadAQ, selAQ : out std_logic;
        stop : out std_logic
     );
end unita_controllo;

architecture Behavioral of unita_controllo is
    type stato is (IDLE, INIT, WAITINIT, SCAN, OP, SHIFT, COUNT);
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
    
    comb: process (stato_corrente, start, counter)
    begin
    
        case stato_corrente is
            when IDLE =>
                en_count <= '0';
                en_shift <= '0';
                en_sub <= '0';
                loadM <= '0';
                loadAQ <= '0';
                selAQ <= '0';
                stop <= '0';
       
                if (start='0') then
                    stato_prossimo <= IDLE;
                
                elsif (start='1') then
                    stato_prossimo <= INIT;
                end if;
            
            when INIT  =>
                loadM <= '1';
                loadAQ <= '1';
                stato_prossimo <= scan;
                stato_prossimo <= waitINIT;
            
            when WAITINIT =>
                loadM <= '0';
                loadAQ <= '0';
                stato_prossimo <= SCAN;
                     
            when SCAN =>
            
                en_count <= '0';            
            
                if(counter = "1000")then
                    stop <= '1';
                    stato_prossimo <= IDLE;
                
                elsif (LSB_Q = "11" OR LSB_Q = "00") then
                    stato_prossimo <= SHIFT;
                    
                elsif (LSB_Q = "10") then
                    en_sub <= '1';
                    stato_prossimo <= OP;
                     
                elsif (LSB_Q="01") then
                    stato_prossimo <= OP;
                -- qui è appena stata eseguita la somma o la sottrazione    
                end if;                   
                     
            when OP =>
                selAQ <= '1';
                loadAQ <= '1';
                stato_prossimo <= SHIFT;
                
            when SHIFT =>
                en_sub <= '0';
                loadAQ <= '0';
                en_shift <= '1';
                stato_prossimo <= COUNT;
            
            when COUNT =>
                en_shift <= '0';
                en_count <= '1';
                stato_prossimo <= SCAN;
  
            when OTHERS =>
                stato_prossimo <= IDLE;
                
        end case;       
    end process;            

end Behavioral;
