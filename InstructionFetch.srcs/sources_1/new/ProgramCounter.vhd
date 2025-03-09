----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2025 12:13:52 PM
-- Design Name: 
-- Module Name: ProgramCounter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ProgramCounter is
  Port (
    clk     : IN std_logic;
    reset   : IN std_logic;
    load    : IN std_logic;         -- Enables read to the PC
    addr    : IN std_logic_vector(31 downto 0);     -- The input adress
    pc_out  : OUT std_logic_vector(31 downto 0)
  );
end ProgramCounter;


architecture Behavioral of ProgramCounter is
    signal pc_reg   : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
begin
    process(clk, reset)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                pc_reg <= (others => '0');      -- ????                
            elsif load = '1' then
                pc_reg <= addr;
            end if;
        end if;
    end process;
    
    pc_out <= pc_reg;
end Behavioral;
