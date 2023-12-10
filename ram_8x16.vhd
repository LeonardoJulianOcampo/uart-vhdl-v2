----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:28:37 12/02/2023 
-- Design Name: 
-- Module Name:    ram_8x16 - Behavioral 
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
use IEEE.Numeric_Std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ram_8x16 is
    Port ( address_i    : in  STD_LOGIC_VECTOR(2 downto 0);
           data_o       : out STD_LOGIC_VECTOR(7 downto 0);
           data_i       : in  STD_LOGIC_VECTOR(7 downto 0);
           write_enable : in  STD_LOGIC;
			  clk          : in  STD_LOGIC;
			  reset        : in  STD_LOGIC);
end ram_8x16;

architecture Behavioral of ram_8x16 is
   type ram_type is array (0 to (2**address_i'length)-1) of std_logic_vector(data_i'range);
   signal ram : ram_type := (others => (others => '0'));
   signal read_address : std_logic_vector(address_i'range):= (others => '0');

begin

  RamProc: process(clk) is

  begin
    if rising_edge(clk) then
		if reset = '1' then
			read_address <= (others => '0');
		else
			if write_enable = '1' then
			  ram(to_integer(unsigned(address_i))) <= data_i;
			end if;
			read_address <= address_i;
		end if;
    end if;
  end process RamProc;

  data_o <= ram(to_integer(unsigned(read_address)));



end Behavioral;