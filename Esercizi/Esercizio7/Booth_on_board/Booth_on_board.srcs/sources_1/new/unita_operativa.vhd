
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unita_operativa is
    Port ( 
        clk, rst : in std_logic;
        X,Y : in std_logic_vector(7 downto 0);
        count, en_shift, en_sub, loadM, loadAQ, selAQ: in std_logic;
        counter : out std_logic_vector (3 downto 0);
        P : out std_logic_vector (16 downto 0)
    );
end unita_operativa;

architecture Structural of unita_operativa is
   --componenti
    component shift_register is
        Port ( 
            clk, rst, en_shift, load : in std_logic;
            parallel_in : in std_logic_vector (16 downto 0);
            serial_in : in std_logic :='0';
            parallel_out : out std_logic_vector (16 downto 0)
            );
    end component;
  
    component cont_8 is
        Port (
            clk, rst : in std_logic;
            en_cont : in std_logic;
            counter : out std_logic_vector (3 downto 0)
        );
    end component;
  
    component M is
        Port ( 
            clk, rst, load : in std_logic;
            data_in : in std_logic_vector(7 downto 0);
            data_out : out std_logic_vector(7 downto 0)
            );  
    end component;
  
    component add_sub is
        Port ( 
            x , y : in std_logic_vector(7 downto 0);
            en_sub : in std_logic;
            cout : out std_logic;            
            z: out std_logic_vector (7 downto 0)
        );  
    end component;
    
	component mux_21 is
	generic (width : integer range 0 to 32 := 8);
	   port( 
            x0, x1: in std_logic_vector(width-1 downto 0); 
            s: in std_logic;
            y: out std_logic_vector(width-1 downto 0));
	end component;
  
  --signals
  signal temp_M_out : std_logic_vector (7 downto 0) := (others => '0');
  signal temp_add_sub_sum: std_logic_vector(7 downto 0);  
  signal temp_add_sub_riporto : std_logic := '0';  
  signal AQ_init : std_logic_vector (16 downto 0) := (others => '0');
  signal AQ_sum_in: std_logic_vector (16 downto 0) := (others => '0');
  signal temp_AQ_in : std_logic_vector (16 downto 0) := (others => '0');
  signal temp_AQ_out: std_logic_vector (16 downto 0) := (others => '0');
  


  signal op1 : std_logic_vector (8 downto 0) := (X & '0');
  
begin

    AQ_init <= "00000000" & X & '0';
    AQ_sum_in <= temp_add_sub_sum & temp_AQ_out(8 downto 0);
    P <= temp_AQ_out; 

    --COUNTER
    ContMod8 : cont_8 
        Port map(
            clk => clk, 
            rst => rst,
            en_cont => count,
            counter => counter
        );
    
    --REGISTRO M
    RegM : M 
        Port map( 
            clk => clk, 
            rst => rst, 
            load => loadM,
            data_in => Y,
            data_out => temp_M_out
        ); 
    
    --ADDER - SUBTRACTER
    Adder : add_sub
        Port map( 
            x => temp_AQ_out(16 downto 9), 
            y => temp_M_out,
            en_sub => en_sub,
            z => temp_add_sub_sum, 
            cout => temp_add_sub_riporto      
        );
        
    Mux : mux_21
        generic map(
            width => 17
        )
        port map(
            x0 => AQ_init,
            x1 => AQ_sum_in,
            s => selAQ,
            y => temp_AQ_in
        );              
    
    --REGISTRO AQ
    AQ : shift_register 
        Port map ( 
            clk => clk, 
            rst => rst, 
            en_shift => en_shift, 
            load => loadAQ, 
            parallel_in => temp_AQ_in,
            serial_in => temp_AQ_out(16),        
            parallel_out => temp_AQ_out
        );
    
end Structural;
