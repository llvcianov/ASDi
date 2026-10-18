----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.01.2025 16:53:32
-- Design Name: 
-- Module Name: Shift 
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

-- Entity definition
entity shift_register_N_bit is
    generic(
        N : integer := 8  -- Dimensione del registro
    );    
    port(
        CLK, RST, dataIN    : in std_logic;   -- Ingressi
        Y                   : in std_logic;   -- Y = 0 (1 posizione), Y = 1 (2 posizioni)
        S                   : in std_logic;   -- S = 0 (sx <- dx), S = 1 (sx -> dx)
        dataOUT             : out std_logic   -- Uscita
    );
    -- SY = 00 shift a sinistra di 1 posizione
    -- SY = 01 shift a sinistra di 2 posizioni
    -- SY = 10 shift a destra di 1 posizione
    -- SY = 11 shift a destra di 2 posizioni
    
end shift_register_N_bit;

----Architecture Structural
architecture Structural of shift_register_N_bit is
    
    component FlipFlop is
        port(
            CLK     : in std_logic;
            RST     : in std_logic; 
            D       : in std_logic;
            Q       : out std_logic  
        );
    end component;
    
    component mux_4_1 is 
        port(  
            dataIN  : in std_logic_vector (3 downto 0);
            s0      : in std_logic;
            s1      : in std_logic;
            dataOUT : out std_logic  
        );
    end component;
    
    component mux_2_1 is
        port(
            dataIN0 : in std_logic;
            dataIN1 : in std_logic; 
            s       : in std_logic;
            dataOUT : out std_logic
        );
    end component;
    
    component demux_1_2 is
        port(
            dataIN     : in std_logic;
            s           : in std_logic;
            dataOUT0     : out std_logic;
            dataOUT1    : out std_logic
        );
    end component;
    
    signal mux4OUT      : std_logic_vector(N - 1 downto 0);
    signal FFOUT        : std_logic_vector(N - 1 downto 0);
    signal demux2OUT    : std_logic_vector(1 downto 0);
    
 
    begin
        
        NFlipFlop: for i in 0 to N - 1 generate 
            FF: FlipFlop
            port map(
                CLK => CLK,
                RST => RST,
                D   => mux4OUT(i),
                Q   => FFOUT(i)
            );
        end generate;
        
        DEMUX_IN: demux_1_2
        port map(
            dataIN      => dataIN,
            s           => S,
            dataOUT0    => demux2OUT(0),
            dataOUT1    => demux2OUT(1)
        );
        
        MUX_OUT: mux_2_1
        port map(
            dataIN0    => FFOUT(N-1),
            dataIN1    => FFOUT(0),
            s          => S,
            dataOUT    => dataOUT
        );
                
        MUX_sx0: mux_4_1
        port map(
            dataIN(0) => FFOUT(N-2),
            dataIN(1) => FFOUT(N-3),
            dataIN(2) => demux2OUT(1),
            dataIN(3) => '-',
            s1 => S,
            s0 => Y,
            dataOUT => mux4OUT(N-1)
        );
        
        MUX_sx1: mux_4_1
        port map(
            dataIN(0) => FFOUT(N-3),
            dataIN(1) => FFOUT(N-4),
            dataIN(2) => FFOUT(N-1),
            dataIN(3) => demux2OUT(1),
            s1 => S,
            s0 => Y,
            dataOUT => mux4OUT(N-2)
        );        
        
        MUX_dx0: mux_4_1
        port map(
            dataIN(0) => demux2OUT(0),
            dataIN(1) => '-',
            dataIN(2) => FFOUT(1),
            dataIN(3) => FFOUT(2),
            s1 => S,
            s0 => Y,
            dataOUT => mux4OUT(0)
        );
        
        MUX_dx1: mux_4_1
        port map(
            dataIN(0) => FFOUT(0),
            dataIN(1) => demux2OUT(0),
            dataIN(2) => FFOUT(2),
            dataIN(3) => FFOUT(3),
            s1 => S,
            s0 => Y,
            dataOUT => mux4OUT(1)
        );
              
        NMUX: for i in 2 to N - 3 generate
            MUX4: mux_4_1
            port map(
                dataIN(0) => FFOUT(i-1),
                dataIN(1) => FFOUT(i-2),
                dataIN(2) => FFOUT(i+1),
                dataIN(3) => FFOUT(i+2),
                s1 => S, 
                s0 => Y,
                dataOUT => mux4OUT(i)
            );
        end generate;
end Structural;
            
----Architecture behavioural
--architecture archi of shift_register_N_bit is
--    signal tmp: std_logic_vector(N-1 downto 0);  -- Registro a N bit
--begin

--    process (CLK)
--    begin
--        if (rising_edge(CLK)) then
--            if (RST = '1') then
--                tmp <= (others => '0');  -- Reset del registro
                
--            elsif (S = '0') then  -- shift verso sinistra (sx <- dx)
--                if (Y = '0') then  -- shift di 1 posizione
--                    tmp(0) <= dataIN;
--                    for i in N-1 downto 1 loop  
--                        tmp(i) <= tmp(i-1);
--                    end loop;
                    
--                elsif (Y = '1') then  -- shift di 2 posizioni
--                    tmp(0) <= '-';  
--                    tmp(1) <= dataIN;                     
--                    for i in N-1 downto 2 loop  
--                        tmp(i) <= tmp(i-2);
--                    end loop;
--                end if;
                
--            elsif (S = '1') then  -- shift verso destra (sx -> dx)
--                if (Y = '0') then  -- shift di 1 posizione 
--                    for i in 0 to N-2 loop  
--                        tmp(i) <= tmp(i+1);
--                    end loop;
--                    tmp(N-1) <= dataIN;  
                    
--                elsif (Y = '1') then  -- shift di 2 posizioni
--                    for i in 0 to N-3 loop  
--                        tmp(i) <= tmp(i+2);
--                    end loop;
--                    tmp(N-2) <= dataIN;  
--                    tmp(N-1) <= '-';  
--                end if;
--            end if;
--        end if;
--    end process;

--    -- Assegnamento dell'uscita dataOUT
--    with S select
--        dataOUT <=  tmp(N-1)    when '0',  -- Direzione sinistra
--                    tmp(0)      when '1',  -- Direzione destra
--                    '-'         when others;

--end archi;

				
				
