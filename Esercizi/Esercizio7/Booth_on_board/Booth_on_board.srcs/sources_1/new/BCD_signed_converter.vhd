library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BCD_signed_Converter is
    port(
        x : in std_logic_vector(15 downto 0);  -- Numero con segno a 16 bit
        y : out std_logic_vector(19 downto 0)  -- 5 cifre BCD -> 20 bit
    );
end BCD_signed_Converter;

architecture Behavioral of BCD_signed_Converter is
    signal abs_value : unsigned(15 downto 0);  -- Modulo del numero
    signal unita : unsigned(3 downto 0);
    signal tens : unsigned(3 downto 0);
    signal hundreds : unsigned(3 downto 0);
    signal thousands : unsigned(3 downto 0);
    signal ten_thousands : unsigned(3 downto 0);
begin
    process(x)
        variable signed_value : signed(15 downto 0);
        variable temp : unsigned(15 downto 0);  -- Variabile temporanea per manipolare il valore
    begin
        -- Conversione da std_logic_vector a signed
        signed_value := signed(x);

        -- Calcola il valore assoluto
        if signed_value < 0 then
            abs_value <= unsigned(-signed_value);
        else
            abs_value <= unsigned(signed_value);
        end if;

        -- Usa una variabile temporanea per l'estrazione delle cifre
        temp := abs_value;

        -- Estrazione delle cifre BCD con resize per garantire 4 bit
        unita <= resize(unsigned(temp mod 10), 4);
        temp := temp / 10;
        tens <= resize(unsigned(temp mod 10), 4);
        temp := temp / 10;
        hundreds <= resize(unsigned(temp mod 10), 4);
        temp := temp / 10;
        thousands <= resize(unsigned(temp mod 10), 4);
        temp := temp / 10;
        ten_thousands <= resize(unsigned(temp mod 10), 4);

        -- Concatena le cifre BCD
        y <= std_logic_vector(ten_thousands) &
             std_logic_vector(thousands) &
             std_logic_vector(hundreds) &
             std_logic_vector(tens) &
             std_logic_vector(unita);
    end process;

end Behavioral;