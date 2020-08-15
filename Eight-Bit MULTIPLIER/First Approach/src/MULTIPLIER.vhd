-------------------------------------------------------------------------------
--
-- Title       : MULTIPLIER
-- Design      : MULTIPLIER
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : MULTIPLIER.vhd
-- Generated   : Mon Apr 20 22:25:02 2020
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {MULTIPLIER} architecture {MULTIPLIER}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity MULTIPLIER is 
	port (
	A: in std_logic_vector (3 downto 0);
	B: in std_logic_vector (3 downto 0);
	F: out std_logic_vector (7 downto 0)
	);
end MULTIPLIER;

--}} End of automatically maintained section

architecture structural of MULTIPLIER is	

--AND PRODUCTS
signal G0, G1, G2, G3, G4, G5:  std_logic_vector (3 downto 0);	
-- Carry Bits
signal C0, C1, C2:  std_logic; 
-- Middle sum calculations
signal temp1, temp2, temp3 : std_logic_vector (3 downto 0);
begin 
	
    -- %%%%%%%%%%%%%%%%%%  AND products, assigned aggregates:
    G0 <= ('0', A(3) and B(0), A(2) and B(0), A(1) and B(0));
    G1 <= (A(3) and B(1), A(2) and B(1), A(1) and B(1), A(0) and B(1));
	
	G2 <= (C0, temp1(3), temp1(2), temp1(1));
	G3 <= (A(3) and B(2), A(2) and B(2), A(1) and B(2), A(0) and B(2));
		
	G4 <= (C1, temp2(3), temp2(2), temp2(1));
	G5 <= (A(3) and B(3), A(2) and B(3), A(1) and B(3), A(0) and B(3));
    -- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
	
	Level0: entity work.adder4(dfl)
		port map (
		cin => '0',
		a => G0, b => G1, sum => temp1,
		cout => C0
		);   
		
		

		-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		
	Level1: entity work.adder4(dfl)
		port map (
		cin => '0',
		a => G2, b => G3, sum => temp2,
		cout => C1
		);  
	
		

		-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		
	Level2: entity work.adder4(dfl)
		port map (
		cin => '0',
		a => G4, b => G5, sum => temp3,
		cout => C2
		); 	
		
		
		--============================================= DETERMINING THE OUTPUT VECTOR
		F(7) <= C2;
		F(6) <= temp3(3);
		F(5) <= temp3(2);
		F(4) <= temp3(1);
		F(3) <= temp3(0);
		F(2) <= temp2(0);
		F(1) <= temp1(0);
		F(0) <= A(0) and B(0);
		
	 

end architecture structural;
