
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all; 

entity ContMod_N is
    Generic (
        N : integer := 64 -- Modulo del contatore
    );
    Port (
        CLK:         in std_logic;  -- clock 
        RST:         in std_logic;  -- reset asincrono
        en_count:    in std_logic; --segnale di conteggio
        dataOUT:     out std_logic_vector(integer(ceil(log2(real(N))))-1 downto 0) -- uscita di conteggio
    );
end ContMod_N;

architecture Behavioral of ContMod_N is
    signal Q : integer range 0 to N-1 := 0;

begin
    Counter : process(CLK, RST)
    begin
        if (RST = '1') then
            Q <= 0;
        elsif (rising_edge(CLK)) then
            if (en_count = '1') then
                Q <= Q + 1;
                if(Q = N - 1) then
                    Q <= 0;
                end if;
            end if;
        end if;
    end process;
    
    dataOUT <= std_logic_vector(to_unsigned(Q, integer(ceil(log2(real(N))))));
end Behavioral;

