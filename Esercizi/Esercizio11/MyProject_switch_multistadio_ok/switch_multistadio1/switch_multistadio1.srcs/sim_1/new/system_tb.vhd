library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 use IEEE.NUMERIC_STD.ALL;

entity system_tb is
end system_tb;

architecture Behavioral of system_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component system
        Port ( 
            A0, A1, A2, A3 : in std_logic_vector(5 downto 0);
            enable0, enable1, enable2, enable3 : in std_logic;
            B0, B1, B2, B3 : out std_logic_vector(1 downto 0)
        );
    end component;
    
    -- Signals for testbench
    signal A0, A1, A2, A3 : std_logic_vector(5 downto 0) := (others => '0');
    signal enable0, enable1, enable2, enable3 : std_logic := '0';
    signal B0, B1, B2, B3 : std_logic_vector(1 downto 0);
    
    -- Clock and Reset
    signal clk : std_logic := '0';
    constant clk_period : time := 10 ns;

begin
    
    -- Instantiate the Unit Under Test (UUT)
    uut: system
        Port map (
            A0 => A0, A1 => A1, A2 => A2, A3 => A3,
            enable0 => enable0, enable1 => enable1, enable2 => enable2, enable3 => enable3,
            B0 => B0, B1 => B1, B2 => B2, B3 => B3
        );
    
    -- Clock process definition
    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end loop;
    end process;
    
    -- Stimulus Process
    stim_proc: process
    begin        
        
        A0 <= "001101"; A1 <= "011110"; A2 <= "101110"; A3 <= "111001";
        enable0 <= '1'; enable1 <= '0'; enable2 <= '0'; enable3 <= '0';
        wait for 100 ns;
        
        enable0 <= '1'; enable1 <= '0'; enable2 <= '0'; enable3 <= '1';
        wait for 100 ns;
        
        enable0 <= '1'; enable1 <= '0'; enable2 <= '1'; enable3 <= '1';
        wait for 100 ns;
        
        
        
        -- Finish Simulation
        wait;
    end process;

end Behavioral;
