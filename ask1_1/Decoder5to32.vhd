library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Decoder5to32 is
    Port (
        Input  : in  STD_LOGIC_VECTOR(4 downto 0);  -- 5-bit input
        Output_Decoder : out STD_LOGIC_VECTOR(31 downto 0)  -- 32-bit one-hot output
    );
end Decoder5to32;

architecture Behavioral of Decoder5to32 is
begin
    process(Input)
    begin
        -- Set all output bits to '0'
        Output_Decoder <= (others => '0');
        
        -- Set the bit corresponding to the input value to '1'
        Output_Decoder(to_integer(unsigned(Input))) <= '1';
    end process;
end Behavioral;
