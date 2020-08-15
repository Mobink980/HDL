library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity elevator_tb is
end elevator_tb;

architecture TB_ARCHITECTURE of elevator_tb is 

	-- DEFINING CONSTANTS FOR THE CLOCKS
	constant FIRST_DELAY	: delay_length := 20ns;
	constant SECOND_DELAY	: delay_length := 500ns;
	
	-- Component declaration of the tested unit
	component elevator
	port(
		clk : in STD_LOGIC;
		ONE_SECOND_CLOCK : in STD_LOGIC;
		Reset : in STD_LOGIC;
		start : in STD_LOGIC;
		pres_floor : out STD_LOGIC_VECTOR(3 downto 0);
		targ_floor : out STD_LOGIC_VECTOR(3 downto 0);
		trans_time : out STD_LOGIC_VECTOR(3 downto 0);
		wait_time : out STD_LOGIC_VECTOR(3 downto 0);
		address : out STD_LOGIC_VECTOR(5 downto 0);
		rand_floor : out STD_LOGIC_VECTOR(3 downto 0);
		inter : out STD_LOGIC;
		counter_down : out INTEGER;
		time_initial : out INTEGER;
		state : out STD_ULOGIC_VECTOR(3 downto 0);
		Memory_Out : out STD_LOGIC_VECTOR(7 downto 0);
		Floor : out STD_LOGIC_VECTOR(3 downto 0);
		Timer : out STD_LOGIC_VECTOR(3 downto 0);
		LiftDir : out STD_LOGIC_VECTOR(1 downto 0);
		LiftDoor : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC := '0';
	signal ONE_SECOND_CLOCK : STD_LOGIC := '0';
	signal Reset : STD_LOGIC := '1';
	signal start : STD_LOGIC := '0';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal pres_floor : STD_LOGIC_VECTOR(3 downto 0);
	signal targ_floor : STD_LOGIC_VECTOR(3 downto 0);
	signal trans_time : STD_LOGIC_VECTOR(3 downto 0);
	signal wait_time : STD_LOGIC_VECTOR(3 downto 0);
	signal address : STD_LOGIC_VECTOR(5 downto 0);
	signal rand_floor : STD_LOGIC_VECTOR(3 downto 0);
	signal inter : STD_LOGIC;
	signal counter_down : INTEGER;
	signal time_initial : INTEGER;
	signal state : STD_ULOGIC_VECTOR(3 downto 0);
	signal Memory_Out : STD_LOGIC_VECTOR(7 downto 0);
	signal Floor : STD_LOGIC_VECTOR(3 downto 0);
	signal Timer : STD_LOGIC_VECTOR(3 downto 0);
	signal LiftDir : STD_LOGIC_VECTOR(1 downto 0);
	signal LiftDoor : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : elevator
		port map (
			clk => clk,
			ONE_SECOND_CLOCK => ONE_SECOND_CLOCK,
			Reset => Reset,
			start => start,
			pres_floor => pres_floor,
			targ_floor => targ_floor,
			trans_time => trans_time,
			wait_time => wait_time,
			address => address,
			rand_floor => rand_floor,
			inter => inter,
			counter_down => counter_down,
			time_initial => time_initial,
			state => state,
			Memory_Out => Memory_Out,
			Floor => Floor,
			Timer => Timer,
			LiftDir => LiftDir,
			LiftDoor => LiftDoor
		);

	-- STIMMULATION FOR THE FIRST CLOCK (40 ns time-period) 
	STIM0: clk <= not clk after FIRST_DELAY; 
	
	-- STIMMULATION FOR THE SECOND CLOCK (1 second time-period) 
	STIM1: ONE_SECOND_CLOCK <= not ONE_SECOND_CLOCK after SECOND_DELAY;	   
	
	-- STIMMULATION FOR RESET
	STIM2: Reset <= '0' after 24ns;

	-- STIMMULATION FOR START
	STIM3: start <= '1' after 53ns,
	'0' after 67ns;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_elevator of elevator_tb is
	for TB_ARCHITECTURE
		for UUT : elevator
			use entity work.elevator(rtl);
		end for;
	end for;
end TESTBENCH_FOR_elevator;

