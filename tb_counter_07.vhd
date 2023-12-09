--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   00:52:41 11/26/2023
-- Design Name:   
-- Module Name:   /home/leo/projects/UTN/tecnicas-digitales-iii/TP4-UART/tp4/uart_v2/rx_v2/rx_v2/tb_counter_07.vhd
-- Project Name:  rx_v2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: counter_07
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
 
ENTITY tb_counter_07 IS
END tb_counter_07;
 
ARCHITECTURE behavior OF tb_counter_07 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT counter_07
    PORT(
         count_up : IN  std_logic;
         rst_counter : IN  std_logic;
         clock_baud_rate : IN  std_logic;
         count_max : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal count_up : std_logic := '0';
   signal rst_counter : std_logic := '0';
   signal clock_baud_rate : std_logic := '0';

 	--Outputs
   signal count_max : std_logic;

   -- Clock period definitions
   constant clock_baud_rate_period : time := 25 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: counter_07 PORT MAP (
          count_up => count_up,
          rst_counter => rst_counter,
          clock_baud_rate => clock_baud_rate,
          count_max => count_max
        );

   -- Clock process definitions
   clock_baud_rate_process :process
   begin
		clock_baud_rate <= '0';
		wait for clock_baud_rate_period/2;
		clock_baud_rate <= '1';
		wait for clock_baud_rate_period/2;
   end process;
 

   -- count_up process
   count_up_proc: process
   begin		
		wait for 10 ns;
		count_up <= '1';
		wait for 500 ns;
		count_up <= '0';
		wait for 100 ns;
		wait;
   end process;
	
	
	-- reset process
	rst_proc: process
	begin
		wait for 10 ns;
		rst_counter <= '1';
		wait for 10 ns;
		rst_counter <= '0';
		wait for 55 ns;
		rst_counter <= '1';
		wait for 55 ns;
		rst_counter <= '0';
		wait;
	end process;

END;
