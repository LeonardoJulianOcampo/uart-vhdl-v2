----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:57:53 12/03/2023 
-- Design Name: 
-- Module Name:    fifo_v2 - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fifo_v2 is
	 generic(N : integer := 3);
    Port ( push_i      : in     STD_LOGIC;
           pop_i       : in     STD_LOGIC;
           init_i      : in     STD_LOGIC;
           clk_i       : in     STD_LOGIC;
           address_o   : out    STD_LOGIC_VECTOR(N-1 downto 0);
           write_ena_o : buffer  STD_LOGIC;
           full_o      : buffer  STD_LOGIC;
           nopop_o     : buffer  STD_LOGIC;
           nopush_o    : buffer  STD_LOGIC;
           empty_o     : buffer  STD_LOGIC);
end fifo_v2;

architecture Behavioral of fifo_v2 is
	signal wptr, rptr: std_logic_vector(N-1 downto 0);
	signal lastop:std_logic;
begin
	
	SYNC_PROC: process(clk_i) begin
		if(clk_i'event and clk_i = '1') then
			if(init_i = '1') then
				wptr <= (others => '0');
				rptr <= (others => '0');
				lastop <= '0';
			elsif(pop_i = '1' and empty_o = '0') then -- pop_i
				rptr <= rptr + 1;
				lastop <= '1';
			elsif(push_i='1' and full_o = '0') then -- push_i
				wptr <= wptr + 1;
				lastop <= '1';
			end if;
		end if;
	end process;
	
	COMB_PROC: process(push_i, pop_i, wptr, rptr, lastop, full_o, empty_o) begin
	--seteo de valores de banderas
		if(rptr = wptr) then
			if(lastop='1') then
				full_o <= '1';
				empty_o<= '0';
			else
				full_o <= '0';
				empty_o<= '1';
			end if;
		else
			full_o <= '0';
			empty_o<= '0';
		end if;
	--direccionamiento, write enable y logica de nopush_o/nopop_o
		if(pop_i = '0' and push_i = '0') then
			address_o   <= rptr;
			write_ena_o <=  '0';
			nopush_o      <=  '0';
			nopop_o       <=  '0';
		elsif(pop_i = '0' and push_i = '1') then
			address_o <= wptr;
			nopop_o <= '0';
			if(full_o = '0') then
				write_ena_o <= '1';
				nopush_o      <= '0';
			else
				write_ena_o <= '0';
				nopush_o      <= '1';
			end if;
		elsif(pop_i = '1' and push_i = '0') then
			address_o <= rptr;
			nopush_o    <= '0';
			write_ena_o <= '0';
			if(empty_o = '0') then
				nopop_o <= '0';
			else
				nopop_o <= '1';
			end if;
		else
			if(empty_o = '0') then
				address_o <= rptr;
				write_ena_o <= '0';
				nopush_o <= '1';
				nopop_o  <= '0';
			else
				address_o <= wptr;
				write_ena_o <= '1';
				nopush_o <= '0';
				nopop_o  <= '1';
			end if;
		end if;
	end process;
end Behavioral;

