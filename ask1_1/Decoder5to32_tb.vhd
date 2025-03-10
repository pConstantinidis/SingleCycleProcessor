library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Decoder5to32_tb is
end Decoder5to32_tb;

architecture Behavioral of Decoder5to32_tb is
    -- Component Declaration for the Unit Under Test (UUT)
    component Decoder5to32
        Port (
            Input  : in  STD_LOGIC_VECTOR(4 downto 0);
            Output_Decoder : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    -- Signals for the UUT
    signal Input  : STD_LOGIC_VECTOR(4 downto 0);
    signal Output_Decoder : STD_LOGIC_VECTOR(31 downto 0);

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: Decoder5to32
        port map (
            Input => Input,
            Output_Decoder => Output_Decoder
        );

    -- Test process
    process
    begin
        -- Initialize Inputs
        Input <= "10000"; -- Test case: Input is 0 (should activate Output_Decoder(0))
        wait for 10 ns;
        Input <= "11111"; -- Test case: Input is 0 (should activate Output_Decoder(0))
        wait for 10 ns;
        Input <= "00111"; -- Test case: Input is 0 (should activate Output_Decoder(0))
        wait for 10 ns;
        -- End the simulation
        wait;
    end process;

end Behavioral;
