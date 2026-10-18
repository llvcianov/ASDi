library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all; 

entity ROM_N_M is
    Generic (
        N : integer := 64; -- Numero di locazioni di memoria
        M : integer := 8   -- Larghezza in bit di ogni locazione
    );
    Port (
        CLK     : in std_logic;
        Address : in std_logic_vector (integer(ceil(log2(real(N))))-1 downto 0);
        Read    : in std_logic;
        dataOUT : out std_logic_vector (M-1 downto 0) 
    );
end ROM_N_M;

architecture Behavioral of ROM_N_M is

    -- Definizione di una memoria con i valori da 1 a 8 inizializzati
    type MEMORY_TYPE is array (0 TO N-1) of std_logic_vector(M-1 downto 0);

    -- Inizializzazione della memoria con valori da 1 a 8
    constant ROM : MEMORY_TYPE := (
        0  => std_logic_vector(to_unsigned(1, M)),
        1  => std_logic_vector(to_unsigned(2, M)),
        2  => std_logic_vector(to_unsigned(3, M)),
        3  => std_logic_vector(to_unsigned(4, M)),
        4  => std_logic_vector(to_unsigned(5, M)),
        5  => std_logic_vector(to_unsigned(6, M)),
        6  => std_logic_vector(to_unsigned(7, M)),
        7  => std_logic_vector(to_unsigned(8, M)),
        others => (others => '0') -- Riempimento con zeri per le altre locazioni
    );

begin

    get_data : process (CLK)
    begin
        if rising_edge(CLK) then
            if Read = '1' then                
                dataOUT <= ROM(to_integer(unsigned(Address)));
            end if;
        end if;
    end process get_data;

end Behavioral;
