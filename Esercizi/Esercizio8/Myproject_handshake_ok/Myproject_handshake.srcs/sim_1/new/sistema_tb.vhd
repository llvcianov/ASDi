library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity testbench_sistema is
end testbench_sistema;

architecture tb of testbench_sistema is

    constant CLK_PERIOD : time := 10 ns; -- Periodo del clock
    signal CLK   : std_logic := '0';
    signal RST   : std_logic := '0';
    signal Start : std_logic := '0';
    signal stop  : std_logic := '0';
    
    -- Instanza del DUT (Device Under Test)
    component sistema
        Generic (
            N : integer := 8;
            M : integer := 4
        );
        Port (
            CLK   : in std_logic;
            RST   : in std_logic;
            Start : in std_logic;
            stop  : out std_logic
        );
    end component;
    
begin
    
    -- Instanza del sistema
    DUT: sistema
        generic map (
            N => 8,
            M => 4
        )
        port map (
            CLK   => CLK,
            RST   => RST,
            Start => Start,
            stop  => stop
        );
    
    -- Processo per generare il clock
    process
    begin
        while now < 3000 ns loop -- Simulazione per 1000 ns
            CLK <= '0';
            wait for CLK_PERIOD / 2;
            CLK <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;
    
    -- Processo per generare i segnali di test
    process
    begin
        -- Reset iniziale
        RST <= '1';
        wait for 20 ns;
        RST <= '0';
        wait for 20 ns;
        
        -- Attivazione del segnale Start
        Start <= '1';
        wait for 30 ns;
        Start <= '0';
        
        -- Attendere il completamento dell'operazione
        wait for 3000 ns;
        
        -- Fine simulazione
        wait;
    end process;
    
end tb;
