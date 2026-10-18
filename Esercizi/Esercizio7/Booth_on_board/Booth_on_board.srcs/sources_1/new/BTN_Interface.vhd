
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BTN_Interface is
    Port( 
        clk : in std_logic;
        Input_rst : in std_logic;
        Input_start: in std_logic;
        Input_count: in std_logic;
        cleared_rst : out std_logic;
        cleared_start: out std_logic;
        cleared_count: out std_logic       
    );
end BTN_Interface;

architecture structural of BTN_Interface is
 
    component ButtonDebouncer
        generic (                       
            CLK_period: integer := 10;
            btn_noise_time: integer := 10000000 
        );
        Port ( 
            RST : in std_logic;
            CLK : in std_logic;
            BTN : in std_logic;
            CLEARED_BTN : out std_logic
        );
    end component;

begin
          
    BTN_reset : ButtonDebouncer
        Generic map(                        
            CLK_period => 10,
            btn_noise_time => 10000000 
        )
        Port map( RST => '0',
            CLK => clk,
            BTN => Input_rst,
            CLEARED_BTN => cleared_rst
        );
        
    BTN_start : ButtonDebouncer
        Generic map(                        
            CLK_period => 10,
            btn_noise_time => 10000000 
        )
        Port map( RST => '0',
            CLK => clk,
            BTN => Input_start,
            CLEARED_BTN => cleared_start
        );   
        
    BTN_visual : ButtonDebouncer
        Generic map(                        
            CLK_period => 10,
            btn_noise_time => 10000000 
        )
        Port map( RST => '0',
            CLK => clk,
            BTN => Input_count,
            CLEARED_BTN => cleared_count
        );  
 
end structural;

