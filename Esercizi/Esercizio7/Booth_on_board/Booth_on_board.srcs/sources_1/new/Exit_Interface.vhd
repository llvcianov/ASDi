
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Exit_Interface is
    Port( 
        clk : in std_logic;
        rst : in std_logic;
        P : in std_logic_vector (15 downto 0);
        anodes : out  std_logic_vector (7 downto 0);
        cathodes: out  std_logic_vector (7 downto 0)      
    );
end Exit_Interface;

architecture structural of Exit_Interface is
 
    component BCD_signed_Converter is
        port(
            x : in std_logic_vector(15 downto 0);  -- Numero con segno a 16 bit
            y : out std_logic_vector(19 downto 0)  -- 5 cifre BCD -> 20 bit
        );
    end component;
    
    component display_seven_segments is
	   Generic( 
			CLKIN_freq : integer := 100000000; 
			CLKOUT_freq : integer := 500
		);
        Port ( 
            CLK : in  STD_LOGIC;
            RST : in  STD_LOGIC;
            VALUE : in  STD_LOGIC_VECTOR (31 downto 0);
            ENABLE : in  STD_LOGIC_VECTOR (7 downto 0); -- decide quali cifre abilitare
            DOTS : in  STD_LOGIC_VECTOR (7 downto 0); -- decide quali punti visualizzare
            ANODES : out  STD_LOGIC_VECTOR (7 downto 0);
            CATHODES : out  STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    signal temp_product: std_logic_vector (15 downto 0);
    signal temp_BCD_product: std_logic_vector (31 downto 0); 

begin
          
    product_converter: BCD_signed_Converter
        Port map (
            x => P,
            y => temp_BCD_product(19 downto 0)
        );
     
    Display: display_seven_segments 
        Generic map( 
            CLKIN_freq => 100000000, 
            CLKOUT_freq => 500
        )
        Port map( 
            CLK => CLK,
            RST => rst,
            VALUE => temp_BCD_product,
            ENABLE => "00001111",
            DOTS => "00000000", 
            ANODES => anodes,
            CATHODES => cathodes
    );     
 
end structural;

