library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU_TB is
end ALU_TB;

architecture testbench of ALU_TB is
    component ALU
        port (
            A, B : in STD_LOGIC_VECTOR (31 downto 0);
            Op : in STD_LOGIC_VECTOR (3 downto 0);
            Out1 : out STD_LOGIC_VECTOR (31 downto 0);
            Zero : out STD_LOGIC;
            Cout : out STD_LOGIC;
            Ovf : out STD_LOGIC
        );
    end component;
    
    signal A, B, Out1 : STD_LOGIC_VECTOR (31 downto 0);
    signal Op : STD_LOGIC_VECTOR (3 downto 0);
    signal Zero, Cout, Ovf : STD_LOGIC;

begin
    uut: ALU port map (
        A => A, B => B, Op => Op,
        Out1 => Out1, Zero => Zero, Cout => Cout, Ovf => Ovf
    );

    process
    begin
	 
	 	  wait for 1 ns;
		  
		  -- Normal Operation
	     
		  A <= x"00000000";
		  B <= x"00000000";
        Op <= "0000";
        wait for 10 ns;

        A <= x"00000010";
        B <= x"00000010";
        Op <= "0000";
        wait for 10 ns;
		  
        A <= x"00000010";
        B <= x"01001000";
        Op <= "0000";
        wait for 10 ns;
		  
        A <= x"00000005";
        B <= x"00000003";
        Op <= "0001";
        wait for 10 ns;

        A <= x"0F0F0F0F";
        B <= x"00FF00FF";
        Op <= "0010";
        wait for 10 ns;

        A <= x"0F0F0F0F";
        B <= x"00FF00FF";
        Op <= "0011";
        wait for 10 ns;

        A <= x"FFFFFF00";
        B <= x"00000000";
        Op <= "0100";
        wait for 10 ns;

        A <= x"80000000"; -- 8 = "1000", c = "1100"
        Op <= "1000";
        wait for 10 ns;

        A <= x"80000000";
        Op <= "1001";
        wait for 10 ns;

        A <= x"00000001";
        Op <= "1010";
        wait for 10 ns;

        A <= x"F0000000";
        Op <= "1100";
        wait for 10 ns;

        A <= x"0000000F";
        Op <= "1101";
        wait for 10 ns;
		  
		  -- Zero
		  
        A <= x"000000F0";
        B <= x"000000F0";
        Op <= "0001";
        wait for 10 ns;

		  -- Overflow
		  
        A <= x"40000000";
        B <= x"40000000";
        Op <= "0000";
        wait for 10 ns;
		  
		  -- Cout
		  
        A <= x"F0000000";
        B <= x"F0000000";
        Op <= "0000";
        wait for 10 ns;
		  
		  
wait for 100 ns;
report "Simulation completed." severity failure;

        wait;
    end process;
end testbench;
