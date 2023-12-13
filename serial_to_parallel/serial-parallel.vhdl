LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity serial_parallel is 

generic(LENGTH : natural := 8);
port(    data_in   : in std_logic;
	     clk        : in std_logic;
	     rst        : in std_logic;
		  data_ok    : out std_logic;
	     data_out   : out std_logic_vector (LENGTH -1 downto 0));
end entity;

architecture behavioral of serial_parallel is

signal s_enable : std_logic;
signal s_dout   : std_logic_vector (LENGTH - 1 downto 0);


component counter is
	generic (N: integer := 3);
	port(ena_out : out std_logic;
	     clk_in  :  in std_logic;
	     rst     :  in std_logic;
		  max     : out std_logic);
end component;

component shift_reg is 
	generic(LENGTH: natural := 8);
    port(
        SHIFT_EN : in  std_logic;
        SO       : out std_logic;
        SI       : in  std_logic;
        clk      : in  std_logic;
        rst      : in  std_logic;
        DOUT     : out std_logic_vector(LENGTH-1 downto 0));
end component;
begin

sh_reg : shift_reg port map (SHIFT_EN => s_enable, SI => data_in, clk => clk, rst => rst, DOUT => s_dout);
count0 : counter   port map (ena_out => s_enable, clk_in => clk, rst => rst, max => data_ok);

data_out <= s_dout when s_enable = '0' else (others => '0');


end behavioral;
