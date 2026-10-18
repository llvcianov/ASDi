

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ContMod24 is
    Port (
        CLK:        in std_logic; --clock
        RST:        in std_logic; --reset
        count:      in std_logic;
        load:       in std_logic; --segnale di set
        dataToset:  in std_logic_vector(4 downto 0); --bit da settare
        dataOUT:    out std_logic_vector(4 downto 0) --uscita conteggio 
     );        
end ContMod24;


architecture structural of ContMod24 is
    
    component ContMod2 is 
        port(
            CLK:        in std_logic;
            RST:        in std_logic;
            count:      in std_logic;
            reset_count:in std_logic;
            load:       in std_logic;
            dataToset:  in std_logic;
            dataOUT:    out std_logic               
        );
    end component ContMod2;
    
    signal ContOUT: std_logic_vector(4 downto 0); --appoggio uscita
    signal ContIN:  std_logic_vector(4 downto 0); --appoggio entrata
    signal reset_temp: std_logic;  --appoggio reset per realizzare mod.24
       
begin

    --genero i contatori
    Parallel_ContMod2: for i in 0 to 4 generate
        C: ContMod2
            port map(
                CLK         => CLK,
                RST         => RST,
                count       => ContIN(i),
                reset_count => reset_temp,
                load        => load,
                dataToset   => dataToset(i), 
                dataOUT     => ContOUT(i) 
            );
    end generate Parallel_ContMod2;
                    
    -- collego i contatori in parallelo
    ContIN(0) <= count;
    ContIN(1) <= ContOUT(0) and count;  --entrata del 2°
    ContIN(2) <= ContOUT(1) and ContOUT(0) and count;  --entrata del 3°  
    ContIN(3) <= ContOUT(2) and ContOUT(1) and ContOUT(0) and count; --entrata del 4°        
    ContIN(4) <= ContOUT(3) and ContOUT(2) and ContOUT(1) and ContOUT(0) and count; --entrata del 5°
        
    --reset conteggio asincrono alzo il segnale quando conta 23 
    reset_temp <= (ContOUT(4) and not ContOUT(3) and ContOUT(2) and
                    ContOUT(1) and ContOUT(0)) and count;
    
    -- collego l'uscita del modulo 24 concatenando le singole uscite
    dataOUT <= ContOUT(4) & ContOUT(3) & ContOUT(2) & ContOUT(1) & ContOUT(0);
    
end ;


