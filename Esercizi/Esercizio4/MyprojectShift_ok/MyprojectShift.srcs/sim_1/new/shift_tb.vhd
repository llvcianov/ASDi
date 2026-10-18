library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register_N_bit_TB is
-- Nessuna porta in un testbench
end shift_register_N_bit_TB;

architecture Behavioral of shift_register_N_bit_TB is

    component shift_register_N_bit is
        Generic (
            N : integer := 8
        );
        Port (
            CLK     : in  STD_LOGIC;
            RST     : in  STD_LOGIC;
            Y       : in  STD_LOGIC;
            S       : in  STD_LOGIC;
            dataIN  : in  STD_LOGIC;
            dataOUT : out STD_LOGIC
        );
    end component;
    
    constant N : integer := 8;

    signal CLK      : STD_LOGIC := '0';
    signal RST      : STD_LOGIC := '0';
    signal Y        : STD_LOGIC := '0';
    signal S        : STD_LOGIC := '0';
    signal dataIN   : STD_LOGIC := '0';
    signal dataOUT  : STD_LOGIC;
    signal stop_the_clock: boolean := false;

begin

    uut: shift_register_N_bit
        Generic map (
            N => N
        )
        Port map (
            CLK     => CLK,
            RST     => RST,
            Y       => Y,
            S       => S,
            dataIN  => dataIN,
            dataOUT => dataOUT
        );

    CLK_process: process
    begin
        wait for 50 ns;
        while not stop_the_clock loop
            CLK <= '0';
            wait for 10 ns;
            CLK <= '1';
            wait for 10 ns;
        end loop;
        wait;
    end process;

    stim_proc: process
    begin
        -- Reset del registro
        RST <= '1';
        wait for 100 ns;
        RST <= '0';

        -- Stimolo: Shift verso sinistra di 1 posizione (Y = 0, S = 0)
        S <= '0';
        Y <= '0';
        dataIN <= '1';
        wait for 20 ns;
        dataIN <= '0';
        wait for 200 ns;

        -- Stimolo: Shift verso destra di 1 posizione (Y = 0, S = 1)
        S <= '1';
        Y <= '0';
        dataIN <= '1';
        wait for 20 ns;
        dataIN <= '0';
        wait for 200 ns;

        -- Stimolo: Shift verso sinistra di 2 posizioni (Y = 1, S = 0)
        S <= '0';
        Y <= '1';
        dataIN <= '1';
        wait for 20 ns;
        dataIN <= '0';
        wait for 120 ns;

        -- Stimolo: Shift verso destra di 2 posizioni (Y = 1, S = 1)
        S <= '1';
        Y <= '1';
        dataIN <= '1';
        wait for 20 ns;
        dataIN <= '0';
        wait for 120 ns;

        -- Fine della simulazione
        stop_the_clock <= true;

        assert false report "Test completato con successo" severity note;

        wait;
    end process;

end Behavioral;
