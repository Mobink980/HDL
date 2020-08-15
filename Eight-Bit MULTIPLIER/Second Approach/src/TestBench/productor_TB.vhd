library ieee;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity productor_tb is
end productor_tb;

architecture TB_ARCHITECTURE of productor_tb is
	-- Component declaration of the tested unit
	component productor
	port(
		A : in STD_LOGIC_VECTOR(3 downto 0);
		B : in STD_LOGIC_VECTOR(3 downto 0);
		F : out STD_LOGIC_VECTOR(7 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal A : STD_LOGIC_VECTOR(3 downto 0):= (others =>'0');
	signal B : STD_LOGIC_VECTOR(3 downto 0):= (others =>'0');
	-- Observed signals - signals mapped to the output ports of tested entity
	signal F : STD_LOGIC_VECTOR(7 downto 0):= (others =>'0');

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : productor
		port map (
			A => A,
			B => B,
			F => F
		);

	-- Add your stimulus here ...
	STIM1: A <= "0001" after 10ns,
	"0101" after 20ns,
	"0111" after 30ns,
	"1011" after 40ns;	
	
	STIM2: B <= "0001" after 10ns,
	"0011" after 20ns,
	"0010" after 30ns,
	"1000" after 40ns;

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_productor of productor_tb is
	for TB_ARCHITECTURE
		for UUT : productor
			use entity work.productor(productor);
		end for;
	end for;
end TESTBENCH_FOR_productor;

