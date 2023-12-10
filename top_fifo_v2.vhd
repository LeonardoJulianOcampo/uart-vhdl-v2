----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:10:53 12/03/2023 
-- Design Name: 
-- Module Name:    top_fifo_v2 - Behavioral 
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

entity top_fifo_v2 is
	 generic(N : integer := 3;
				M : integer := 8);
    Port ( clk      : in   STD_LOGIC;
			  clk_fsm  : in   STD_LOGIC;
           push     : in   STD_LOGIC;
           pop      : in   STD_LOGIC;
           init     : in   STD_LOGIC;
			  reset    : in   STD_LOGIC;
           data_in  : in   STD_LOGIC_VECTOR (7 downto 0);
           data_out : out  STD_LOGIC_VECTOR (7 downto 0));
end top_fifo_v2;

architecture Behavioral of top_fifo_v2 is
	signal write_enable_s : std_logic;
	signal address_signal : std_logic_vector(N-1 downto 0);
	signal counter        : std_logic_vector(N-1 downto 0);
	signal up_s           : std_logic;
	signal down_s         : std_logic;
	signal reset_cnt_s    : std_logic;
	signal full_s         : std_logic;
	signal empty_s        : std_logic;
	signal state_s        : std_logic_vector(N downto 0);
	signal max_s          : std_logic;
	signal min_s          : std_logic;
	signal pop_and_out_s  : std_logic;
	signal push_and_out_s : std_logic;
	
	component fifo is
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
	end component fifo;
	
    COMPONENT ram_8x16
    PORT(
         address_i : IN  std_logic_vector(2 downto 0);
         data_o : OUT  std_logic_vector(7 downto 0);
         data_i : IN  std_logic_vector(7 downto 0);
         write_enable : IN  std_logic;
         clk : IN  std_logic;
         reset : IN  std_logic
        );
    END COMPONENT;
	
	component updown_counter is
		 Port ( up    : in   STD_LOGIC;
				  down  : in   STD_LOGIC;
				  clk   : in   STD_LOGIC;
				  reset : in   STD_LOGIC;
				  count : out  STD_LOGIC_VECTOR (2 downto 0);
				  max   : out  STD_LOGIC;
				  min   : out  STD_LOGIC);
	end component;
	
begin


	
	logic: fifo        				port map(push_and_out_s,
														pop_and_out_s,
														clk_fsm,
														reset,
														counter,
														full_s,
														empty_s,
														write_enable_s,
														state_s,
														up_s,
														down_s,
														reset_cnt_s);
	
	comp_counter: updown_counter 	port map(up_s,
														down_s,
														clk,
														reset_cnt_s,
														counter,
														max_s,
														min_s
														);
																			
	ram: ram_8x16    					port map(counter,
														data_out,
														data_in,
														write_enable_s,
														clk,
														reset);
							
	pop_and_out_s  <= not(min_s) and pop;
	push_and_out_s <= not(max_s) and push;
	
end Behavioral;

