--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:04:22 11/25/2023
-- Design Name:   
-- Module Name:   /home/leo/projects/UTN/tecnicas-digitales-iii/TP4-UART/tp4/uart_v2/rx_v2/rx_v2/RX_FSM_TB.vhd
-- Project Name:  rx_v2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RX_FSM
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
 
ENTITY RX_FSM_TB IS
END RX_FSM_TB;
 
ARCHITECTURE behavior OF RX_FSM_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RX_FSM
    PORT(
         EN_REG : OUT  std_logic;
         EN_COUNTER : OUT  std_logic;
         RST_COUNTER : OUT  std_logic;
         CLK_GEN_ENA : OUT  std_logic;
         RESET : IN  std_logic;
         SYSTEM_CLK : IN  std_logic;
         RX : IN  std_logic;
         COUNT_MAX : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RESET : std_logic := '0';
   signal SYSTEM_CLK : std_logic := '0';
   signal RX : std_logic := '0';
   signal COUNT_MAX : std_logic := '0';

 	--Outputs
   signal EN_REG : std_logic;
   signal EN_COUNTER : std_logic;
   signal RST_COUNTER : std_logic;
   signal CLK_GEN_ENA : std_logic;

   -- Clock period definitions
   constant SYSTEM_CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RX_FSM PORT MAP (
          EN_REG => EN_REG,
          EN_COUNTER => EN_COUNTER,
          RST_COUNTER => RST_COUNTER,
          CLK_GEN_ENA => CLK_GEN_ENA,
          RESET => RESET,
          SYSTEM_CLK => SYSTEM_CLK,
          RX => RX,
          COUNT_MAX => COUNT_MAX
        );

   -- Clock process definitions

 
   SYSTEM_CLK_process :process
   begin
		SYSTEM_CLK <= '0';
		wait for SYSTEM_CLK_period/2;
		SYSTEM_CLK <= '1';
		wait for SYSTEM_CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_GEN_ENA_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
