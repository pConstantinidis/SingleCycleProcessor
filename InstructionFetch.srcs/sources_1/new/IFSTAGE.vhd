----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2025 12:51:09 PM
-- Design Name: 
-- Module Name: IFSTAGE - Behavioral
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

entity IFSTAGE is
    Port ( clk      : in STD_LOGIC;
           load     : in STD_LOGIC;
           reset    : in STD_LOGIC;
           addr     : in STD_LOGIC_VECTOR (31 downto 0);
           instr    : out STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;


architecture Behavioral of IFSTAGE is
    signal pc_out   : STD_LOGIC_VECTOR (31 downto 0);

begin
    ProgramCounter: entity work.ProgramCounter
        port map (
            clk    => clk,
            reset  => reset,
            load   => load,
            addr   => addr,
            pc_out => pc_out
        );
        
    Intruction_rom: entity work.Instruction_rom
        port map (
            addr => pc_out,
            dout => instr  
        );

end Behavioral;
