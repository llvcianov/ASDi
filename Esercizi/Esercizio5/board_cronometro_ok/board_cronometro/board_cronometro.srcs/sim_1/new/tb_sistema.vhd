LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb_sistema IS
END tb_sistema;

ARCHITECTURE behavior OF tb_sistema IS 
    
    -- Component declaration
    COMPONENT sistema
    PORT(
        clk : IN std_logic;
        rst : IN std_logic;
        en_time : IN std_logic;
        load_sec : IN std_logic;
        load_min : IN std_logic;
        load_hours : IN std_logic;
        set : IN std_logic_vector(5 downto 0);
        anodes_out : OUT std_logic_vector(7 downto 0);
        cathodes_out : OUT std_logic_vector(7 downto 0)
    );
    END COMPONENT;
    
    -- Signals
    SIGNAL clk_tb : std_logic := '0';
    SIGNAL rst_tb : std_logic := '0';
    SIGNAL en_time_tb : std_logic := '0';
    SIGNAL load_sec_tb : std_logic := '0';
    SIGNAL load_min_tb : std_logic := '0';
    SIGNAL load_hours_tb : std_logic := '0';
    SIGNAL set_tb : std_logic_vector(5 downto 0) := (others => '0');
    SIGNAL anodes_out_tb : std_logic_vector(7 downto 0);
    SIGNAL cathodes_out_tb : std_logic_vector(7 downto 0);
    
    -- Clock period definition
    CONSTANT clk_period : time := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: sistema 
    PORT MAP (
        clk => clk_tb,
        rst => rst_tb,
        en_time => en_time_tb,
        load_sec => load_sec_tb,
        load_min => load_min_tb,
        load_hours => load_hours_tb,
        set => set_tb,
        anodes_out => anodes_out_tb,
        cathodes_out => cathodes_out_tb
    );

    -- Clock process
    clk_process : PROCESS
    BEGIN
        WHILE NOW < 10 ms LOOP -- Simulazione per 10 ms
            clk_tb <= '0';
            WAIT FOR clk_period / 2;
            clk_tb <= '1';
            WAIT FOR clk_period / 2;
        END LOOP;
        WAIT;
    END PROCESS;

    -- Stimulus process
    stim_proc: PROCESS
    BEGIN      
    
     
        -- Reset iniziale
        rst_tb <= '1';
        WAIT FOR 20 ns;
        rst_tb <= '0';
        WAIT FOR 20 ns;

        -- Avvio del conteggio del tempo
        en_time_tb <= '1';
        WAIT FOR 1500 ns;

        -- Caricamento dei secondi
        set_tb <= "000011"; -- Imposta a 3 secondi
        WAIT FOR 20 ns;
        load_sec_tb <= '1';
        WAIT FOR 10 ns;
        load_sec_tb <= '0';
        WAIT FOR 20 ns;
        
        -- Caricamento dei minuti
        set_tb <= "000101"; -- Imposta a 5 minuti
        WAIT FOR 20 ns;
        load_min_tb <= '1';
        WAIT FOR 10 ns;
        load_min_tb <= '0';
        WAIT FOR 20 ns;
        
        -- Caricamento delle ore
        set_tb <= "000010"; -- Imposta a 2 ore
        WAIT FOR 20 ns;
        load_hours_tb <= '1';
        WAIT FOR 10 ns;
        load_hours_tb <= '0';
        WAIT FOR 20 ns;
        
        WAIT FOR 1500 ns;
        en_time_tb <= '0';
        WAIT FOR 80 ns;
        
        -- Ripetizione delle operazioni di caricamento
        set_tb <= "001111"; -- Imposta a 15 secondi
        WAIT FOR 20 ns;
        load_sec_tb <= '1';
        WAIT FOR 10 ns;
        load_sec_tb <= '0';
        WAIT FOR 20 ns;
        
        set_tb <= "001111"; -- Imposta a 15 minuti
        WAIT FOR 20 ns;
        load_min_tb <= '1';
        WAIT FOR 10 ns;
        load_min_tb <= '0';
        WAIT FOR 20 ns;
        
        set_tb <= "001111"; -- Imposta a 15 ore
        WAIT FOR 20 ns;
        load_hours_tb <= '1';
        WAIT FOR 10 ns;
        load_hours_tb <= '0';
        WAIT FOR 20 ns;
        
        set_tb <= "001100"; -- Imposta a 12 secondi
        WAIT FOR 20 ns;
        load_sec_tb <= '1';
        WAIT FOR 10 ns;
        load_sec_tb <= '0';
        WAIT FOR 20 ns;
        
        set_tb <= "001100"; -- Imposta a 12 minuti
        WAIT FOR 20 ns;
        load_min_tb <= '1';
        WAIT FOR 10 ns;
        load_min_tb <= '0';
        WAIT FOR 20 ns;
        
        set_tb <= "001100"; -- Imposta a 12 ore
        WAIT FOR 20 ns;
        load_hours_tb <= '1';
        WAIT FOR 10 ns;
        load_hours_tb <= '0';
        WAIT FOR 20 ns;
        
        rst_tb <= '1';
        WAIT FOR 20 ns;
        rst_tb <= '0';
        WAIT FOR 20 ns;  
        
        
        set_tb <= "000010"; -- Imposta a 2 ore
        WAIT FOR 20 ns;
        load_hours_tb <= '1';
        WAIT FOR 10 ns;
        load_hours_tb <= '0';
        WAIT FOR 20 ns;     
        
        
        
        
        -- Fine simulazione
        WAIT;
    END PROCESS;

END behavior;
