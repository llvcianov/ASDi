
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
        en_count, Sel_R, loadA, loadB, loadC, ACK: out std_logic
     );
end UC_B;

architecture Behavioral of UC_B is
    type stato is (IDLE, ACQUISISCI_OP, WAIT_REQ, COUNT, EVAL, AVVIA_SCRITTURA, WAIT_SCRITTURA);
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
                Sel_R <= '0';
                loadA <= '0';
                loadB <= '0';
                loadC <= '0';
       
                if (REQ = '0') then
                    stato_prossimo <= IDLE;
                
                elsif (REQ = '1') then
                    stato_prossimo <= ACQUISISCI_OP;
                end if;
            
            when ACQUISISCI_OP =>
                ACK <= '1';
                loadA <= '1';
                loadB <= '1';
                stato_prossimo <= WAIT_REQ;
            
            when WAIT_REQ =>
                loadA <= '0';
                loadB <= '0';
                
                if (REQ = '1') then
                    stato_prossimo <= WAIT_REQ;
                
                elsif (REQ = '0') then
                    stato_prossimo <= COUNT;
                end if;                
                     
            when COUNT =>
                en_count <= '1';
                ACK <= '0';          
                stato_prossimo <= EVAL;                   
                     
            when EVAL =>
                en_count <= '0';
--                if (counter = std_logic_vector(to_unsigned((2**counter'length) - 1, counter'length)))then
                if (counter = std_logic_vector(to_unsigned(0, counter'length)))then
                    stato_prossimo <= AVVIA_SCRITTURA;
                else
                    stato_prossimo <= IDLE;
                end if;
                
            when AVVIA_SCRITTURA =>
                Sel_R <= '1';
                loadC <= '1';
--                stato_prossimo <= WAIT_SCRITTURA;
                stato_prossimo <= IDLE;
                
--            when WAIT_SCRITTURA =>
--                Sel_R <= '1';
--                loadC <= '0';
--                stato_prossimo <= IDLE;            
                
            when OTHERS =>
                stato_prossimo <= IDLE;
                
        end case;       
    end process;            

end Behavioral;

