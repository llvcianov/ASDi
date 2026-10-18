library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity testbench_sistema is
end testbench_sistema;

architecture tb of testbench_sistema is

    constant CLK_PERIOD : time := 10 ns; -- Periodo del clock
    signal CLK_A   : std_logic := '0';
    signal CLK_B   : std_logic := '0';
    signal RST   : std_logic := '0';
    signal Start : std_logic := '0';
    signal stop  : std_logic := '0';
    
    -- Instanza del UUT (Unit Under Test)
    component sistema
        Generic (
            N : integer := 8;
            M : integer := 4
        );
        Port (
            CLK_A   : in std_logic;
            CLK_B   : in std_logic;
            RST   : in std_logic;
            Start : in std_logic;
            stop  : out std_logic
        );
    end component;
    
begin
    
    -- Instanza del sistema
    UUT: sistema
        generic map (
            N => 8,
            M => 4
        )
        port map (
            CLK_A   => CLK_A,
            CLK_B   => CLK_B,
            RST   => RST,
            Start => Start,
            stop  => stop
        );
    
    -- Processo per generare il clock
    process
    begin
        while now < 3000 ns loop -- Simulazione per 1000 ns
            CLK_A <= '0';
            wait for CLK_PERIOD/8;
            CLK_A <= '1';
            wait for CLK_PERIOD/8;
        end loop;
        wait;
    end process;
    
    process
    begin
        while now < 3000 ns loop -- Simulazione per 1000 ns
            CLK_B <= '0';
            wait for CLK_PERIOD/2;
            CLK_B <= '1';
            wait for CLK_PERIOD/2;
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
