--cuenta generica de cero a 2^n-1. cuando llega  a la cuenta mxima hace algo


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity counter is 
	generic (N: integer := 3);
	port(ena_out : out std_logic;
	     clk_in  :  in std_logic;
	     rst     :  in std_logic;
		  max     : out std_logic);
end entity;


architecture behavioral of counter is

	signal r_reg      : unsigned(N-1 downto 0) := "000";
	signal r_reg_next : unsigned(N-1 downto 0) := "000";
	
begin
	process(clk_in,rst) 
	begin
		if(rst='1') then
			r_reg <= (others => '0');
		elsif (rising_edge(clk_in)) then
			r_reg <= r_reg_next;
		end if;
	end process;
	
	r_reg_next <= (others => '0') when r_reg = (2**N) else r_reg + 1;
	
	ena_out <= '0' when r_reg = "000" else '1';
	max     <= '0' when r_reg = "111" else '0';

end behavioral;
