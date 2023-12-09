----------------------------------------------------------------------------------
-- Company: 
-- Autor: Leonardo Ocampo 
-- 
-- Create Date:    12:51:42 11/26/2023 
-- Design Name: 
-- Module Name:    baud_rate_clk - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity baud_rate_clk is
    Port ( system_clk     : in  STD_LOGIC;
           clk_gen_enable : in  STD_LOGIC;
			  rst            : in  STD_LOGIC;
           clk_baud_rate  : out  STD_LOGIC);
end baud_rate_clk;

architecture Behavioral of baud_rate_clk is
	constant count_period : integer              := 50000000 / 115200;
	signal counter        : integer range 0 to 511 := 0;
begin

process (system_clk)
begin  
   if (system_clk'event and system_clk = '1') then
      if rst = '1' then
         clk_baud_rate <= '0';
			counter <= 0;
      else
			if counter = count_period then
				counter <= 0;
				clk_baud_rate <= '1';
			elsif (counter < count_period and clk_gen_enable = '1') then
				counter <= counter + 1;
				clk_baud_rate <= '0';
			else
				counter <= counter;
				clk_baud_rate <= '0';
			end if;
      end if;
   end if;
end process;

end Behavioral;

