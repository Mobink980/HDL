library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;

	-- Add your library and packages declaration here ...

entity pfs_tb is
end pfs_tb;

architecture TB_ARCHITECTURE of pfs_tb is  
--defining constant DELAY
constant DELAY: delay_length := 20ns;	
--a vector to store the random number
signal num_bin: std_logic_vector (4 downto 0); 

	-- Component declaration of the tested unit
	component pfs
	port(
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		a : in STD_LOGIC;
		b : in STD_LOGIC;
		c : in STD_LOGIC;
		f : in STD_LOGIC;
		h : in STD_LOGIC;
		mo1 : out STD_LOGIC;
		mo2 : out STD_LOGIC;
		mo3 : out STD_LOGIC;
		mo4 : out STD_LOGIC;
		mo5 : out STD_LOGIC;
		mo6 : out STD_LOGIC;
		mo7 : out STD_LOGIC;
		mo8 : out STD_LOGIC;
		mo9 : out STD_LOGIC;
		moA : out STD_LOGIC;
		detect : out STD_LOGIC_VECTOR(8 downto 0);
		Q : out STD_LOGIC;
		W : out STD_LOGIC );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk : STD_LOGIC := '0';
	signal reset : STD_LOGIC := '0';
	signal a : STD_LOGIC := '0';
	signal b : STD_LOGIC := '0';
	signal c : STD_LOGIC := '0';
	signal f : STD_LOGIC := '0';
	signal h : STD_LOGIC := '0';
	-- Observed signals - signals mapped to the output ports of tested entity
	signal mo1 : STD_LOGIC;
	signal mo2 : STD_LOGIC;
	signal mo3 : STD_LOGIC;
	signal mo4 : STD_LOGIC;
	signal mo5 : STD_LOGIC;
	signal mo6 : STD_LOGIC;
	signal mo7 : STD_LOGIC;
	signal mo8 : STD_LOGIC;
	signal mo9 : STD_LOGIC;
	signal moA : STD_LOGIC;
	signal detect : STD_LOGIC_VECTOR(8 downto 0);
	signal Q : STD_LOGIC;
	signal W : STD_LOGIC;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : pfs
		port map (
			clk => clk,
			reset => reset,
			a => a,
			b => b,
			c => c,
			f => f,
			h => h,
			mo1 => mo1,
			mo2 => mo2,
			mo3 => mo3,
			mo4 => mo4,
			mo5 => mo5,
			mo6 => mo6,
			mo7 => mo7,
			mo8 => mo8,
			mo9 => mo9,
			moA => moA,
			detect => detect,
			Q => Q,
			W => W
		);

	-- STIMULATION FOR CLOCK	 
	STIM0: clk <= not clk after DELAY; 
	
	
	NOLABEL:
    process
    variable seed1 :positive ;
    variable seed2 :positive ;
    variable re1 : integer;
    variable re2 : real ;
    begin  

    	uniform (seed1,seed2,re2);
    	re1 := integer (re2 * real(2**5 -1));  
    	num_bin <= std_logic_vector ( to_unsigned (re1,5));

    	wait until rising_edge(clk); 
		-- GIVING RANDOM BITS TO THE PRIMARY INPUTS (PI)
		a <= num_bin(0);
		b <= num_bin(1);
		c <= num_bin(2);
		f <= num_bin(3); 
		h <= num_bin(4);

    end process;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_pfs of pfs_tb is
	for TB_ARCHITECTURE
		for UUT : pfs
			use entity work.pfs(pfs);
		end for;
	end for;
end TESTBENCH_FOR_pfs;

