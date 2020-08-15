library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity controller_tb is
	-- Generic declarations of the tested unit
		generic(
		DATA_WIDTH : POSITIVE := 8;
		ADDR_WIDTH : POSITIVE := 8 );
end controller_tb;

architecture TB_ARCHITECTURE of controller_tb is   
	-- Clock period definitions
	constant CLK_period : time := 10 ns;
	-- Component declaration of the tested unit
	component controller
		generic(
		DATA_WIDTH : POSITIVE := 8;
		ADDR_WIDTH : POSITIVE := 8 );
	port(
		CLK : in STD_LOGIC;
		RST : in STD_LOGIC;
		WriteEn : in STD_LOGIC;
		DataIn : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
		ReadEn : in STD_LOGIC;
		DataOut : inout STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
		Empty : out STD_LOGIC;
		Full : out STD_LOGIC;
		Data1 : inout STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
		Data2 : inout STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal CLK : STD_LOGIC := '0';
	signal RST : STD_LOGIC := '0';
	signal WriteEn : STD_LOGIC := '0';
	signal DataIn : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0) := (others => '0');
	signal ReadEn : STD_LOGIC := '0';
	signal DataOut : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
	signal Data1 : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
	signal Data2 : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal Empty : STD_LOGIC;
	signal Full : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : controller
		generic map (
			DATA_WIDTH => DATA_WIDTH,
			ADDR_WIDTH => ADDR_WIDTH
		)

		port map (
			CLK => CLK,
			RST => RST,
			WriteEn => WriteEn,
			DataIn => DataIn,
			ReadEn => ReadEn,
			DataOut => DataOut,
			Empty => Empty,
			Full => Full,
			Data1 => Data1,
			Data2 => Data2
		);
		
		
	-- Clock process definitions
	CLK_process :process
	begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
	end process;
	
	-- Reset process
	rst_proc : process
	begin
	wait for CLK_period * 5;
		
		RST <= '1';
		
		wait for CLK_period * 5;
		
		RST <= '0';
		
		wait;
	end process;
	
	-- Write process
	wr_proc : process
		variable counter : unsigned (7 downto 0) := (others => '0');
	begin		
		wait for CLK_period * 5;
 
		for i in 1 to 32 loop
			counter := counter + 1;
			
			DataIn <= std_logic_vector(counter);
			
			wait for CLK_period * 4;
			
			WriteEn <= '1';
			
			wait for CLK_period * 4;
		
			WriteEn <= '0';
		end loop;
		
		wait for clk_period * 20;
		
		for i in 1 to 32 loop
			counter := counter + 1;
			
			DataIn <= std_logic_vector(counter);
			
			wait for CLK_period * 4;
			
			WriteEn <= '1';
			
			wait for CLK_period * 4;
			
			WriteEn <= '0';
		end loop;
		
		wait;
	end process;
	
	-- Read process
	rd_proc : process
	begin
		wait for CLK_period * 10;
			
		ReadEn <= '1';
		
		wait for CLK_period * 70;
		
		ReadEn <= '0';
		
		wait;
	end process;  
	
	
	
 
	

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_controller of controller_tb is
	for TB_ARCHITECTURE
		for UUT : controller
			use entity work.controller(rtl);
		end for;
	end for;
end TESTBENCH_FOR_controller;

