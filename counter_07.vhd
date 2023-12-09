----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:38:51 11/26/2023 
-- Design Name: 
-- Module Name:    counter_07 - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values


-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_07 is
    Port ( count_up        : in   STD_LOGIC;
           rst_counter     : in   STD_LOGIC;
           clock_baud_rate : in   STD_LOGIC;
           count_max       : out  STD_LOGIC);
end counter_07;

architecture Behavioral of counter_07 is
	signal counter : integer range 0 to 7 := 0; 
begin
	process (clock_baud_rate)
	begin  
		if (clock_baud_rate'event and clock_baud_rate = '1') then
			if rst_counter = '1' then
				counter <= 0;
				count_max <= '0';
			else
				if counter = 7 then
					counter <= 0;
					count_max <= '1';
				elsif ((counter < 7) and (count_up = '1')) then
					counter <= counter + 1;
					count_max <= '0';
				else
					counter <= counter;
					count_max <= '0';
				end if;
			end if;
		end if;
	end process;

end Behavioral;

