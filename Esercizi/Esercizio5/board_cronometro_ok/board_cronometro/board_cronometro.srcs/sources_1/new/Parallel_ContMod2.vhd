
-- versione sincrona
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- In caso di intertempo serve un segnale di enable
entity ContMod2 is
    Port (
        CLK:            in std_logic; --clock 
        RST:            in std_logic; --reset asincrono
        count:          in std_logic;
        reset_count:    in std_logic; --reset di conteggio
        load:           in std_logic; --segnale di load 
        dataToset:      in std_logic; --data to set
        dataOUT:        out std_logic --uscita di conteggio
     );
end ContMod2;

architecture behavioral of ContMod2 is
    signal Q : std_logic := '0';


begin

    Synch : process(CLK, RST)  
    begin
        if (RST = '1') then
            Q <= '0';
            
        elsif (falling_edge(CLK)) then 
           
            if(load = '1') then
                Q <= dataToset;
                
            elsif(reset_count = '1') then 
                Q <= '0';
                
            elsif(count = '1') then
                Q <= not Q;

            end if;
        end if;                                   
    end process;
    
    dataOUT <= Q; 
                   
end ;

