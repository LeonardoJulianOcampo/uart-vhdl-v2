----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:46:41 12/03/2023 
-- Design Name: 
-- Module Name:    fifo_v3 - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fifo_v3 is
    Port ( push_in : in  STD_LOGIC;
           pop_in : in  STD_LOGIC;
           clk_in : in  STD_LOGIC;
           reset_in : in  STD_LOGIC;
           full_out : out  STD_LOGIC;
           empty_out : out  STD_LOGIC;
           write_ena : out  STD_LOGIC;
           state_out : out  STD_LOGIC_VECTOR (2 downto 0);
           address_out : out  STD_LOGIC_VECTOR (2 downto 0));
end fifo_v3;

architecture Behavioral of fifo_v3 is

	type state_type is (st1_start, st2_idle, st3_push, st4_push_full, st5_pop, st6_pop_empty); 
	signal state, next_state : state_type; 
	
	constant origin  : integer range 0 to 7;
	constant end_reg : integer range 0 to 7;
	signal head      : integer range 0 to 7;
	signal tail      : integer range 0 to 7;
	
begin
	
	process(clk_in) is
	begin
		if rising_edge(clk) then
			if reset_in = '1' then -- valores cuando se produce el reset
				state <= st1_start;
				empty_out   <= '1';
				full_out    <= '0';
				write_ena   <= '0';
				state_out   <= "000";
				address_out <= "000";
				head        <= 0;
				tail        <= 0;
			else 
				state <= st1_start;
				empty_out   <= '1';
				full_out    <= '0';
				write_ena   <= '0';
				state_out   <= "000";
				address_out <= "000";
				head        <= 0;
				tail        <= 0;
	end process

end Behavioral;

