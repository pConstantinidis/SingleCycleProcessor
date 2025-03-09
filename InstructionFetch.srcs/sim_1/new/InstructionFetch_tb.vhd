library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IFSTAGE_TB is
end IFSTAGE_TB;

architecture Behavioral of IFSTAGE_TB is
    -- Signals for the IFSTAGE entity
    signal clk      : STD_LOGIC := '0';
    signal load     : STD_LOGIC := '0';
    signal reset    : STD_LOGIC := '0';
    signal addr     : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal instr    : STD_LOGIC_VECTOR(31 downto 0);

    -- Clock period definition
    constant CLK_PERIOD : time := 10 ns; -- 100 MHz clock
begin
    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.IFSTAGE
        port map (
            clk   => clk,
            load  => load,
            reset => reset,
            addr  => addr,
            instr => instr
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

        load <= '1';
        addr <= b"00000000000000000000_0000000001_00";
        wait for CLK_PERIOD;
        load <= '0';

        -- Should not load
        addr <= b"00000000000000000000_0000000010_00";
        wait for CLK_PERIOD;
        
        load <= '1';
        addr <= b"00000000000000000000_0000000010_00";
        wait for CLK_PERIOD;
        load <= '0';

        wait;
    end process;
end Behavioral;