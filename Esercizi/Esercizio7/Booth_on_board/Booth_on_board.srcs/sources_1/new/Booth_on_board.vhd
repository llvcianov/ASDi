

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

entity Booth_on_board is
  Port ( 
    clk, rst, start, count : in std_logic;
    X,Y : in std_logic_vector(7 downto 0);
    LED : out  std_logic_vector (15 downto 0)
  );
end Booth_on_board;

architecture board of Booth_on_board is
    
    component BTN_Interface is
        Port( 
            clk : in std_logic;
            Input_rst : in std_logic;
            Input_start: in std_logic;
            Input_count: in std_logic;
            cleared_rst : out std_logic;
            cleared_start: out std_logic;
            cleared_count: out std_logic         
        );
    end component; 
    
    component booth is
        Port ( 
            clk, rst, start, count : in std_logic;
            X,Y : in std_logic_vector(7 downto 0);
            P : out std_logic_vector (15 downto 0);
            stop: out std_logic
    );
    end component;
    
    
    signal temp_cleared_rst: std_logic;
    signal temp_cleared_start: std_logic;
    signal temp_cleared_count: std_logic;
    signal temp_stop: std_logic;
    signal temp_P: std_logic_vector(15 downto 0) := (others => '0');
    signal temp_X: std_logic_vector(7 downto 0);
    signal temp_Y: std_logic_vector(7 downto 0);
    
    
    begin
    
--    temp_X <= X;  
--    temp_Y <= Y;
--    LED <= temp_P;
    
    interfaccia: BTN_Interface 
        Port map( 
            clk => clk,
            Input_rst => rst,
            Input_start => start,
            Input_count => count,
            cleared_rst => temp_cleared_rst, 
            cleared_start => temp_cleared_start,
            cleared_count => temp_cleared_count
        );
        
--    sistema: booth 
--        Port map( 
--            clk => clk,
--            rst => temp_cleared_rst,
--            start => temp_cleared_start,
--            count => temp_cleared_count,
--            X => X, 
--            Y => Y, 
--            P => temp_P,
--            stop => temp_stop
--        );

        sistema: booth 
        Port map( 
            clk => clk,
            rst => rst,
            start => start,
            count => count,
            X => X, 
            Y => Y, 
            P => temp_P,
            stop => temp_stop
        );
        
--     Assegna il valore a LED solo quando stop è alto
    process(clk)
    begin
        if rising_edge(clk) then
            if(temp_cleared_rst = '1') then
                LED <= "0000000010101010";
--                temp_P <= "0000000010101010";
--                temp_P <= "0000000000000000";
            elsif (temp_stop = '1') then
--                elsif (visual = '1') then
                    LED <= temp_P;
                elsif (start = '1') then
                    LED <= "0000000000000000";

                
            end if;
        end if;
    end process;
            

end board;

--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;
----use IEEE.NUMERIC_STD.ALL;

--entity Booth_on_board is
--  Port ( 
--    clk, rst, start, count : in std_logic;
--    X,Y : in std_logic_vector(7 downto 0);
--    LED : out  std_logic_vector (15 downto 0)
--  );
--end Booth_on_board;

--architecture board of Booth_on_board is
    
--    component ButtonDebouncer
--        generic (                       
--            CLK_period: integer := 10;
--            btn_noise_time: integer := 10000000 
--        );
--        Port ( 
--            RST : in std_logic;
--            CLK : in std_logic;
--            BTN : in std_logic;
--            CLEARED_BTN : out std_logic
--        );
--    end component;
    
    
--    component booth is
--        Port ( 
--            clk, rst, start, count : in std_logic;
--            X,Y : in std_logic_vector(7 downto 0);
--            P : out std_logic_vector (15 downto 0);
--            stop: out std_logic
--    );
--    end component;
    
--    signal cleared_rst: std_logic;
--    signal cleared_start: std_logic;
--    signal cleared_count: std_logic;
--    signal temp_stop: std_logic;
    
--    begin
    
--    BTN_reset : ButtonDebouncer
--        Generic map(                        
--            CLK_period => 10,
--            btn_noise_time => 10000000 
--        )
--        Port map( RST => '0',
--            CLK => clk,
--            BTN => rst,
--            CLEARED_BTN => cleared_rst
--        );
        
--    BTN_start : ButtonDebouncer
--        Generic map(                        
--            CLK_period => 10,
--            btn_noise_time => 10000000 
--        )
--        Port map( RST => '0',
--            CLK => clk,
--            BTN => start,
--            CLEARED_BTN => cleared_start
--        );   
        
--    BTN_visual : ButtonDebouncer
--        Generic map(                        
--            CLK_period => 10,
--            btn_noise_time => 10000000 
--        )
--        Port map( RST => '0',
--            CLK => clk,
--            BTN => count,
--            CLEARED_BTN => cleared_count
--        );
        
--    sistema: booth 
--        Port map( 
--            clk => clk,
--            rst => cleared_rst,
--            start => cleared_start,
--            count => cleared_count,
--            X => X, 
--            Y => Y, 
--            P => LED,
--            stop => temp_stop
--        );
    
    
            

--end board;
