----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2025 06:11:25 PM
-- Design Name: 
-- Module Name: Instruction_rom - Behavioral
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


entity Instruction_rom is
    Port ( addr : in STD_LOGIC_VECTOR (31 downto 0);
           dout : out STD_LOGIC_VECTOR (31 downto 0));
end Instruction_rom;

architecture dataflow of Instruction_rom is
    signal addr_inter  : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
begin
    addr_inter <= addr(11 downto 2);

    rom: entity work.dist_mem_gen_0
        port map (
            a   => addr_inter,
            spo => dout
        );
end dataflow;
