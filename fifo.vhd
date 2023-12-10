----------------------------------------------------------------------------------
-- Company: 
-- Autor: Leonardo Ocampo 
-- 
-- Create Date:    23:34:16 12/02/2023 
-- Design Name: 
-- Module Name:    fifo - Behavioral 
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
--use ieee.std_logic_arith.ALL;
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fifo is
    Port ( push_in     : in   STD_LOGIC;
           pop_in      : in   STD_LOGIC;
           clk_in      : in   STD_LOGIC;
           reset_in    : in   STD_LOGIC;
			  counter_in  : in   STD_LOGIC_VECTOR (2 downto 0);
           full_out    : out  STD_LOGIC;
           empty_out   : out  STD_LOGIC;
			  write_ena   : out  STD_LOGIC;
			  state_out   : out  std_logic_vector (3 downto 0);
			  add_out     : out  std_logic;
			  sub_out     : out  std_logic;
			  rst_cnt_out : out  std_logic);
end fifo;

architecture Behavioral of fifo is
-- This is a sample state-machine using enumerated types.
-- This will allow the synthesis tool to select the appropriate
-- encoding style and will make the code more readable.
--Insert the following in the architecture before the begin keyword
   --Use descriptive names for the states, like st1_reset, st2_search
   type state_type is (st1_start, st2_idle, st3_push, st4_push_full, st5_pop, st6_pop_empty, st7_add_add, st8_sub_add, st9_set_empty, st10_set_full); 
   signal state, next_state : state_type; 
   --Declare internal signals for all outputs of the state-machine
	signal empty_out_i     : std_logic := '0';
	signal full_out_i      : std_logic := '0';
	signal add_out_i       : std_logic := '0';
	signal sub_out_i       : std_logic := '0';
	signal rst_cnt_out_i   : std_logic := '0';
	signal write_ena_i     : std_logic := '0';
	signal state_out_i     : std_logic_vector (3 downto 0) := "0000";
	

   --other outputs
	begin
--Insert the following in the architecture after the begin keyword
   SYNC_PROC: process (clk_in)
   begin
      if (clk_in'event and clk_in = '1') then
         if (reset_in = '1') then
            state <= st1_start;
            empty_out   <= '1';
            full_out    <= '0';
            write_ena   <= '0';
            add_out     <= '0';
				sub_out     <= '0';
				rst_cnt_out <= '1';
				state_out   <= "0000";
         else
            state       <= next_state;
            add_out     <= add_out_i;
				sub_out     <= sub_out_i;
            empty_out   <= empty_out_i;
            full_out    <= full_out_i;
				write_ena   <= write_ena_i;
				state_out   <= state_out_i;
				rst_cnt_out <= rst_cnt_out_i;
         -- assign other outputs to internal signals
         end if;        
      end if;
   end process;
 
   --MOORE State-Machine - Outputs based on state only
   OUTPUT_DECODE: process (state, empty_out_i, full_out_i)
   begin
      --insert statements to decode internal output signals
      --below is simple example
      if state = st1_start then
			empty_out_i    <= '1';
			full_out_i     <= '0';
			add_out_i      <= '0';
			sub_out_i      <= '0';
			rst_cnt_out_i  <= '1';
			write_ena_i    <= '0';
			state_out_i    <= "0000";
		elsif state = st2_idle then
			empty_out_i    <= '0';
			full_out_i     <= '0';
			add_out_i      <= '0';
			sub_out_i      <= '0';
			rst_cnt_out_i  <= '0';
			write_ena_i    <= '0';
			state_out_i    <= "0001";
      elsif state = st3_push then
			empty_out_i    <= '0';
			full_out_i     <= '0';
			add_out_i      <= '0';
			sub_out_i      <= '0';
			rst_cnt_out_i  <= '0';
			write_ena_i    <= '1';
			state_out_i    <= "0010";
		elsif state = st4_push_full then
			empty_out_i    <= '0';
			full_out_i     <= '0';
			add_out_i      <= '0';
			sub_out_i      <= '0';
			rst_cnt_out_i  <= '0';
			write_ena_i    <= '1';
			state_out_i    <= "0011";
      elsif state = st5_pop then
			empty_out_i    <= '0';
			full_out_i     <= '0';
			add_out_i      <= '0';
			write_ena_i    <= '1';
			sub_out_i      <= '0';
			rst_cnt_out_i  <= '0';
			state_out_i    <= "0100";
		elsif state = st6_pop_empty then
			empty_out_i    <= '0';
			full_out_i     <= '0';
			add_out_i      <= '0';
			write_ena_i    <= '1';
			sub_out_i      <= '0';
			rst_cnt_out_i  <= '0';
			state_out_i    <= "0101";
		elsif state = st7_add_add then
			empty_out_i    <= '0';
			full_out_i     <= '0';
			add_out_i      <= '1';
			write_ena_i    <= '0';
			sub_out_i      <= '0';
			rst_cnt_out_i  <= '0';
			state_out_i    <= "0110";
		elsif state = st8_sub_add then
			empty_out_i    <= '0';
			full_out_i     <= '0';
			add_out_i      <= '0';
			write_ena_i    <= '0';
			sub_out_i      <= '1';
			rst_cnt_out_i  <= '0';
			state_out_i    <= "0111";
		elsif state = st9_set_empty then
			empty_out_i    <= '1';
			full_out_i     <= '0';
			add_out_i      <= '0';
			write_ena_i    <= '0';
			sub_out_i      <= '0';
			rst_cnt_out_i  <= '0';
			state_out_i    <= "1000";
		elsif state = st10_set_full then
			empty_out_i    <= '0';
			full_out_i     <= '1';
			add_out_i      <= '0';
			write_ena_i    <= '0';
			sub_out_i      <= '0';
			rst_cnt_out_i  <= '0';
			state_out_i    <= "1001";
      else
         empty_out_i    <= '0';
			full_out_i     <= '0';
			add_out_i      <= '0';
			write_ena_i    <= '0';
			sub_out_i      <= '0';
			rst_cnt_out_i  <= '0';
			state_out_i    <= "1111";   -- estado no establecido. Si cae aca algo anda mal 
      end if;
   end process;
 
   NEXT_STATE_DECODE: process (state, clk_in, pop_in, push_in, reset_in, full_out_i, empty_out_i, state_out_i,counter_in)
	begin

      --declare default state for next_state to avoid latches
      next_state <= state;  --default is to stay in current state
      --insert statements to decode next_state
      --below is a simple example
      case (state) is
         when st1_start =>
            if reset_in = '0' then
               next_state <= st2_idle;
				else 
					next_state <= st1_start;
            end if;
         when st2_idle =>  
            if push_in = '1' and (to_integer(unsigned(counter_in)) < 7)    then
               next_state <= st3_push;
            elsif push_in = '1' and (to_integer(unsigned(counter_in)) = 7) then
               next_state <= st4_push_full;
            elsif pop_in = '1' and (to_integer(unsigned(counter_in)) > 0)  then
               next_state <= st5_pop;
            elsif pop_in = '1' and (to_integer(unsigned(counter_in)) = 0)  then
               next_state <= st6_pop_empty;
				else
					next_state <= st2_idle;
            end if;
         when st3_push => 
					next_state <= st7_add_add;
				
			when st4_push_full =>
					next_state <= st10_set_full;
				
			when st5_pop =>
					next_state <= st8_sub_add;
				
			when st6_pop_empty =>
					next_state <= st9_set_empty;
					
			when st7_add_add =>
					next_state <= st2_idle;
			
			when st8_sub_add =>
					next_state <= st2_idle;
					
			when st9_set_empty =>
					next_state <= st2_idle;
			
			when st10_set_full =>
					next_state <= st2_idle;
				
         when others =>
            next_state <= st2_idle;
      end case;      
   end process;


end Behavioral;
