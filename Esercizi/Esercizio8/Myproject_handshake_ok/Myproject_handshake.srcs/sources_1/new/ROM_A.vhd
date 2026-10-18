library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all; 

entity ROM is
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
end ROM;

architecture Behavioral of ROM is

    -- Definizione di una memoria generica con N locazioni di M bit
    type MEMORY_TYPE is array (0 TO N-1) of std_logic_vector(M-1 downto 0);

    -- Inizializzazione della memoria alternando i valori 20 (00010100) e 50 (00110010)
    constant ROM : MEMORY_TYPE := (
        0  => std_logic_vector(to_unsigned(20, M)),
        1  => std_logic_vector(to_unsigned(50, M)),
        2  => std_logic_vector(to_unsigned(20, M)),
        3  => std_logic_vector(to_unsigned(50, M)),
        4  => std_logic_vector(to_unsigned(20, M)),
        5  => std_logic_vector(to_unsigned(50, M)),
        6  => std_logic_vector(to_unsigned(20, M)),
        7  => std_logic_vector(to_unsigned(50, M)),
        others => std_logic_vector(to_unsigned(20 + 30 * (to_integer(unsigned(Address)) mod 2), M))
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
