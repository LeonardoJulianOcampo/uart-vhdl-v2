--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:46:51 11/26/2023
-- Design Name:   
-- Module Name:   /home/leo/projects/UTN/tecnicas-digitales-iii/TP4-UART/tp4/uart_v2/rx_v2/rx_v2/tb_data_register.vhd
-- Project Name:  rx_v2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: data_register
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
 
ENTITY tb_data_register IS
END tb_data_register;
 
ARCHITECTURE behavior OF tb_data_register IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT data_register
    PORT(
         clk_baud_rate : IN  std_logic;
         ena_reg : IN  std_logic;
         rx : IN  std_logic;
         sys_clk : IN  std_logic;
         data_readed : OUT  std_logic_vector(7 downto 0);
         data_out : OUT  std_logic_vector(7 downto 0);
         data_ok : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_baud_rate : std_logic := '0';
   signal ena_reg : std_logic := '0';
   signal rx : std_logic := '0';
   signal sys_clk : std_logic := '0';

 	--Outputs
   signal data_readed : std_logic_vector(7 downto 0);
   signal data_out : std_logic_vector(7 downto 0);
   signal data_ok : std_logic;

   -- Clock period definitions
   constant clk_baud_rate_period : time := 0.124 ms;
   constant sys_clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: data_register PORT MAP (
          clk_baud_rate => clk_baud_rate,
          ena_reg => ena_reg,
          rx => rx,
          sys_clk => sys_clk,
          data_readed => data_readed,
          data_out => data_out,
          data_ok => data_ok
        );

   -- Clock process definitions
   clk_baud_rate_process :process
   begin
		clk_baud_rate <= '0';
		wait for clk_baud_rate_period/2;
		clk_baud_rate <= '1';
		wait for clk_baud_rate_period/2;
   end process;
 
   sys_clk_process :process
   begin
		sys_clk <= '0';
		wait for sys_clk_period/2;
		sys_clk <= '1';
		wait for sys_clk_period/2;
   end process;
	
	enable_proc: process
	begin
		wait for 100 ns;
		ena_reg <= '1';
		wait;
	end process;
	

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_baud_rate_period*10;

      rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '1';
		wait for clk_baud_rate_period * 10;
		rx <= '0';
		wait for clk_baud_rate_period * 10;
		rx <= '1';


      wait;
   end process;

END;
