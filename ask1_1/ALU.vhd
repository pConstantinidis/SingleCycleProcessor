library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is
    Port (
        A     : in  STD_LOGIC_VECTOR(31 downto 0);
        B     : in  STD_LOGIC_VECTOR(31 downto 0);
        Op    : in  STD_LOGIC_VECTOR(3 downto 0);
        Out1  : out STD_LOGIC_VECTOR(31 downto 0);
        Zero  : out STD_LOGIC;
        aaa   : out STD_LOGIC;
        Cout  : out STD_LOGIC;
        Ovf   : out STD_LOGIC
    );
end ALU;

architecture Behavioral of ALU is
    signal result_33 : STD_LOGIC_VECTOR(32 downto 0); -- 33-bit signal for overflow and carry
	 
begin

    process(A, B, Op)
	 
        variable sum_33 : STD_LOGIC_VECTOR(32 downto 0);
		  
    begin
	 
        case Op is
		  
            when "0000" =>  -- Addition
                sum_33 := ('0' & A) + ('0' & B);
                Out1 <= sum_33(31 downto 0);
                Cout <= sum_33(32);
                Ovf  <= (A(31) and B(31) and not sum_33(31)) or (not A(31) and not B(31) and sum_33(31));
            
            when "0001" =>  -- Subtraction
                sum_33 := ('0' & A) - ('0' & B);
                Out1 <= sum_33(31 downto 0);
                Cout <= sum_33(32);
                Ovf  <= (A(31) and not B(31) and not sum_33(31)) or (not A(31) and B(31) and sum_33(31));
            
            when "0010" =>  -- AND
                Out1 <= A and B;
                Cout <= '0';
                Ovf  <= '0';
            
            when "0011" =>  -- OR
                Out1 <= A or B;
                Cout <= '0';
                Ovf  <= '0';
            
            when "0100" =>  -- NOT A
                Out1 <= not A;
                Cout <= '0';
                Ovf  <= '0';
            
            when "1000" =>  -- Arithmetic shift right
                Out1 <= A(31) & A(31 downto 1);
                Cout <= '0';
                Ovf  <= '0';
            
            when "1001" =>  -- Logical shift right
                Out1 <= '0' & A(31 downto 1);
                Cout <= '0';
                Ovf  <= '0';
            
            when "1010" =>  -- Logical shift left
                Out1 <= A(30 downto 0) & '0';
                Cout <= '0';
                Ovf  <= '0';
            
            when "1100" =>  -- Rotate left
                Out1 <= A(30 downto 0) & A(31);
                Cout <= '0';
                Ovf  <= '0';
            
            when "1101" =>  -- Rotate right
                Out1 <= A(0) & A(31 downto 1);
                Cout <= '0';
                Ovf  <= '0';
            
            when others =>
                Out1 <= (others => '0');
                Cout <= '0';
                Ovf  <= '0';
        end case;
		  
        if sum_33 = "000000000000000000000000000000000" then
            Zero <= '1';
        else
            Zero <= '0';
        end if;
     
    end process;
end Behavioral;
