----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 
-- Design Name: 
-- Module Name: control_unit - archi
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity control_unit is
  Port ( 
    firstButton: in std_logic;
    secondButton : in std_logic;
    loadButton: in std_logic;
    switch: in std_logic_vector(7 DOWNTO 0);
    ctr : in std_logic_vector(5 DOWNTO 0);
    CLK: in std_logic;
    led : out std_logic_vector(3 DOWNTO 0)
  
  );
end control_unit;

ARCHITECTURE arch OF control_unit IS
    COMPONENT rete_16_4 IS
        PORT (
        ar : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        sr : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        yr : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
        );
    END COMPONENT;
signal address: std_logic_vector(15 DOWNTO 0);
signal control: std_logic_vector(5 downto 0);

BEGIN
     net: rete_16_4
        PORT MAP(
        ar => address,
        sr => control,
        yr => led
        );
        
process(CLK)
BEGIN
    if(rising_edge(CLK)) then
        if(firstButton = '1') then
            address(7 downto 0) <= switch;
        end if;
        if(secondButton = '1') then
            address(15 downto 8) <= switch;
        end if;
        if(loadButton = '1') then
            control(1 downto 0) <= ctr(1 downto 0);
            control(5 downto 2) <= ctr(5 downto 2);
        end if;
    end if;
end process;
END ARCHITECTURE;
