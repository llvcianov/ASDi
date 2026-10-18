library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all; 

entity MEM is
    Generic (
        N : integer := 64;  -- Numero di locazioni di memoria (modificabile)
        M : integer := 8    -- Numero di bit per locazione di memoria (modificabile)
    );
    Port (
        CLK     : in std_logic;
        Address : in std_logic_vector (integer(ceil(log2(real(N))))-1 downto 0);
        Write   : in std_logic;
        Read    : in std_logic;
        dataIN  : in std_logic_vector (M-1 downto 0);
        dataOUT : out std_logic_vector (M-1 downto 0)
    );
end MEM;

architecture Behavioral of MEM is

    -- Definizione del tipo di memoria con dimensione M-bit per locazione
    type MEMORY_TYPE is array (0 TO N-1) of std_logic_vector(M-1 downto 0);

    -- Inizializzazione della memoria con valori alternati 3 e 7 nelle prime 8 locazioni
    signal MEM : MEMORY_TYPE := (
        0 => std_logic_vector(to_unsigned(3, M)),
        1 => std_logic_vector(to_unsigned(7, M)),
        2 => std_logic_vector(to_unsigned(3, M)),
        3 => std_logic_vector(to_unsigned(7, M)),
        4 => std_logic_vector(to_unsigned(3, M)),
        5 => std_logic_vector(to_unsigned(7, M)),
        6 => std_logic_vector(to_unsigned(3, M)),
        7 => std_logic_vector(to_unsigned(7, M)),
        others => (others => '0')  -- Valore di default
    );

begin

    -- Processo di scrittura
    process (CLK)
    begin
        if rising_edge(CLK) then
            if (Write = '1') then
                MEM(to_integer(unsigned(Address))) <= dataIN;
            end if;
        end if;
    end process;

    -- Processo di lettura
    process (CLK)
    begin
        if rising_edge(CLK) then
            if (Read = '1') then
                dataOUT <= MEM(to_integer(unsigned(Address)));
            end if;
        end if;
    end process;

end Behavioral;
