--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:45:54 11/26/2023
-- Design Name:   
-- Module Name:   /home/leo/projects/UTN/tecnicas-digitales-iii/TP4-UART/tp4/uart_v2/rx_v2/rx_v2/tb_baud_rate_clk.vhd
-- Project Name:  rx_v2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: baud_rate_clk
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
 
ENTITY tb_baud_rate_clk IS
END tb_baud_rate_clk;
 
ARCHITECTURE behavior OF tb_baud_rate_clk IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT baud_rate_clk
    PORT(
         system_clk     : IN  std_logic;
         clk_gen_enable : IN  std_logic;
         rst            : IN  std_logic;
         clk_baud_rate  : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal system_clk     : std_logic := '0';
   signal clk_gen_enable : std_logic := '0';
   signal rst            : std_logic := '0';

 	--Outputs
   signal clk_baud_rate : std_logic;

   -- Clock period definitions
   constant system_clk_period : time := 20 ns;

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: baud_rate_clk PORT MAP (
          system_clk => system_clk,
          clk_gen_enable => clk_gen_enable,
          rst => rst,
          clk_baud_rate => clk_baud_rate
        );

   -- Clock process definitions
   system_clk_process :process
   begin
		system_clk <= '0';
		wait for system_clk_period/2;
		system_clk <= '1';
		wait for system_clk_period/2;
   end process;

   -- Stimulus process
	count_up_process: process
	begin
		wait for 300 ns;
		clk_gen_enable <= '1';
		wait for 300 ns;
		clk_gen_enable <= '0';
		wait for 1000 ns;
		clk_gen_enable <= '1';
		wait;
	end process;
	
	rst_process: process
	begin
		wait for 32 ns;
		rst <= '1';
		wait for 27 ns;
		rst <= '0';
		wait;
	end process;


END;
