--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:56:07 12/03/2023
-- Design Name:   
-- Module Name:   /home/leo/projects/UTN/tecnicas-digitales-iii/TP4-UART/tp4/uart_v2/rx_v2/rx_v2/tb_top_fifo_v2.vhd
-- Project Name:  rx_v2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top_fifo_v2
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
 
ENTITY tb_top_fifo_v2 IS
END tb_top_fifo_v2;
 
ARCHITECTURE behavior OF tb_top_fifo_v2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top_fifo_v2
    PORT(
         clk      : IN   std_logic;
         push     : IN   std_logic;
         pop      : IN   std_logic;
         init     : IN   std_logic;
         data_in  : IN   std_logic_vector(7 downto 0);
         data_out : OUT  std_logic_vector(7 downto 0);
         full     : buffer  std_logic;
         empty    : buffer  std_logic;
         nopush   : buffer  std_logic;
         nopop    : buffer  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal push : std_logic := '0';
   signal pop : std_logic := '0';
   signal init : std_logic := '0';
   signal data_in : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal data_out : std_logic_vector(7 downto 0);
   signal full : std_logic;
   signal empty : std_logic;
   signal nopush : std_logic;
   signal nopop : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top_fifo_v2 PORT MAP (
          clk => clk,
          push => push,
          pop => pop,
          init => init,
          data_in => data_in,
          data_out => data_out,
          full => full,
          empty => empty,
          nopush => nopush,
          nopop => nopop
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   init_proc: process
   begin		
      wait for 1 ns;
		init <= '1';
		wait for 23 ns;
		init <= '0';
      wait;
   end process;
	
	data_write: process
	begin
		wait for 25 ns;
		data_in <= "00000001";
		wait for 50 ns;
		data_in <= "00000011";
	end process;
	
	push_proc: process
	begin
		wait for 25 ns;
		push <= '1';
		wait for 20 ns;
		push <= '0';
		wait for 39 ns;
		push <= '1';
		wait for 20 ns;
		push <= '0';
	end process;
	
	stop_sim: process
	begin
		wait for 1000 ns;
		assert false report "Fin de la simulación después de 1000 ns" severity FAILURE;
	end process;
	
END;
