----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.01.2025 11:26:21
-- Design Name: 
-- Module Name: mux_2_1 - dataflow
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity mux_2_1 is
    Port ( 
        dataIN0 : in std_logic;
        dataIN1 : in std_logic;
        s       : in std_logic;
        dataOUT : out std_logic
    );
end mux_2_1;

architecture dataflow of mux_2_1 is
    begin
        dataOUT <= ((dataIN0 AND (NOT s)) OR (dataIN1 AND s));
end dataflow;
