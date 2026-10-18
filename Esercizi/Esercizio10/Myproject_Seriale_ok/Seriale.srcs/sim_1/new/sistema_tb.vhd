library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sistema_tb is
end sistema_tb;

architecture behavioral of sistema_tb is
    -- Dichiarazione del DUT (Device Under Test)
    component sistema
        Generic (
            N : integer := 16;
            M : integer := 8
        );
        Port (
            CLK:    in std_logic;
            RST:    in std_logic;
            Start:  in std_logic;
            stop:   out std_logic
        );
    end component;

    -- Segnali di test
    signal CLK_tb   : std_logic := '0';
    signal RST_tb   : std_logic := '1';
    signal Start_tb : std_logic := '0';
    signal Stop_tb  : std_logic;

    -- Parametri temporali
    constant CLK_PERIOD : time := 20 ns;  -- Clock da 50 MHz

begin
    -- Istanza del sistema da testare
    DUT: sistema
        generic map (
            N => 8,
            M => 8
        )
        port map (
            CLK => CLK_tb,
            RST => RST_tb,
            Start => Start_tb,
            stop => Stop_tb
        );

    -- Processo per generare il clock
    process
    begin
        while now < 11176000 ns loop  -- Simuliamo per 11.176.000 ns
            CLK_tb <= '0';
            wait for CLK_PERIOD / 2;
            CLK_tb <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    -- Processo per stimolare i segnali di ingresso
    process
    begin
        -- Fase di reset
        RST_tb <= '1';
        wait for 20 ns;  -- Aspettiamo 20 ns
        RST_tb <= '0';

        -- Avvio della comunicazione
        wait for 30 ns;
        Start_tb <= '1';
        wait for 20 ns;
        Start_tb <= '0';

        -- Aspettiamo per osservare la comunicazione tra i nodi
        wait for 200 ns;

        -- Fine della simulazione
        report "Test completato" severity note;
        wait;
    end process;
    
end behavioral;
