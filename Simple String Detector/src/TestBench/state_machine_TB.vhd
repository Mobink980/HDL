library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity state_machine_tb is
end state_machine_tb;

architecture TB_ARCHITECTURE of state_machine_tb is	 
--defining constant DELAY
constant DELAY: delay_length := 5ns;
	-- Component declaration of the tested unit
	component state_machine
	port(
		X : in STD_LOGIC;
		rst : in STD_LOGIC;
		clk : in STD_LOGIC;
		start : in STD_LOGIC;
		stop : in STD_LOGIC;
		state : out STD_ULOGIC_VECTOR(2 downto 0);
		Busy : out STD_LOGIC;
		Z : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal X : STD_LOGIC := '0';
	signal rst : STD_LOGIC := '0';
	signal clk : STD_LOGIC := '0';
	signal start : STD_LOGIC := '0';
	signal stop : STD_LOGIC := '0';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal state : STD_ULOGIC_VECTOR(2 downto 0);
	signal Busy : STD_LOGIC;
	signal Z : STD_LOGIC := '0';

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : state_machine
		port map (
			X => X,
			rst => rst,
			clk => clk,
			start => start,
			stop => stop,
			state => state,
			Busy => Busy,
			Z => Z
		);

	
				-- STIMULATION FOR CLOCK	 
	STIM0: clk <= not clk after DELAY;
	
	-- STIMULATION FOR RESET	 
	STIM1: rst <= '1',
	'0' after 8ns,
	'1' after 150ns,
	'0' after 155ns;
	
	-- STIMULATION FOR START
	STIM2: start <= '1' after 24ns,
	'0' after 33 ns;
		
	-- STIMULATION FOR STOP
	STIM3: stop <= '1' after 100ns,
	'0' after 105ns;
	
	-- STIMULATION OF THE INPUT OF THE FSM
	process 
	begin 
		X <= '0'; 
		wait until rst = '0'; 
		
		wait until rising_edge(clk); 
		X <= '0';  		 
		wait until rising_edge(clk);  
		X <= '1'; 
		wait until rising_edge(clk);  
		X <= '0';	
		wait until rising_edge(clk);  
		X <= '1';
		wait until rising_edge(clk);  
		X <= '1';
		wait until rising_edge(clk);  
		X <= '0';
		wait until rising_edge(clk);  
		X <= '1';
		wait until rising_edge(clk);  
		X <= '1';
		wait until rising_edge(clk);  
		X <= '0';
		wait until rising_edge(clk);  
		X <= '1';
		wait until rising_edge(clk);  
		X <= '1';
		wait until rising_edge(clk);  
		X <= '0';
		wait until rising_edge(clk);  
		X <= '0'; 
		
	end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_state_machine of state_machine_tb is
	for TB_ARCHITECTURE
		for UUT : state_machine
			use entity work.state_machine(rtl);
		end for;
	end for;
end TESTBENCH_FOR_state_machine;

