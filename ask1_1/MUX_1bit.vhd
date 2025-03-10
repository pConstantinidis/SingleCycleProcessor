library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_1bit is
    Port (
        Sel          : in  STD_LOGIC;                 -- 1-bit selector
        Din          : in  STD_LOGIC_VECTOR(31 downto 0);  -- Data input (32-bit)
        Dout_original: in  STD_LOGIC_VECTOR(31 downto 0);  -- Original data input (32-bit)
        Dout1        : out STD_LOGIC_VECTOR(31 downto 0)   -- Output (32-bit)
    );
end MUX_1bit;

architecture Behavioral of MUX_1bit is
begin

    process(Sel, Din, Dout_original)
    begin
        if Sel = '1' then
            Dout1 <= Din;  -- Select Din if Sel is 1
        else
            Dout1 <= Dout_original;  -- Select Dout_original if Sel is 0
        end if;
		  
    end process;
end Behavioral;
