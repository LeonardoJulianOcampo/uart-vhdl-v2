----------------------------------------------------------------------------------
-- Company: 
-- Autor: Ocampo Leonardo 
-- 
-- Create Date:    15:29:58 11/26/2023 
-- Design Name: 
-- Module Name:    data_register - Behavioral 
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


entity data_register is
    Port ( 
        clk_baud_rate : in STD_LOGIC;            -- Reloj para la tasa de baudios
        ena_reg       : in STD_LOGIC;            -- Habilitación para leer la señal rx
        rx            : in STD_LOGIC;            -- Señal de entrada rx
        sys_clk       : in STD_LOGIC;            -- Reloj del sistema
        data_readed   : out STD_LOGIC_VECTOR(7 downto 0);  -- Dato leído desde la FIFO
        data_out      : out STD_LOGIC_VECTOR(7 downto 0);  -- Salida de datos
        data_ok       : out STD_LOGIC              -- Indicador de datos válidos
			 );
end data_register;

architecture Behavioral of data_register is
    constant FIFO_DEPTH : integer := 8;  -- Profundidad de la FIFO

    type FIFO_Type is array (0 to FIFO_DEPTH-1) of STD_LOGIC_VECTOR(7 downto 0);
    signal fifo : FIFO_Type := (others => (others => '0'));  -- Inicializar FIFO con ceros
    signal head : integer := 0;  -- Puntero al primer elemento de la FIFO
    signal tail : integer := 0;  -- Puntero al próximo espacio disponible en la FIFO
begin
    process(sys_clk)
    begin
        if rising_edge(sys_clk) then
            -- Si ena_reg y clk_baud_rate son ambos activos, leer datos desde rx
            if ena_reg = '1' and clk_baud_rate = '1' then
                fifo(tail) <= rx & fifo(tail)(7 downto 1);
                tail <= (tail + 1) mod FIFO_DEPTH;
            end if;

            -- Comprobar si la FIFO está llena y actualizar las salidas correspondientes
            if (tail - head) mod FIFO_DEPTH = FIFO_DEPTH - 1 then
                data_ok <= '1';        -- FIFO llena, datos válidos
                data_out <= fifo(head);  -- Salida de datos desde la FIFO
                head <= (head + 1) mod FIFO_DEPTH;
            else
                data_ok <= '0';  -- FIFO no llena, datos no válidos
            end if;
        end if;
    end process;


end Behavioral;

