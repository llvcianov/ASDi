----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.01.2025 15:16:17
-- Design Name: 
-- Module Name: booth - Structural
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity booth is
  Port ( 
    clk, rst, start : in std_logic;
    X,Y : in std_logic_vector(7 downto 0);
    P : out std_logic_vector (15 downto 0);
    stop: out std_logic
  );
end booth;

architecture Structural of booth is
    component unita_controllo is
    Port( 
        clk, rst, start : in std_logic;
        LSB_Q : in std_logic_vector (1 downto 0); 
        counter : in std_logic_vector (3 downto 0);                   
        en_count, en_shift, en_sub, loadM, loadAQ, selAQ : out std_logic;
        stop : out std_logic
     );
     end component;
     
    component unita_operativa is
    Port ( 
        clk, rst : in std_logic;
        X,Y : in std_logic_vector(7 downto 0);
        en_count, en_shift, en_sub, loadM, loadAQ, selAQ: in std_logic;
        counter : out std_logic_vector (3 downto 0);
        P : out std_logic_vector (16 downto 0)
    );
    end component;
    
    signal temp_LSBQ : std_logic_vector(1 downto 0) := (others => '0');
    signal temp_counter : std_logic_vector(3 downto 0) := (others => '0');
    signal temp_en_count : std_logic := '0';
    signal temp_en_shift : std_logic := '0';
    signal temp_en_sub : std_logic := '0';
    signal temp_loadM : std_logic := '0';
    signal temp_loadAQ : std_logic := '0';
    signal temp_selAQ : std_logic := '0';
    signal temp_P : std_logic_vector(16 downto 0) := (others => '0');
    
    begin
    
    temp_LSBQ <= temp_P(1 downto 0);
    P <= temp_P (16 downto 1);
    
    UC : unita_controllo 
        Port map (
           clk => clk,
           rst => rst, 
           start => start, 
           LSB_Q => temp_LSBQ,
           counter => temp_counter,
           en_count => temp_en_count,
           en_shift => temp_en_shift,
           en_sub => temp_en_sub,
           loadM => temp_loadM, 
           loadAQ => temp_loadAQ,
           selAQ => temp_selAQ,
           stop => stop
        );
     
     UO : unita_operativa
        Port map( 
           clk => clk, 
           rst => rst,        
           X => X,
           Y => Y,
           en_count => temp_en_count,
           en_shift => temp_en_shift,
           en_sub => temp_en_sub,
           loadM => temp_loadM, 
           loadAQ => temp_loadAQ,
           selAQ => temp_selAQ,
           counter => temp_counter,           
           P => temp_P
    );

end Structural;
