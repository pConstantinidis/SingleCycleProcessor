library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ProgramCounter_TB is
end ProgramCounter_TB;

architecture Behavioral of ProgramCounter_TB is
    -- Signals for the ProgramCounter entity
    signal clk     : std_logic := '0';
    signal reset   : std_logic := '0';
    signal load    : std_logic := '0';
    signal addr    : std_logic_vector(9 downto 0) := (others => '0');
    signal pc_out  : std_logic_vector(9 downto 0);

    -- Clock period definition
    constant CLK_PERIOD : time := 10 ns; -- 100 MHz clock
begin
    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.ProgramCounter
        port map (
            clk    => clk,
            reset  => reset,
            load   => load,
            addr   => addr,
            pc_out => pc_out
        );

    -- Clock generation process
    clk_process: process
    begin
        clk <= '0';
        wait for CLK_PERIOD / 2;
        clk <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        reset <= '1';
        wait for CLK_PERIOD * 5;
        reset <= '0';
        wait for CLK_PERIOD;

        load <= '1';
        addr <= "0000000001"; -- Load address 0x00001000
        wait for CLK_PERIOD;
        load <= '0'; -- Disable load
        wait for CLK_PERIOD;

        -- Loading should fail
        addr <= "0000000010"; -- Load address 0x00002000
        wait for CLK_PERIOD;

        wait;
    end process;
end Behavioral;
