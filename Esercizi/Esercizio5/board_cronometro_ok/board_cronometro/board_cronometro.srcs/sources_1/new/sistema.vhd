
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sistema is
    Port( 
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        en_time : in STD_LOGIC;
        load_sec : in STD_LOGIC;
        load_min : in STD_LOGIC;
        load_hours : in STD_LOGIC;
        set : in STD_LOGIC_VECTOR(5 downto 0);     
        anodes_out : out STD_LOGIC_VECTOR (7 downto 0);
        cathodes_out : out STD_LOGIC_VECTOR(7 downto 0));
end sistema;

architecture Behavioral of sistema is


component UO is 
    Port (     
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        en_time : in STD_LOGIC;
        load_sec : in STD_LOGIC;
        load_min : in STD_LOGIC;
        load_hours : in STD_LOGIC;
        set_sec : in STD_LOGIC_VECTOR(5 downto 0);  
        set_min : in STD_LOGIC_VECTOR(5 downto 0);
        set_hours : in STD_LOGIC_VECTOR(4 downto 0);   
        anodes_out : out STD_LOGIC_VECTOR (7 downto 0);
        cathodes_out : out STD_LOGIC_VECTOR(7 downto 0));
end component;    
         
    --stati e comandi della UC
    type stato is (IDLE, SET_S, SET_M, SET_H, LOAD_H, LOAD_M, LOAD_S);
    signal stato_corrente : stato := idle;
    signal stato_prossimo : stato := stato_corrente;    
       
    SIGNAL temp_set_hours : STD_LOGIC_VECTOR(4 downto 0); 
    SIGNAL temp_set_min : STD_LOGIC_VECTOR(5 downto 0);  
    SIGNAL temp_set_sec : STD_LOGIC_VECTOR(5 downto 0); 
    SIGNAL temp_load_sec : std_logic := '0';
    SIGNAL temp_load_min : std_logic := '0';
    SIGNAL temp_load_hours : std_logic := '0';
    

begin

    --unità operativa
    crono_display : UO
        Port map( 
            clk => clk,
            rst => rst, 
            en_time => en_time,
            load_sec => temp_load_sec,
            load_min => temp_load_min,
            load_hours => temp_load_hours,
            set_sec => temp_set_sec,
            set_min => temp_set_min,
            set_hours => temp_set_hours,  
            anodes_out => anodes_out,
            cathodes_out => cathodes_out
        );
        
    --unità di controllo
    mem : process (clk, rst)
        begin
            if (rst = '1') then
	           stato_corrente <= Idle;       

            elsif (rising_edge(clk)) then
                stato_corrente <= stato_prossimo;
            end if;
        end process;   
        
    comb: process(stato_corrente, load_sec, load_min, load_hours)
        begin
    
        case stato_corrente is
            when IDLE =>
                temp_load_sec <= '0';
                temp_load_min <= '0';
                temp_load_hours <= '0';
       
                if (load_hours = '1') then
                    stato_prossimo <= SET_H;                   
                else
                    stato_prossimo <= IDLE;
                end if;
                
            when SET_H  =>
                temp_set_hours <= set(4 downto 0);
                stato_prossimo <= LOAD_H;                  
                
            when LOAD_H  =>
                temp_load_hours <= '1';
                
                if (load_min = '1') then
                    stato_prossimo <= SET_M;
                else
                    stato_prossimo <= LOAD_H;
                end if;
            
            when SET_M  =>
                temp_load_hours <= '0';
                temp_set_min <= set;
                stato_prossimo <= LOAD_M;
                
            when LOAD_M  =>
                temp_load_min <= '1';
                
                if (load_sec = '1') then
                    stato_prossimo <= SET_S;
                else
                    stato_prossimo <= LOAD_M;
                end if; 
              
            when SET_S  =>
                temp_load_min <= '0';
                temp_set_sec <= set;
                stato_prossimo <= LOAD_S;
                
            when LOAD_S  =>
                temp_load_sec <= '1';
                stato_prossimo <= IDLE;

            when OTHERS =>
                stato_prossimo <= IDLE;                
                
        end case;

end process;

 
     
end Behavioral;

