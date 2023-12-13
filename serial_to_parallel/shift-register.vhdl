--conversor serial a paralelo
--la salida paralela será tal que el bit mas significativo de la entrada serie será el mas significativo en la salida paralela

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SHIFT_REG is
    generic(
        LENGTH: natural := 8
    );
    port(
        SHIFT_EN : in  std_logic;
        SO       : out std_logic;
        SI       : in  std_logic;
        clk      : in  std_logic;
        rst      : in  std_logic;
        DOUT     : out std_logic_vector(LENGTH-1 downto 0)
    );
end entity SHIFT_REG;

architecture Behavioral of SHIFT_REG is
    signal reg : std_logic_vector(LENGTH-1 downto 0) := (others => '0');
begin
    main_process : process(clk) is
    begin
        if rising_edge(clk) then
            if rst = '1' then
                reg <= (others => '0');
            else
                if SHIFT_EN = '1' then
                    --hace shift 
                    reg <= reg(LENGTH-2 downto 0) & SI;
                else
                    -- no hace shift
                    reg <= reg;
                end if;
            end if;
        end if;
    end process main_process;
    
    DOUT <= REG;
    SO <= reg(LENGTH-1);
end architecture Behavioral;
