	
	library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	
	ENTITY and_gate IS
		PORT(
		a : IN STD_LOGIC;
		b : IN STD_LOGIC;
		z : OUT STD_LOGIC
		);
	END and_gate;

	ARCHITECTURE model OF and_gate IS
	BEGIN
		z <= a AND b;
	END model;