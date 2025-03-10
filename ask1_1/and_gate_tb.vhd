library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity and_gate_tb is
end and_gate_tb;

architecture Behavioral of and_gate_tb is
    -- Component Declaration for the Unit Under Test (UUT)
    component and_gate
        Port (
            a : in STD_LOGIC;
            b : in STD_LOGIC;
            z : out STD_LOGIC
        );
    end component;

    -- Signals for the UUT
    signal a : STD_LOGIC;
    signal b : STD_LOGIC;
    signal z : STD_LOGIC;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: and_gate
        port map (
            a => a,
            b => b,
            z => z
        );

    -- Test process
    process
    begin
        -- Apply test vectors
        a <= '0'; b <= '0';  -- Test case 1: 0 AND 0
        wait for 10 ns;

        a <= '0'; b <= '1';  -- Test case 2: 0 AND 1
        wait for 10 ns;

        a <= '1'; b <= '0';  -- Test case 3: 1 AND 0
        wait for 10 ns;

        a <= '1'; b <= '1';  -- Test case 4: 1 AND 1
        wait for 10 ns;

        -- End the simulation
        wait;
    end process;

end Behavioral;
