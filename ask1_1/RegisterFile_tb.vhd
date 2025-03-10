library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RegisterFile_tb is
end RegisterFile_tb;

architecture behavior of RegisterFile_tb is

    -- Signals for the DUT (Device Under Test)
    signal CLK   : STD_LOGIC := '0';
    signal WrEn  : STD_LOGIC := '0';
    signal Ard1  : STD_LOGIC_VECTOR(4 downto 0) := "00000";
    signal Ard2  : STD_LOGIC_VECTOR(4 downto 0) := "00000";
    signal Awr   : STD_LOGIC_VECTOR(4 downto 0) := "00000";
    signal Din   : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal Dout1 : STD_LOGIC_VECTOR(31 downto 0);
    signal Dout2 : STD_LOGIC_VECTOR(31 downto 0);

    -- Component declaration of the RegisterFile
    component RegisterFile
        Port (
            CLK   : in  STD_LOGIC;
            WrEn  : in  STD_LOGIC;
            Ard1  : in  STD_LOGIC_VECTOR(4 downto 0);
            Ard2  : in  STD_LOGIC_VECTOR(4 downto 0);
            Awr   : in  STD_LOGIC_VECTOR(4 downto 0);
            Din   : in  STD_LOGIC_VECTOR(31 downto 0);
            Dout1 : out STD_LOGIC_VECTOR(31 downto 0);
            Dout2 : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

begin

    clk_process: process
    begin
        CLK <= '0';
        wait for 10 ns;
        CLK <= '1';
        wait for 10 ns;
    end process clk_process;

    uut: RegisterFile
        port map (
            CLK   => CLK,
            WrEn  => WrEn,
            Ard1  => Ard1,
            Ard2  => Ard2,
            Awr   => Awr,
            Din   => Din,
            Dout1 => Dout1,
            Dout2 => Dout2
        );


    process
    begin

        wait for 20 ns;
		  WrEn <= '1';

        Ard1 <= "00100";
        Ard2 <= "00100";
        Awr <= "00000";
        Din <= (others => '0');

		  -- Respond in 1 CLK
		  
        wait for 20 ns;
		  
        Awr <= "00001"; 
		  Ard1 <= "00011"; 
        Din <= "00000000000000000000000000000011";
        WrEn <= '1';
		  
        wait for 20 ns;
		  
		  Awr <= "00000"; 
		  Ard1 <= "00001"; 

		  wait for 20 ns;
		  
        Awr <= "10001"; 
		  Ard2 <= "10000"; 
        Din <= "10000000000000000000000000000011";
        WrEn <= '1';
		  
        wait for 20 ns;
		  
		  Awr <= "00000"; 
		  Ard2 <= "10001"; 

		  -- Check if Register has Memory

		  Ard1 <= "00011"; 
		  
        wait for 20 ns;

		  Ard1 <= "10001"; 
		  
        wait for 20 ns;
		  
		  -- Check if WrEn works
		  
        WrEn <= '0';
		  Awr <= "10101"; 
		  Ard2 <= "10101"; 
        Din <= "11000000000000000000000000000011";
		  wait for 20 ns;

		  -- Now Write
		  
        WrEn <= '1';
		  wait for 20 ns;
		  
		  -- Check Register 0

        WrEn <= '1';
		  Awr <= "00000"; 
		  Ard1 <= "00000"; 
		  Ard2 <= "00000"; 
        Din <= "11000000000000000000000000000011";
		  wait for 20 ns;
		  
		  Awr <= "00011"; 
		  wait for 20 ns;
		  -- Check Read and Write at the same time

        WrEn <= '1';
		  Awr <= "00111"; 
		  Ard1 <= "00111"; 
        Din <= "11100000000000000000000000000011";
		  wait for 20 ns;		  
		  
		  WrEn <= '1';
		  Awr <= "10111"; 
		  Ard2 <= "10111"; 
        Din <= "00100000000000000000000000000011";
		  wait for 20 ns;	
		  
        wait;
    end process;

end behavior;
