library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity stack_tb is
	-- Generic declarations of the tested unit
		generic(
		DATA_WIDTH : POSITIVE := 12;
		ADDR_WIDTH : POSITIVE := 12 );
end stack_tb;

architecture TB_ARCHITECTURE of stack_tb is	 
	-- Clock period definitions
	constant CLK_period : time := 10 ns;
	-- Component declaration of the tested unit
	component stack
		generic(
		DATA_WIDTH : POSITIVE := 12;
		ADDR_WIDTH : POSITIVE := 12 );
	port(
		CLK : in STD_LOGIC;
		RESET : in STD_LOGIC;
		PUSH : in STD_LOGIC;
		POP : in STD_LOGIC;
		DataIn : in STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
		Stack_Empty : out STD_LOGIC;
		Stack_Full : out STD_LOGIC;
		Data : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal CLK : STD_LOGIC := '0';
	signal RESET : STD_LOGIC := '0';
	signal PUSH : STD_LOGIC := '0';
	signal POP : STD_LOGIC := '0'  ;
	signal DataIn : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal Stack_Empty : STD_LOGIC := '0';
	signal Stack_Full : STD_LOGIC := '0';
	signal Data : STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : stack
		generic map (
			DATA_WIDTH => DATA_WIDTH,
			ADDR_WIDTH => ADDR_WIDTH
		)

		port map (
			CLK => CLK,
			RESET => RESET,
			PUSH => PUSH,
			POP => POP,
			DataIn => DataIn,
			Stack_Empty => Stack_Empty,
			Stack_Full => Stack_Full,
			Data => Data
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
		
		reset <= '1';
		
		wait for CLK_period * 5;
		
		reset <= '0';
		
		wait;
	end process;
	
	-- Write process
	wr_proc : process
		variable counter : unsigned (11 downto 0) := (others => '0');
	begin		
		wait for CLK_period * 5;
 
		for i in 1 to 32 loop
			counter := counter + 1;
			
			DataIn <= std_logic_vector(counter);
			
			wait for CLK_period * 4;
			
			push <= '1';
			pop <= '0';
			
			wait for CLK_period * 4;
		
			push <= '0';
			pop <= '1';
		end loop;
		
		wait for clk_period * 20;
		
		for i in 1 to 32 loop
			counter := counter + 1;
			
			DataIn <= std_logic_vector(counter);
			
			wait for CLK_period * 4;
			
			push <= '1';
			pop <= '0';
			
			wait for CLK_period * 4;
			
			push <= '0'; 
			pop <= '1';
		end loop;
		
		wait;
	end process;
	
 
	
	

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_stack of stack_tb is
	for TB_ARCHITECTURE
		for UUT : stack
			use entity work.stack(rtl);
		end for;
	end for;
end TESTBENCH_FOR_stack;

