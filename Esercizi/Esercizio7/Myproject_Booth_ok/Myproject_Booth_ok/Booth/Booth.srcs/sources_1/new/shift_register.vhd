----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.01.2025 19:03:09
-- Design Name: 
-- Module Name: shift_register - Behavioral

----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity shift_register is
  Port ( 
    clk, rst, en_shift, load : in std_logic;
    parallel_in : in std_logic_vector (16 downto 0);
    serial_in : in std_logic;
    parallel_out : out std_logic_vector (16 downto 0)
  );
end shift_register;

architecture Behavioral of shift_register is

    signal temp : STD_LOGIC_VECTOR(16 downto 0);
    
begin
    PROCESS (clk)
    begin
        if(clk'event and clk='1') then
            if(rst='1') then 
                temp <=(others=>'0');
		          
            elsif(load='1') then --caricamento iniziale del moltiplicatore
                temp <= parallel_in;
                
            elsif(en_shift='1') then 							
                temp(15 downto 0) <= temp(16 downto 1);
                temp(16) <= serial_in;
            end if;
        end if; 
    end process;
  
parallel_out <= temp(16 downto 0);

end Behavioral;

