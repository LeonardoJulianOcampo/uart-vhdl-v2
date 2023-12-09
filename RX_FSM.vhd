----------------------------------------------------------------------------------
-- Company: 
-- Autor: Leonardo Julian Ocampo 
-- 
-- Create Date:    15:04:45 11/25/2023 
-- Design Name: 
-- Module Name:    RX_FSM - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;


entity RX_FSM is
--generic (
--   <generic_name> : <type> := <value>;
--   <other generics>...    
--);
port (
--   <port_name> : <mode> <type>;
--   <other ports>...
	EN_REG      : out std_logic;
	EN_COUNTER  : out std_logic;
	RST_COUNTER : out std_logic;
	CLK_GEN_ENA : out std_logic;
	COUNT_UP    : out std_logic;
	RESET       : in  std_logic;
	SYSTEM_CLK  : in  std_logic;
	RX          : in  std_logic;
	COUNT_MAX   : in  std_logic
);
end RX_FSM;

architecture Behavioral of RX_FSM is
   --Use descriptive names for the states, like st1_reset, st2_search
   type state_type is (st1_IDLE, st2_WAIT_START_END, st3_ENABLE_READ_COUNTER); 
   signal state, next_state : state_type; 
   --Declare internal signals for all outputs of the state-machine
   signal EN_REG_i      : std_logic := '0';
   signal EN_COUNTER_i  : std_logic := '0';
   signal RST_COUNTER_i : std_logic := '0';
   signal CLK_GEN_ENA_i : std_logic := '0';
   signal COUNT_UP_i    : std_logic := '0';
   signal RESET_i       : std_logic := '0';
   signal RX_i          : std_logic := '0';
	signal RX_start      : std_logic := '0';
	signal RX_start_end  : std_logic := '0';
   signal COUNT_MAX_i   : std_logic := '0';
	signal START_STOP    : std_logic := '0'; -- 0 stop 1 start
   --other outputs

begin
	
p_SAMPLE : process (SYSTEM_CLK)
		variable detector : std_logic_vector (1 downto 0);
	begin
		if rising_edge(SYSTEM_CLK) then
			if RESET = '1' then
				detector := "00";
			else
				RX_i <= RX;
				detector(1)     := detector(0);
				detector(0)     := RX_i;
				if detector = "01" then
					RX_start_end <= '0';
				elsif detector = "10" then
					RX_start     <= '1';
				else 
					RX_start_end <= '0';
					RX_start     <= '0';
				end if;
			end if;
		end if;
	end process p_SAMPLE;


   SYNC_PROC: process (SYSTEM_CLK)
   begin
      if (SYSTEM_CLK'event and SYSTEM_CLK = '1') then
         if (RESET = '1') then
            state       <= st1_IDLE;
            EN_REG      <= '0';
				EN_COUNTER  <= '0';
				RST_COUNTER <= '1';
				CLK_GEN_ENA <= '0';
				COUNT_UP    <= '0';
         else
            state <= next_state;
            --<output> <= <output>_i;
            EN_REG      <= EN_REG_i;
				EN_COUNTER  <= EN_COUNTER_i;
				RST_COUNTER <= RST_COUNTER_i;
				CLK_GEN_ENA <= CLK_GEN_ENA_i;
				COUNT_UP    <= COUNT_UP_i;
         -- assign other outputs to internal signals
         end if;        
      end if;
   end process;
	
	   --MOORE State-Machine - Outputs based on state only
   OUTPUT_DECODE: process (state)
   begin
      --insert statements to decode internal output signals
      --below is simple example
--      if state = st3_<name> then
--         <output>_i <= '1';
--      else
--         <output>_i <= '0';
--      end if;

		if state = st1_IDLE then
            EN_REG_i      <= '0';
				EN_COUNTER_i  <= '0';
				RST_COUNTER_i <= '1';
				CLK_GEN_ENA_i <= '0';
				COUNT_UP_i    <= '0';
		elsif state = st2_WAIT_START_END then
            EN_REG_i      <= '0';
				EN_COUNTER_i  <= '0';
				RST_COUNTER_i <= '1';
				CLK_GEN_ENA_i <= '0';
				COUNT_UP_i    <= '0';
		elsif state = st3_ENABLE_READ_COUNTER then
            EN_REG_i      <= '1';
				EN_COUNTER_i  <= '1';
				RST_COUNTER_i <= '0';
				CLK_GEN_ENA_i <= '1';
				COUNT_UP_i    <= '1';
		else
            EN_REG_i      <= '0';
				EN_COUNTER_i  <= '0';
				RST_COUNTER_i <= '1';
				CLK_GEN_ENA_i <= '0';
				COUNT_UP_i    <= '0';
		end if;
			
	
   end process;
 
   NEXT_STATE_DECODE: process (state, RX_start, RX_start_end, COUNT_MAX, SYSTEM_CLK, RESET)
   begin
      --declare default state for next_state to avoid latches
      next_state <= state;  --default is to stay in current state
      --insert statements to decode next_state
      --below is a simple example
--      case (state) is
--         when st1_<name> =>
--            if <input_1> = '1' then
--               next_state <= st2_<name>;
--            end if;
--         when st2_<name> =>
--            if <input_2> = '1' then
--               next_state <= st3_<name>;
--            end if;
--         when st3_<name> =>
--            next_state <= st1_<name>;
--         when others =>
--            next_state <= st1_<name>;
--      end case;  
   
		case (state) is
			when st1_IDLE =>
				if RX_start = '1' then
					next_state <= st2_WAIT_START_END;
				else
					next_state <= state;
				end if;
			when st2_WAIT_START_END =>
				if RX_start_end = '0' then
					next_state <= st3_ENABLE_READ_COUNTER;
				else
					next_state <= state;
				end if;
			when st3_ENABLE_READ_COUNTER =>
				if COUNT_MAX = '1' then
					next_state <= st1_IDLE;
				else
					next_state <= state;
				end if;
			when others =>
				next_state <= st1_IDLE;
		end case;
 
   end process;

end Behavioral;

