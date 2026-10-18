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
        clk, rst, REQ : in std_logic; 
        counter : in std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);                  
        en_count, read, write, loadA, loadB, ACK: out std_logic
     );
end UC_B;

architecture Behavioral of UC_B is
    type stato is (IDLE, AVVIA_LETTURA, ACQUISISCI_OP, AVVIA_SCRITTURA, END_HANDSHAKING);
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
    
    comb: process (stato_corrente, counter, REQ)
    begin
    
        case stato_corrente is
            when IDLE =>
                en_count <= '0';
                ACK <= '0';
                loadA <= '0';
                loadB <= '0';
                read <= '0';
                write <= '0';
       
                if (REQ = '0') then
                    stato_prossimo <= IDLE;
                
                elsif (REQ = '1') then
                    stato_prossimo <= AVVIA_LETTURA;
                end if;
            
            when AVVIA_LETTURA  =>
                read <= '1';
                ACK <= '1';
                stato_prossimo <= ACQUISISCI_OP;
            
            when ACQUISISCI_OP =>
                loadA <= '1';
                loadB <= '1';
                read <= '0';
                stato_prossimo <= AVVIA_SCRITTURA;
                     
            when AVVIA_SCRITTURA =>
                write <= '1';
                loadA <= '0';
                loadB <= '0';
                
                if (REQ = '1') then
                    stato_prossimo <= AVVIA_SCRITTURA;
                
                elsif (REQ = '0') then
                    stato_prossimo <= END_HANDSHAKING;
                end if;                                  
                     
            when END_HANDSHAKING =>
                en_count <= '1';
                ACK <= '0';
                write <= '0';
                stato_prossimo <= IDLE;

            when OTHERS =>
                stato_prossimo <= IDLE;
                
        end case;       
    end process;            

end Behavioral;

