----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: control_unit - Behavioral
---------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity control_unit is
  Port ( 
    BTNL : in std_logic;
    BTNR : in std_logic;
    A, rst : in std_logic;
    SW1, SW0 : in std_logic;
    Y : out std_logic
  );
end control_unit;

architecture Behavioral of control_unit is
    component ButtonDebouncer 
    generic (                       
        CLK_period: integer := 10;  -- periodo del clock (della board) in nanosecondi
        btn_noise_time: integer := 10000000 -- durata stimata dell'oscillazione del bottone in nanosecondi
                                            -- il valore di default è 10 millisecondi
    );
    Port ( RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           BTN : in STD_LOGIC;
           CLEARED_BTN : out STD_LOGIC);
    end component;
    
    component riconoscitore_board 
    Port (
        i, rst, m   : in std_logic; --ingresso, reset, modo 
        A           : in std_logic; --clock
        Bi, Bm      : in std_logic;
        y           : out std_logic --uscita
    );
    end component;
    
    signal temp_cleared_btn0 : std_logic;
    signal temp_cleared_btn1 : std_logic;
begin
    BTN0 : ButtonDebouncer 
    generic map(                       
        CLK_period => 10,  -- periodo del clock (della board) in nanosecondi
        btn_noise_time => 10000000 -- durata stimata dell'oscillazione del bottone in nanosecondi
                                            -- il valore di default è 10 millisecondi
    )
    Port map( 
           RST => RST,
           CLK => A,
           BTN => BTNL,
           CLEARED_BTN => TEMP_CLEARED_BTN0
           );

    BTN1 : ButtonDebouncer 
    generic map(                       
        CLK_period => 10,  -- periodo del clock (della board) in nanosecondi
        btn_noise_time => 10000000 -- durata stimata dell'oscillazione del bottone in nanosecondi
                                            -- il valore di default è 10 millisecondi
    )
    Port map( 
           RST => RST,
           CLK => A,
           BTN => BTNR,
           CLEARED_BTN => TEMP_CLEARED_BTN1
           );
    R : riconoscitore_board 
    Port map(
        i   => SW0, 
        rst => rst,
        m   => SW1,
        Bi => TEMP_CLEARED_BTN0,
        Bm => TEMP_CLEARED_BTN1,
        A   => A,
        y   => Y
    );

end Behavioral;
