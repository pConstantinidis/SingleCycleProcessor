library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RegisterFile is
    Port (
        CLK   : in  STD_LOGIC;                          -- Clock signal
        WrEn  : in  STD_LOGIC;                          -- Write Enable
        Ard1  : in  STD_LOGIC_VECTOR(4 downto 0);       -- Read address 1 (5-bit)
        Ard2  : in  STD_LOGIC_VECTOR(4 downto 0);       -- Read address 2 (5-bit)
        Awr   : in  STD_LOGIC_VECTOR(4 downto 0);       -- Write address (5-bit)
        Din   : in  STD_LOGIC_VECTOR(31 downto 0);      -- Data input (32-bit)
        Dout1 : out STD_LOGIC_VECTOR(31 downto 0);      -- Read data 1 (32-bit)
        Dout2 : out STD_LOGIC_VECTOR(31 downto 0)       -- Read data 2 (32-bit)
    );
end RegisterFile;



architecture Structural of RegisterFile is

    signal RegWriteEnable : STD_LOGIC_VECTOR(31 downto 0); -- 32 individual write enables
    signal RegistersData  : STD_LOGIC_VECTOR(32*32-1 downto 0); -- 32 registers concatenated
    signal signal_and_gates : STD_LOGIC_VECTOR(31 downto 0); -- 32 individual write enables
    signal sel_1 : STD_LOGIC;
    signal sel_2 : STD_LOGIC;
    signal MUX_signal_1 : STD_LOGIC_VECTOR(31 downto 0); -- 32 individual write enables
    signal MUX_signal_2 : STD_LOGIC_VECTOR(31 downto 0); -- 32 individual write enables


    component and_gate
        Port (
            a : in STD_LOGIC;
            b : in STD_LOGIC;
            z : out STD_LOGIC
        );
    end component;

    component Register32
        Port (
            CLK   : in  STD_LOGIC;
            WE    : in  STD_LOGIC;
            Data  : in  STD_LOGIC_VECTOR(31 downto 0);
            Dout  : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;


    component MUX
        Port (
            Sel    : in  STD_LOGIC_VECTOR(4 downto 0);
            Inputs : in  STD_LOGIC_VECTOR(32*32-1 downto 0);
            OutMux : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
	 
	 component Decoder5to32
	     Port (
			  Input  : in  STD_LOGIC_VECTOR(4 downto 0);  			-- 5-bit input
			  Output_Decoder : out STD_LOGIC_VECTOR(31 downto 0)  -- 32-bit one-hot output
		  );
	 end component;
	 
	 component MUX_1bit
		 Port (
			  Sel          : in  STD_LOGIC;                 -- 1-bit selector
			  Din          : in  STD_LOGIC_VECTOR(31 downto 0);  -- Data input (32-bit)
			  Dout_original: in  STD_LOGIC_VECTOR(31 downto 0);  -- Original data input (32-bit)
			  Dout1        : out STD_LOGIC_VECTOR(31 downto 0)   -- Output (32-bit)
		 );
	 end component;
	 
	 component CompareModule_1
			 Port (
				  WrEn  : in  STD_LOGIC;                        -- Write Enable
				  Awr   : in  STD_LOGIC_VECTOR(4 downto 0);     -- Write address (5-bit)
				  Ard1  : in  STD_LOGIC_VECTOR(4 downto 0);     -- Read address 1 (5-bit)
				  Din   : in  STD_LOGIC_VECTOR(31 downto 0);    -- Data input (32-bit)
				  Sel   : out STD_LOGIC                         -- Selector output (1-bit)
			 );
	 end component;
	 
	 component CompareModule_2
			 Port (
				  WrEn  : in  STD_LOGIC;                        -- Write Enable
				  Awr   : in  STD_LOGIC_VECTOR(4 downto 0);     -- Write address (5-bit)
				  Ard2  : in  STD_LOGIC_VECTOR(4 downto 0);     -- Read address 2 (5-bit)
				  Din   : in  STD_LOGIC_VECTOR(31 downto 0);    -- Data input (32-bit)
				  Sel   : out STD_LOGIC                         -- Selector output (1-bit)
			 );
	 end component;
	 
	 
begin

    -- ============================================================================
	 -- ============================================================================
	 -- Decoder

	 Decoder5to32_instance: Decoder5to32 port map 
			( Input => Awr,
			  Output_Decoder => signal_and_gates
			  );
	 
	 
    AND_GATES_GEN: for i in 0 to 31 generate
        AND_Gate_Instance: and_gate
        port map (
            a => WrEn,
            b => signal_and_gates(i),
            z => RegWriteEnable(i)
        );
    end generate AND_GATES_GEN;

    -- ============================================================================
	 -- ============================================================================
	 -- Registers
	 
	 Register_Instance_0: Register32
	 port map (
			CLK   => CLK,
			WE    => '0',
			Data  => Din,
			Dout  => RegistersData(31 downto 0)
	 );
		  
    REGISTERS_GEN: for i in 1 to 31 generate
        Register_Instance: Register32
        port map (
            CLK   => CLK,
            WE    => RegWriteEnable(i),
            Data  => Din,
            Dout  => RegistersData((i+1)*32-1 downto i*32)
        );
    end generate REGISTERS_GEN;


    -- ============================================================================
	 -- ============================================================================
	 -- MUXES
	 
    MUX1_Instance: MUX
    port map (
        Sel    => Ard1,
        Inputs => RegistersData,
        OutMux => MUX_signal_1
    );

	 
    MUX2_Instance: MUX
    port map (
        Sel    => Ard2,
        Inputs => RegistersData,
        OutMux => MUX_signal_2
    );
	 
	 MUX_1bit_1_Instance: MUX_1bit
    port map (
        Sel    => sel_1,
		  Din => Din,
		  Dout_original => MUX_signal_1,
        Dout1 => Dout1
    );


    MUX_1bit_2_Instance: MUX_1bit
    port map (
        Sel    => sel_2,
		  Din => Din,
		  Dout_original => MUX_signal_2,
        Dout1 => Dout2
    );
	 
	 
    -- ============================================================================
	 -- ============================================================================
	 -- Compare Module
	 
	 
    CompareModule_1_Instance: CompareModule_1
    port map (
        WrEn    => WrEn,
        Awr  => Awr,
        Ard1  => Ard1,
        Din  => Din,
		  Sel => sel_1
    );
	 
    CompareModule_2_Instance: CompareModule_2
    port map (
        WrEn    => WrEn,
        Awr  => Awr,
        Ard2  => Ard2,
        Din  => Din,
		  Sel => sel_2
    );
	 
end Structural;
