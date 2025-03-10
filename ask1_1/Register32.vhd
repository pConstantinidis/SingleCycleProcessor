library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Register32 is
    Port (
        CLK   : in  STD_LOGIC;                        
        WE    : in  STD_LOGIC;                        
        Data  : in  STD_LOGIC_VECTOR(31 downto 0);    
        Dout  : out STD_LOGIC_VECTOR(31 downto 0)     
    );
end Register32;

architecture Behavioral of Register32 is
    signal reg : STD_LOGIC_VECTOR(31 downto 0) := (others => '0'); 

begin
    process
    begin
	 
	     wait until CLK'EVENT AND CLK = '1';
            
				if WE = '1' then
                reg <= Data;  
            end if;
			
    end process;

    Dout <= reg;  

end Behavioral;
