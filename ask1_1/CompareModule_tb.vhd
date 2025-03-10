library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CompareModule_tb is
end CompareModule_tb;

architecture Behavioral of CompareModule_tb is

    -- Component declaration for the CompareModule
    component CompareModule_1
        Port (
            WrEn  : in  STD_LOGIC;                        -- Write Enable
            Awr   : in  STD_LOGIC_VECTOR(4 downto 0);     -- Write address (5-bit)
            Ard1  : in  STD_LOGIC_VECTOR(4 downto 0);     -- Read address 1 (5-bit)
            Din   : in  STD_LOGIC_VECTOR(31 downto 0);    -- Data input (32-bit)
            Sel   : out STD_LOGIC                         -- Selector output (1-bit)
        );
    end component;

    -- Signals for the testbench
    signal WrEn  : STD_LOGIC := '0';                        -- Write Enable input
    signal Awr   : STD_LOGIC_VECTOR(4 downto 0) := "00000";  -- Write address (5-bit)
    signal Ard1  : STD_LOGIC_VECTOR(4 downto 0) := "00000";  -- Read address 1 (5-bit)
    signal Din   : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');  -- Data input (32-bit)
    signal Sel   : STD_LOGIC;                                 -- Selector output

begin

    -- Instantiate the CompareModule component
    CompareModule_inst: CompareModule_1
        Port map (
            WrEn  => WrEn,
            Awr   => Awr,
            Ard1  => Ard1,
            Din   => Din,
            Sel   => Sel
        );

    -- Stimulus process to apply different test cases
    stimulus: process
    begin

        WrEn <= '0'; 
        Awr  <= "00001";  -- Arbitrary address for Write
        Ard1 <= "00001";  -- Read address 1
        Din  <= "10101010101010101010101010101010";  -- Data input
        wait for 10 ns;  -- Wait for the process to finish

        WrEn <= '1';
        Awr  <= "00001";  -- Write address
        Ard1 <= "00001";  -- Read address 1 matches Awr
        Din  <= "10101010101010101010101010101010";  -- Data input
        wait for 10 ns;  -- Wait for the process to finish

        WrEn <= '1';
        Awr  <= "00001";  -- Write address
        Ard1 <= "00000";  -- Read address 1 doesn't match Awr
        Din  <= "11001100110011001100110011001100";  -- Data input
        wait for 10 ns;  -- Wait for the process to finish

        WrEn <= '1';
        Awr  <= "00001";  -- Write address
        Ard1 <= "00010";  -- Read address 1 doesn't match Awr
        Din  <= "00110011001100110011001100110011";  -- Data input
        wait for 10 ns;  -- Wait for the process to finish

        WrEn <= '1';
        Awr  <= "00001";  -- Write address
        Ard1 <= "00001";  -- Read address 1 matches Awr
        Din  <= "11110000111100001111000011110000";  -- Data input
        wait for 10 ns;  -- Wait for the process to finish

        WrEn <= '0';
        Awr  <= "00010";  -- Write address
        Ard1 <= "00001";  -- Read address 1
        Din  <= "11110000111100001111000011110000";  -- Data input
        wait for 10 ns;  -- Wait for the process to finish

        wait;
    end process;

end Behavioral;
