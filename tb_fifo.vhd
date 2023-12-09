--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:45:10 12/09/2023
-- Design Name:   
-- Module Name:   /home/leo/projects/UTN/tecnicas-digitales-iii/TP4-UART/tp4/uart_v2/rx_v2/rx_v2/tb_fifo.vhd
-- Project Name:  rx_v2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: fifo
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_fifo IS
END tb_fifo;
 
ARCHITECTURE behavior OF tb_fifo IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fifo
    PORT(
         push_in : IN  std_logic;
         pop_in : IN  std_logic;
         clk_in : IN  std_logic;
         reset_in : IN  std_logic;
         counter_in : IN  std_logic_vector(2 downto 0);
         full_out : OUT  std_logic;
         empty_out : OUT  std_logic;
         write_ena : OUT  std_logic;
         state_out : OUT  std_logic_vector(2 downto 0);
         add_out : OUT  std_logic;
         sub_out : OUT  std_logic;
         rst_cnt_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal push_in : std_logic := '0';
   signal pop_in : std_logic := '0';
   signal clk_in : std_logic := '0';
   signal reset_in : std_logic := '0';
   signal counter_in : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal full_out : std_logic;
   signal empty_out : std_logic;
   signal write_ena : std_logic;
   signal state_out : std_logic_vector(2 downto 0);
   signal add_out : std_logic;
   signal sub_out : std_logic;
   signal rst_cnt_out : std_logic;

   -- Clock period definitions
   constant clk_in_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fifo PORT MAP (
          push_in => push_in,
          pop_in => pop_in,
          clk_in => clk_in,
          reset_in => reset_in,
          counter_in => counter_in,
          full_out => full_out,
          empty_out => empty_out,
          write_ena => write_ena,
          state_out => state_out,
          add_out => add_out,
          sub_out => sub_out,
          rst_cnt_out => rst_cnt_out
        );

   -- Clock process definitions
   clk_in_process :process
   begin
		clk_in <= '0';
		wait for clk_in_period/2;
		clk_in <= '1';
		wait for clk_in_period/2;
   end process;
	
	reset_proc: process
	begin
		reset <= '0';
		wait for 3 ns;
		reset <= '1';
		wait for 3 ns;
		reset <= '0';
		wait;
	end process;
	
   -- Stimulus process
   stim_proc: process
   begin		
		push_in <= '1';
		pop_in <= '0';
		wait for 23 ns;
		push_in <= '0';
		pop_in <= '0';
		wait for 23 ns;
		push_in <= '0';
		pop_in <= '0';
		wait for 23 ns;
		push_in <= '0';
		pop_in <= '1';
		wait for 23 ns;
		push_in <= '0';
		pop_in <= '0';
		wait;
   end process;

END;
