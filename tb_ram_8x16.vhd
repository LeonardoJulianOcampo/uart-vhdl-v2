--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:40:51 12/02/2023
-- Design Name:   
-- Module Name:   /home/leo/projects/UTN/tecnicas-digitales-iii/TP4-UART/tp4/uart_v2/rx_v2/rx_v2/tb_ram_8x16.vhd
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testbench_ram_8x16 is
-- No ports
end testbench_ram_8x16;

architecture Behavioral of testbench_ram_8x16 is
    signal address_i_tb    : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal data_i_tb       : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
    signal write_enable_tb : STD_LOGIC := '0';
    signal data_o_tb       : STD_LOGIC_VECTOR(7 downto 0);

    component ram_8x16
        Port ( 
            address_i : in  STD_LOGIC_VECTOR(3 downto 0);
            data_o    : out STD_LOGIC_VECTOR(7 downto 0);
            data_i    : in  STD_LOGIC_VECTOR(7 downto 0);
            write_enable : in  STD_LOGIC
        );
    end component;

begin
    uut: ram_8x16
        port map (address_i => address_i_tb,
                  data_o    => data_o_tb,
                  data_i    => data_i_tb,
                  write_enable => write_enable_tb);

    process
    begin
        -- Test write operation
        write_enable_tb <= '1';
        data_i_tb <= "10101010";
        address_i_tb <= "0010"; -- Write to address 2
        wait for 10 ns;

        -- Test read operation
        write_enable_tb <= '0';
        address_i_tb <= "0010"; -- Read from address 2
        wait for 10 ns;

        -- Add more test cases as needed
		  
		  write_enable_tb <= '1';
		  address_i_tb <= "0000";
		  data_i_tb <= "11111111";
		  wait for 10 ns;
		  
		  write_enable_tb <= '0';
		  address_i_tb <= "0000";
		  data_i_tb <= "00000000";
		  wait for 10 ns;

        wait;
    end process;

end Behavioral;