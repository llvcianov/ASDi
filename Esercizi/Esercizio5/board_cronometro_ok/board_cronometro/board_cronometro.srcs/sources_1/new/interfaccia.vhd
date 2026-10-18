
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity interfaccia is
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
end interfaccia;

architecture structural of interfaccia is
 
    component ButtonDebouncer
        generic (                       
            CLK_period: integer := 10;
            btn_noise_time: integer := 10000000 
        );
        Port ( 
            RST : in STD_LOGIC;
            CLK : in STD_LOGIC;
            BTN : in STD_LOGIC;
            CLEARED_BTN : out STD_LOGIC
        );
    end component;

begin
          
    BTN_reset : ButtonDebouncer
        Generic map(                        
            CLK_period => 10,
            btn_noise_time => 10000000 
        )
        Port map( RST => '0',
            CLK => CLK,
            BTN => RST,
            CLEARED_BTN => CLEARED_RESET
        );      
    
    BTN_loadsec : ButtonDebouncer
        Generic map(                        
            CLK_period => 10,
            btn_noise_time => 10000000 
        )
        Port map( RST =>'0',
            CLK => CLK,
            BTN => LOAD_SEC,
            CLEARED_BTN => CLEARED_LOAD_SEC
        ); 
       
    BTN_loadmin : ButtonDebouncer
        Generic map(                        
            CLK_period => 10,
            btn_noise_time => 10000000 
        )
        Port map( RST => '0',
            CLK => CLK,
            BTN => LOAD_MIN,
            CLEARED_BTN => CLEARED_LOAD_MIN
        ); 
       
    BTN_loadhours : ButtonDebouncer
        Generic map(                        
            CLK_period => 10,
            btn_noise_time => 10000000 
        )
        Port map( RST => '0',
            CLK => CLK,
            BTN => LOAD_HOURS,
            CLEARED_BTN => CLEARED_LOAD_HOURS
        ); 
 
end structural;

