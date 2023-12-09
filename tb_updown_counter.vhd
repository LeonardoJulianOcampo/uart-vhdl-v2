--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   01:32:23 12/09/2023
-- Design Name:   
-- Module Name:   /home/leo/projects/UTN/tecnicas-digitales-iii/TP4-UART/tp4/uart_v2/rx_v2/rx_v2/tb_updown_counter.vhd
-- Project Name:  rx_v2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: updown_counter
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
 
ENTITY tb_updown_counter IS
END tb_updown_counter;
 
ARCHITECTURE behavior OF tb_updown_counter IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT updown_counter
    PORT(
         up : IN  std_logic;
         down : IN  std_logic;
         clk : IN  std_logic;
         reset : IN  std_logic;
         count : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal up : std_logic := '0';
   signal down : std_logic := '0';
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal count : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: updown_counter PORT MAP (
          up => up,
          down => down,
          clk => clk,
          reset => reset,
          count => count
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
	rst_proc: process
	begin
		wait for 1 ns;
		reset <= '1';
		wait for 3 ns;
		reset <= '0';
		wait;
	end process;

   -- Stimulus process
   stim_proc: process
   begin		
		up <= '1';
		down <= '0';
		wait for 10 ns;
		up <= '0';
		down <= '0';
		wait for 10 ns;
		up <= '1';
		down <= '0';
		wait for 10 ns;
		up <= '0';
		down <= '0';
		wait for 10 ns;
		up <= '0';
		down <= '1';
		wait for 10 ns;
		up <= '0';
		down <= '0';
      wait;
   end process;

END;
