----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:04:21 12/09/2023 
-- Design Name: 
-- Module Name:    up-down-counter-0-7 - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity up-down-counter-0-7 is
    Port ( up    : in  STD_LOGIC;
           down  : in  STD_LOGIC;
           clk   : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           count : out  STD_LOGIC_VECTOR (7 downto 0));
end up-down-counter-0-7;

architecture Behavioral of up-down-counter-0-7 is
	signal counter : integer range 0 to 7 := 0;
begin
	process (clk)
	begin  
		if (clk'event and clk = '1') then
			if reset = '1' then
				counter <=   0;
				count   <= '0';
			else
				if up = '1' and counter < 7 then
					counter <= counter + 1;
					count <= conv_std_logic_vector(counter);
				
				elsif up = '1' and counter = 7 then 
					counter <= counter;
					count <= "111";
			end if;
		end if;
	end process;

end Behavioral;

