

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;


entity PO_PC_on_board is
    Generic (
        N : integer := 16);
    Port (
        clk:              in std_logic;
        Input_rst:        in std_logic;
        Input_start:      in std_logic;
        Input_Read:       in std_logic;
        led:              out STD_LOGIC_VECTOR(3 downto 0)     
     );
end PO_PC_on_board;

architecture board of PO_PC_on_board is

    component BTN_Interface is
        Port( 
            clk : in std_logic;
            Input_rst : in std_logic;
            Input_start: in std_logic;
            Input_Read : in std_logic;
            cleared_rst : out std_logic;
            cleared_start: out std_logic;      
            cleared_Read: out std_logic       
        );
    end component;
    
    component PO_PC_system is
        Generic (
            N : integer := 16 -- Numero di locazioni di memoria (modificabile)
        );
    Port (
            clk:            in std_logic;
            RST:            in std_logic;
            Start_system:   in std_logic;
            Read_system:    in std_logic;
            led :           out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;
    
    signal cleared_rst_temp : std_logic := '0';
    signal cleared_start_temp : std_logic := '0';
    signal cleared_Read_temp : std_logic := '0';
    
begin

    Interfaccia: BTN_Interface 
        Port map( 
            clk => clk,
            Input_rst => Input_rst,
            Input_start => Input_start,
            Input_Read => Input_Read,
            cleared_rst => cleared_rst_temp,
            cleared_start => cleared_start_temp,     
            cleared_Read => cleared_Read_temp
        );

    sistema_PO_PC: PO_PC_system
        generic map (
            N => N  
        )
        port map(
            CLK => CLK,
            RST => cleared_rst_temp,
            Start_system => cleared_start_temp,
            Read_system => cleared_Read_temp,
            led => led
        );
                   
end ;
