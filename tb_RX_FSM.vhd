--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:06:59 11/25/2023
-- Design Name:   
-- Module Name:   /home/leo/projects/UTN/tecnicas-digitales-iii/TP4-UART/tp4/uart_v2/rx_v2/rx_v2/tb_RX_FSM.vhd
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
 
ENTITY tb_RX_FSM IS
END tb_RX_FSM;
 
ARCHITECTURE behavior OF tb_RX_FSM IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RX_FSM
    PORT(
         EN_REG : OUT  std_logic;
         EN_COUNTER : OUT  std_logic;
         RST_COUNTER : OUT  std_logic;
         CLK_GEN_ENA : OUT  std_logic;
         COUNT_UP : OUT  std_logic;
         RESET : IN  std_logic;
         SYSTEM_CLK : IN  std_logic;
         RX : IN  std_logic;
         COUNT_MAX : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal RESET : std_logic := '1';
   signal SYSTEM_CLK : std_logic := '0';
   signal RX : std_logic := '1';
   signal COUNT_MAX : std_logic := '0';

 	--Outputs
   signal EN_REG : std_logic;
   signal EN_COUNTER : std_logic;
   signal RST_COUNTER : std_logic;
   signal CLK_GEN_ENA : std_logic;
   signal COUNT_UP : std_logic;

   -- Clock period definitions
   constant SYSTEM_CLK_period : time := 20 ns;
	constant rx_period : time := 1.24 ms;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RX_FSM PORT MAP (
          EN_REG => EN_REG,
          EN_COUNTER => EN_COUNTER,
          RST_COUNTER => RST_COUNTER,
          CLK_GEN_ENA => CLK_GEN_ENA,
          COUNT_UP => COUNT_UP,
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
   rx_proc: process
   begin		
      -- hold reset state for 100 ns.
      RX <= '1';
		wait for 300 ns;
		RX <= '0';  --bit de start
		wait for rx_period/2;
		RX <= '1';  --bit 0
		wait for rx_period/2;
		RX <= '1';  --bit 1
		wait for rx_period/2;
		RX <= '0';  --bit 2
		wait for rx_period/2;
		RX <= '1';  --bit 3
		wait for rx_period/2;
		RX <= '1';  -- bit 4
		wait for rx_period/2;
		RX <= '0';  -- bit 5
		wait for rx_period/2;
		RX <= '1';  -- bit 6
		wait for rx_period/2;
		RX <= '0';  -- bit 7
		wait for rx_period/2;
		RX <= '1';  -- bit stop
		wait for rx_period/2;
      -- insert stimulus here 
   end process;
	
    process 
	 begin
        wait for 137 ns;
        RESET <= '1';
        wait for 10 ns;
		  RESET <= '0';
		  wait ;
	 end process;
	 
	 process
	 begin
		wait for 6820590 ns;
		COUNT_MAX <= '1';
	 end process;

END;
