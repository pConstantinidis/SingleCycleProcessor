LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY MUX_tb IS
END MUX_tb;

ARCHITECTURE behavior OF MUX_tb IS
    SIGNAL Sel    : STD_LOGIC_VECTOR(4 downto 0);
    SIGNAL Inputs : STD_LOGIC_VECTOR(1023 downto 0); 
    SIGNAL OutMux : STD_LOGIC_VECTOR(31 downto 0);
BEGIN

    uut: ENTITY work.MUX
        PORT MAP (
            Sel => Sel,
            Inputs => Inputs,
            OutMux => OutMux
        );

    process
    BEGIN
        Sel <= "00000"; Inputs <= (others => '0'); WAIT FOR 10 ns;
        Sel <= "00001"; Inputs <= (others => '1'); WAIT FOR 10 ns;
        Sel <= "00010"; Inputs <= (others => '0'); WAIT FOR 10 ns;
        Sel <= "00011"; Inputs <= (others => '1'); WAIT FOR 10 ns;
        WAIT;
    END process;

END behavior;
