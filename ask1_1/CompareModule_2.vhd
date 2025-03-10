library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CompareModule_2 is
    Port (
        WrEn  : in  STD_LOGIC;                        -- Write Enable
        Awr   : in  STD_LOGIC_VECTOR(4 downto 0);     -- Write address (5-bit)
        Ard2  : in  STD_LOGIC_VECTOR(4 downto 0);     -- Read address 1 (5-bit)
        Din   : in  STD_LOGIC_VECTOR(31 downto 0);    -- Data input (32-bit)
        Sel   : out STD_LOGIC                         -- Selector output (1-bit)
    );
end CompareModule_2;

architecture Behavioral of CompareModule_2 is
begin
    process(WrEn, Awr, Ard2)
    begin
        if WrEn = '1' then

            if Ard2 = Awr and Ard2 /= "00000" then
                Sel <= '1';  
            else
                Sel <= '0';  
            end if;
        else
            Sel <= '0';  
        end if;
		  
    end process;
end Behavioral;
