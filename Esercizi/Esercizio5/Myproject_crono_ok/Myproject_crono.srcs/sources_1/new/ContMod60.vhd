----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.01.2025 14:48:17
-- Design Name: 
-- Module Name: ContMod60 - 
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

entity ContMod60 is
    Port (
        CLK:        in std_logic; --clock 
        RST:        in std_logic; --reset asincrono
        load:       in std_logic; --segnale di load 
        dataToset:  in std_logic_vector(5 downto 0); --bit da settare
        dataOUT:    out std_logic_vector(5 downto 0); --uscita conteggio 
        Umax:       out std_logic --abilitazione prossimo contatore
     );        
end ContMod60;


architecture structural of ContMod60 is
    
    component ContMod2 is 
        port(
            CLK:        in std_logic;
            RST:        in std_logic;
            reset_count:in std_logic; 
            load:       in std_logic;
            dataToset:  in std_logic;
            dataOUT:    out std_logic               
        );
    end component ContMod2;
    
    signal ContOUT: std_logic_vector(5 downto 0); --appoggio uscita
    signal ContIN:  std_logic_vector(5 downto 0); --appoggio entrata
    signal reset_temp: std_logic;  --appoggio reset per realizzare mod.60
       
begin

    --genero i contatori
    Parallel_ContMod2: for i in 0 to 5 generate
        C: ContMod2
            port map(
                CLK         => ContIN(i),
                RST         => RST,
                reset_count => reset_temp,
                load        => load,
                dataToset   => dataToset(i), 
                dataOUT     => ContOUT(i) 
            );
    end generate Parallel_ContMod2;
                                              
    -- collego i contatori in parallelo
    ContIN(0) <= CLK; --entrata del 1°
    ContIN(1) <= ContOUT(0) and CLK;  --entrata del 2°
    ContIN(2) <= ContOUT(1) and ContOUT(0) and CLK;  --entrata del 3°
    ContIN(3) <= ContOUT(2) and ContOUT(1) and ContOUT(0) and CLK; --entrata del 4°
    ContIN(4) <= ContOUT(3) and ContOUT(2) and ContOUT(1) and ContOUT(0) and CLK; --entrata del 5°
    ContIN(5) <= ContOUT(4) and ContOUT(3) and ContOUT(2) and ContOUT(1) and ContOUT(0) and CLK; --entrata del 6°   
      
     --reset conteggio asincrono alzo il segnale quando conta 60  
    reset_temp <= (ContOUT(5) and ContOUT(4) and ContOUT(3) and ContOUT(2)
                    and not ContOUT(1) and not ContOUT(0));
                 
    --quando conta 59 attivo il conteggio del prossimo orologio
    Umax <= (ContOUT(5) and ContOUT(4) and ContOUT(3) and not ContOUT(2)
                    and ContOUT(1) and ContOUT(0)); 
   
    -- collego l'uscita 
    dataOUT <= ContOUT;
                                   
end ;



