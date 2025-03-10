library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MUX is
    Port (
        Sel    : in  STD_LOGIC_VECTOR(4 downto 0);
        Inputs : in  STD_LOGIC_VECTOR(32*32-1 downto 0);
        OutMux : out STD_LOGIC_VECTOR(31 downto 0)
    );
end MUX;

architecture Behavioral of MUX is
begin

        OutMux <= Inputs(to_integer(unsigned(Sel)) * 32 + 31 downto to_integer(unsigned(Sel)) * 32);
		  
end Behavioral;
