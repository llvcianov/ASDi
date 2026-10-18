

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real.all;
use IEEE.NUMERIC_STD.ALL;

entity PC is
    Generic (
        N : integer := 64 -- Numero di locazioni di memoria
    );
    Port (
        CLK:        in std_logic;
        RST:        in std_logic;
        Start:      in std_logic;
        counter:    in std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0);
        Read:       out std_logic;
        Write:      out std_logic;
        en_count:   out std_logic      
    );
end PC;


-- modellato come automa di Moore
architecture Behavioral of PC is

    type stato is (Idle, ReadMem, WaitMem, WriteMem, Count, Eval);
    signal stato_corrente : stato := idle;
    signal stato_prossimo : stato := stato_corrente;
    
    begin
        updateStatus: process (stato_corrente, start, counter) 
        begin  
            Case stato_corrente is                 
                when Idle =>
                    en_count <= '0';
                    Read <= '0';
                    Write <= '0';               
                    
                    if (start = '1') then
                        stato_prossimo <= ReadMem;
                    else 
                        stato_prossimo <= idle;
                    end if;
                
                when ReadMem =>
                    Read <= '1';
                    stato_prossimo <= WaitMem;
                            
                when WaitMem =>
                    Read <= '0';
                    stato_prossimo <= WriteMem ;
                        
                when WriteMem =>
                    Write <= '1';
                    stato_prossimo <= Count;

                when Count =>
                    Write <= '0';
                    en_count <= '1';
                    stato_prossimo <= Eval;
                    
                when Eval =>
                    en_count <= '0';
                    if (counter = std_logic_vector(to_unsigned(0, counter'length)))then
                        stato_prossimo <= idle;
                    else
                        stato_prossimo <= ReadMem;
                end if;
                        
                when others =>
                    stato_prossimo <= Idle;                        
            end case;
        end process;

        mem : process (CLK, RST)
        begin
            if (RST = '1') then
	           stato_corrente <= Idle;       

            elsif (rising_edge(CLK)) then
                stato_corrente <= stato_prossimo;
            end if;
        end process;        
            
end;


        
        
        