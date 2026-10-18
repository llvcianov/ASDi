
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity control_unit is
  Port ( 
    A0, A1 , A2, A3 : in std_logic_vector(5 downto 0);
    enable0, enable1, enable2, enable3 : in std_logic;
    B0, B1, B2, B3 : out std_logic_vector(1 downto 0);
    control_vector : out std_logic_vector (7 downto 0)   
  );
end control_unit;

architecture Behavioural of control_unit is

  signal control_SW0 : std_logic_vector(1 downto 0);
  signal control_SW1 : std_logic_vector(1 downto 0);
  signal control_SW2 : std_logic_vector(1 downto 0);
  signal control_SW3 : std_logic_vector(1 downto 0);
  signal dest_nodo0 : std_logic_vector(1 downto 0) := (others => 'U');
  signal dest_nodo1 : std_logic_vector(1 downto 0) := (others => 'U');
  signal dest_nodo2 : std_logic_vector(1 downto 0) := (others => 'U');
  signal dest_nodo3 : std_logic_vector(1 downto 0) := (others => 'U');
  
  
begin

  control_vector <= control_SW0 & control_SW1 & control_SW2 & control_SW3;

  control_stadio1: process (A0, A1, A2, A3, enable0, enable1, enable2, enable3)
  begin
  
    -- Controllo SW0 
    if (enable0 = '1' and enable2 = '0') then --passa A0
        control_SW0 <= A0(5) & A0(1);
        B0 <= A0(3 downto 2);
        --aggiorno destinazioni
        dest_nodo0 <= A0(1 downto 0); 
        dest_nodo2 <= "--";

    elsif ((enable0 = '0' or enable0 = '1') and enable2 = '1') then --passa A2
        control_SW0 <= A2(5) & A2(1);
        B2 <= A2(3 downto 2); 
        --aggiorno destinazioni
        dest_nodo2 <= A2(1 downto 0);
        dest_nodo0 <= "--";
    
    end if;

    -- Controllo SW1
    if (enable1 = '1' and enable3 = '0') then --passa A1
        control_SW1 <= A1(5) & A1(1);
        B1 <= A1(3 downto 2);
        --aggiorno destinazioni
        dest_nodo1 <= A1(1 downto 0); 
        dest_nodo3 <= "--";

    elsif ((enable1 = '0' or enable1 = '1') and enable3 = '1') then --passa A3
        control_SW1 <= A3(5) & A3(1);
        B3 <= A3(3 downto 2);
        --aggiorno destinazioni
        dest_nodo1 <= "--";
        dest_nodo3 <= A3(1 downto 0);    
           
    end if;   
  end process;
  
  

  control_stadio2: process (dest_nodo0, dest_nodo1, dest_nodo2, dest_nodo3, A3)
  begin
  
  
      --controllo SW2
    if (dest_nodo3 = "00" or dest_nodo3 = "01") then
    
        control_SW2 <= A3(4) & A3(0);-- passa A3
        
    elsif ((dest_nodo3 /= "00" and dest_nodo3 /= "01") and 
           (dest_nodo2 = "00" or dest_nodo2 = "01")) then 
                   
        control_SW2 <= A2(4) & A2(0);-- passa A2
        
    elsif ((dest_nodo3 = "--") and 
           (dest_nodo2 /= "00" or dest_nodo2 = "01") and 
           (dest_nodo1 = "00" or dest_nodo1 = "01")) then  
           
        control_SW2 <= A1(4) & A1(0);-- passa A1
        
    elsif ((dest_nodo3 /= "00" or dest_nodo2 = "01") and 
           (dest_nodo2 = "--") and 
           (dest_nodo1 /= "00" or dest_nodo1 /= "01")and
           (dest_nodo0 = "00" or dest_nodo0 = "01"))then  
           
        control_SW2 <= A0(4) & A0(0);-- passa A0    
    end if;
  
  

    --controllo SW3
    if (dest_nodo3 = "10" or dest_nodo3 = "11") then
    
        control_SW3 <= A3(4) & A3(0);-- passa A3
        
    elsif ((dest_nodo3 /= "10" and dest_nodo3 /= "11") and 
           (dest_nodo2 = "10" or dest_nodo2 = "11")) then 
                   
        control_SW3 <= A2(4) & A2(0);-- passa A2
        
    elsif ((dest_nodo3 = "--") and 
           (dest_nodo2 /= "10" or dest_nodo2 = "11") and 
           (dest_nodo1 = "10" or dest_nodo1 = "11")) then  
           
        control_SW3 <= A1(4) & A1(0);-- passa A1
        
    elsif ((dest_nodo3 /= "10" or dest_nodo2 = "11") and 
           (dest_nodo2 = "--") and 
           (dest_nodo1 /= "10" or dest_nodo1 /= "11") and
           (dest_nodo0 = "10" or dest_nodo0 = "11"))then  
           
        control_SW3 <= A0(4) & A0(0);-- passa A0    
    end if;
    
    
end process;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
     




end Behavioural;
