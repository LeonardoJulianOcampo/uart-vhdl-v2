--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:58:43 12/09/2023
-- Design Name:   
-- Module Name:   /home/leo/projects/UTN/tecnicas-digitales-iii/TP4-UART/tp4/uart_v2/rx_v2/rx_v2/TB_RAM.vhd
-- Project Name:  rx_v2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ram_8x16
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
 
ENTITY TB_RAM IS
END TB_RAM;
 
ARCHITECTURE behavior OF TB_RAM IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
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
    

   --Inputs
   signal address_i : std_logic_vector(2 downto 0) := (others => '0');
   signal data_i : std_logic_vector(7 downto 0) := (others => '0');
   signal write_enable : std_logic := '0';
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal data_o : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ram_8x16 PORT MAP (
          address_i => address_i,
          data_o => data_o,
          data_i => data_i,
          write_enable => write_enable,
          clk => clk,
          reset => reset
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
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
		write_enable <= '0';
		address_i <= "000";
		data_i <= "00000011";
		wait for 23 ns;
		write_enable <= '1';
		address_i <= "000";
		data_i <= "00000001";
		wait for 10 ns;
		write_enable <= '1';
		address_i <= "001";
		data_i <= "00000111";
		wait for 10 ns;
		write_enable <= '1';
		address_i <= "001";
		data_i <= "00000111";
		wait;
   end process;

END;
