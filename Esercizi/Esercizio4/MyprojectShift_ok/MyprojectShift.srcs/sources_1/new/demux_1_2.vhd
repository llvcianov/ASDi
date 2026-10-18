----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.01.2025 17:34:09
-- Design Name: 
-- Module Name: demux_1_2 - Dataflow
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity demux_1_2 is
    Port (
        dataIN  : in std_logic;
        s       : in std_logic;
        dataOUT0: out std_logic;
        dataOUT1: out std_logic
    );
end demux_1_2;

architecture Dataflow of demux_1_2 is
begin

    dataOUT0 <= dataIN and (not s); 
    dataOUT1 <= dataIN and s;

end Dataflow;
