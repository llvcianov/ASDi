----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.01.2025 17:13:43
-- Design Name: 
-- Module Name: full_adder - Behavioral
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

entity full_adder is
  Port ( 
    op1, op2 : in std_logic;
    cin : in std_logic;
    cout, s : out std_logic
  );
end full_adder;

architecture dataflow of full_adder is
begin
    s <= op1 XOR op2 XOR cin;
    cout <= (op1 AND op2) OR (cin AND (op1 XOR op2));
end dataflow;
