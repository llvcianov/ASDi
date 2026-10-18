----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.01.2025 23:13:26
-- Design Name: 
-- Module Name: ContMod2 - 
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

-- In caso di intertempo serve un segnale di enable
entity ContMod2 is
    Port (
        CLK:            in std_logic; --clock 
        RST:            in std_logic; --reset asincrono
        reset_count:    in std_logic; --reset di conteggio
        load:           in std_logic; --segnale di load 
        dataToset:      in std_logic; --data to set
        dataOUT:        out std_logic --uscita di conteggio
     );
end ContMod2;

architecture behavioral of ContMod2 is
    signal Q : std_logic := '0';

begin
    Mod2 : process(CLK, RST, reset_count, load)  
    begin
        if (RST = '1' or reset_count = '1') then
            Q <= '0';
            
        elsif(load = '1') then
            Q <= dataToset;
            
        elsif (falling_edge(CLK)) then
         
            Q <= not Q;                
    
        end if;                              
     
    end process;
    
    dataOUT <= Q; 
                   
end ;









