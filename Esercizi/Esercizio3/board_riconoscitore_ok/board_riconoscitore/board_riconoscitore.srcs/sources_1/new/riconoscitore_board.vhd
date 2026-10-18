----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: riconoscitore - Behavioral
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity riconoscitore_board is
    Port (
        i, rst, m   : in std_logic; --ingresso, reset, modo 
        A           : in std_logic; --clock
        Bi, Bm      : in std_logic;
        y           : out std_logic --uscita
    );
end riconoscitore_board;

architecture Behavioral of riconoscitore_board is

    type stato is (q0,q1,q2,q3,q4,q5,q6,q7);
    signal stato_corrente : stato := q0;
    signal stato_prossimo : stato := stato_corrente;
    signal y_temp : std_logic;
    signal  m_temp : std_logic := '0';
    
    begin
        update : process (stato_corrente, i, m_temp) 
        begin
        Case m_temp is
            when '0' =>    --non sovrapposte 
                Case stato_corrente is           
                    
                    when q0 =>
                        if (i = '0') then
                            stato_prossimo <= q3;
                            y_temp <= '0';
                        else 
                            stato_prossimo <= q1;
                            y_temp <= '0';
                        end if;
                
                    when q3 =>
                        stato_prossimo <= q4;
                        y_temp <= '0';
                        
                    when q4 =>
                        stato_prossimo <= q0;
                        y_temp <= '0';
                        
                    when q1 =>
                        if (i = '0') then
                            stato_prossimo <= q2;
                            y_temp <= '0';
                        else 
                            stato_prossimo <= q4;
                            y_temp <= '0';
                        end if;  
                    when q2 =>
                        if (i='0') then
                            stato_prossimo <= q0;
                            y_temp <= '0';
                        else 
                            stato_prossimo <= q0;
                            y_temp <= '1';
                        end if;
                    when others =>
                        stato_prossimo <= q0;                       
                end case;
            
            when '1' =>   --sovrapposte parzialmente  
                Case stato_corrente is
                
                    when q5 =>
                        if (i='0') then
                            stato_prossimo <= q5;
                            y_temp <= '0';
                        else 
                            stato_prossimo <= q6;
                            y_temp <= '0';
                        end if;
                        
                    when q6 =>
                        if (i='0') then
                            stato_prossimo <= q7;
                            y_temp <= '0';
                        else 
                            stato_prossimo <= q6;
                            y_temp <= '0';
                        end if;
                        
                    when q7 =>
                        if (i='0') then
                            stato_prossimo <= q5;
                            y_temp <= '0';
                        else 
                            stato_prossimo <= q5;
                            y_temp <= '1';
                        end if;
                    when others =>
                        stato_prossimo <= q5;     
                end case;
                
            when others =>  --default
                stato_prossimo <= q0;
                y_temp <= '0'; 
                
        end case;
        end process;

        mem : process (A)
        begin
        if (rising_edge(A)) then 
        
            if (rst = '1' and m_temp = '1') then
                stato_corrente <= q5;
                y <= '0';
                
            elsif (rst = '1' and m_temp = '0') then    
                stato_corrente <= q0;
                y <= '0';
                
            elsif Bi='1' then
                stato_corrente <= stato_prossimo;
                y <= y_temp;                       
            
            elsif BM = '1' then
                m_temp <= M;
                if (M = '1') then
                    stato_corrente <= q5;
                    
                elsif (M = '0') then
                    stato_corrente <= q0;
                    
                end if;
            end if;

        end if;
        end process;
end Behavioral;
