
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity System_TB is
end System_TB;

architecture Behavioral of System_TB is
    -- Segnali per il testbench
    signal CLK : std_logic := '0';
    signal RST : std_logic := '0';
    signal Start_system : std_logic := '0';
    signal Read_system : std_logic := '0';
    signal led : std_logic_vector (3 downto 0) := (others => '0');

    -- Costante per il periodo del clock
    constant CLK_PERIOD : time := 10 ns;

    -- Istanza del sistema da testare
    component PO_PC_system is
        Generic (
            N : integer := 64 -- Numero di locazioni di memoria (modificabile)
        );
        Port (
            CLK:            in std_logic;
            RST:            in std_logic;
            Start_system:   in std_logic;
            Read_system:    in std_logic;
            led :           out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

begin
    -- Istanza del sistema
    UUT: PO_PC_system
        Generic Map (
            N => 16 -- Valore di default per il test
        )
        Port Map (
            CLK => CLK,
            RST => RST,
            Start_system => Start_system,
            Read_system => Read_system,
            led => led
        );

    -- Generazione del clock
    CLK_process: process
    begin
        CLK <= '0';
        wait for CLK_PERIOD / 2;
        CLK <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    -- Processo di test
    test_process: process
    begin
        
        RST <= '1'; -- Attiva il reset
        wait for CLK_PERIOD * 2;

        -- Disattiva il reset e avvia il sistema
        RST <= '0';
        Start_system <= '1';
        wait for 10 ns;
        Start_system <= '0';
        
        wait for 20 ns;
        
        Read_system <= '1';
        wait for 10 ns;
        Read_system <= '0';
        wait for 80 ns;
        
        Read_system <= '1';
        wait for 10 ns;
        Read_system <= '0';
        wait for 80 ns;
        
        Read_system <= '1';
        wait for 10 ns;
        Read_system <= '0';
        wait for 80 ns;
        
        Read_system <= '1';
        wait for 10 ns;
        Read_system <= '0';
        wait for 80 ns;
        
        Read_system <= '1';
        wait for 10 ns;
        Read_system <= '0';
        wait for 80 ns;

        
        
   

        -- Fine del test
        wait;
    end process;

end Behavioral;
