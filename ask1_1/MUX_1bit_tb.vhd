library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_1bit_tb is
end MUX_1bit_tb;

architecture Behavioral of MUX_1bit_tb is

    -- Component declaration
    component MUX_1bit
        Port (
            Sel          : in  STD_LOGIC;
            Din          : in  STD_LOGIC_VECTOR(31 downto 0);
            Dout_original: in  STD_LOGIC_VECTOR(31 downto 0);
            Dout1        : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    -- Signals for the testbench
    signal Sel          : STD_LOGIC := '0';                          -- Selector input
    signal Din          : STD_LOGIC_VECTOR(31 downto 0) := (others => '0'); -- Data input (32-bit)
    signal Dout_original: STD_LOGIC_VECTOR(31 downto 0) := (others => '1'); -- Original data input (32-bit)
    signal Dout1        : STD_LOGIC_VECTOR(31 downto 0);             -- Output (32-bit)

begin

    -- Instantiate the MUX_1bit component
    MUX_1bit_inst: MUX_1bit
        Port map (
            Sel          => Sel,
            Din          => Din,
            Dout_original=> Dout_original,
            Dout1        => Dout1
        );

    -- Stimulus process
    stimulus: process
    begin
        -- Test case 1: When Sel = '0', Dout1 should be equal to Dout_original
        Sel <= '0';
        Din <= "10101010101010101010101010101010";  -- Random data for Din
        Dout_original <= "11111111111111111111111111111111";  -- Random data for Dout_original
        wait for 10 ns;  -- Wait for the process to finish
        
        -- Test case 2: When Sel = '1', Dout1 should be equal to Din
        Sel <= '1';
        Din <= "01010101010101010101010101010101";  -- Different random data for Din
        Dout_original <= "11111111111111111111111111111111";  -- Same original data
        wait for 10 ns;  -- Wait for the process to finish

        -- Test case 3: When Sel = '0', Dout1 should still be equal to Dout_original
        Sel <= '0';
        Din <= "00000000000000000000000000000000";  -- All zeros for Din
        Dout_original <= "00000000000000000000000000000001";  -- All zeros for Dout_original
        wait for 10 ns;  -- Wait for the process to finish

        -- Test case 4: When Sel = '1', Dout1 should be equal to Din (different value)
        Sel <= '1';
        Din <= "11110000111100001111000011110000";  -- Another random value for Din
        Dout_original <= "00001111000011110000111100001111";  -- Another value for Dout_original
        wait for 10 ns;  -- Wait for the process to finish

        -- End the simulation
        wait;
    end process;

end Behavioral;
