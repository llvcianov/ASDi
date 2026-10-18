
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity crono_on_board is
    Port( 
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        start_stop : in STD_LOGIC;
        load_sec : in STD_LOGIC;
        load_min : in STD_LOGIC;
        load_hours : in STD_LOGIC;
        set : in STD_LOGIC_VECTOR(5 downto 0);     
        anodes_out : out STD_LOGIC_VECTOR (7 downto 0);
        cathodes_out : out STD_LOGIC_VECTOR(7 downto 0)
        );
end crono_on_board;

architecture structural of crono_on_board is

    component sistema is
        Port( 
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            en_time : in STD_LOGIC;
            load_sec : in STD_LOGIC;
            load_min : in STD_LOGIC;
            load_hours : in STD_LOGIC;
            set : in STD_LOGIC_VECTOR(5 downto 0);     
            anodes_out : out STD_LOGIC_VECTOR (7 downto 0);
            cathodes_out : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;
    
    component interfaccia is
        Port( 
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            load_sec : in STD_LOGIC;
            load_min : in STD_LOGIC;
            load_hours : in STD_LOGIC;
            cleared_reset : out STD_LOGIC;
            cleared_load_sec : out STD_LOGIC;
            cleared_load_min : out STD_LOGIC;
            cleared_load_hours : out STD_LOGIC
        );
    end component;
     
    SIGNAL temp_cleared_reset : STD_LOGIC;
    SIGNAL temp_cleared_load_sec : STD_LOGIC;
    SIGNAL temp_cleared_load_min : STD_LOGIC;
    SIGNAL temp_cleared_load_hours : STD_LOGIC;
    
begin
   
     BTN_interface: interfaccia 
        Port map( 
            clk => clk,
            rst => rst,
            load_sec => load_sec, 
            load_min => load_min, 
            load_hours => load_hours, 
            cleared_reset => temp_cleared_reset, 
            cleared_load_sec => temp_cleared_load_sec,
            cleared_load_min => temp_cleared_load_min,
            cleared_load_hours => temp_cleared_load_hours
        );   
     
    crono_system : sistema
        Port map( 
            clk => clk,
            rst => temp_cleared_reset, 
            en_time => start_stop,
            load_sec => temp_cleared_load_sec,
            load_min => temp_cleared_load_min,
            load_hours => temp_cleared_load_hours,
            set => set,  
            anodes_out => anodes_out,
            cathodes_out => cathodes_out
        );
             
end structural;

