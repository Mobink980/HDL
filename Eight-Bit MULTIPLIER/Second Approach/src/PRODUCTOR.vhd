-------------------------------------------------------------------------------
--
-- Title       : PRODUCTOR
-- Design      : PRODUCTOR
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : PRODUCTOR.vhd
-- Generated   : Wed Apr 22 15:02:21 2020
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
--{entity {PRODUCTOR} architecture {PRODUCTOR}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity PRODUCTOR is
	port (
	A: in std_logic_vector (3 downto 0);
	B: in std_logic_vector (3 downto 0);
	F: out std_logic_vector (7 downto 0)	
	);
end PRODUCTOR;

--}} End of automatically maintained section

architecture PRODUCTOR of PRODUCTOR is 
signal temp0 : std_logic := A(0) and B(0);
signal temp1 : std_logic := A(1) and B(0); 	
signal temp2 : std_logic := A(2) and B(0);
signal temp3 : std_logic := A(3) and B(0); 

signal temp4 : std_logic := A(0) and B(1);
signal temp5 : std_logic := A(1) and B(1);
signal temp6 : std_logic := A(2) and B(1);
signal temp7 : std_logic := A(3) and B(1);

signal temp8 : std_logic := A(0) and B(2);
signal temp9 : std_logic := A(1) and B(2);
signal temp10 : std_logic := A(2) and B(2);
signal temp11 : std_logic := A(3) and B(2);

signal temp12 : std_logic := A(0) and B(3);
signal temp13 : std_logic := A(1) and B(3);
signal temp14 : std_logic := A(2) and B(3);
signal temp15 : std_logic := A(3) and B(3);	

signal ci1 : std_logic_vector (1 to 3);
signal ci2 : std_logic_vector (1 to 3);	
signal ci3 : std_logic_vector (1 to 3);

signal tmp1 : std_logic_vector (3 downto 0);
signal tmp2 : std_logic_vector (3 downto 0);

begin	 
	temp0  <=  A(0) and B(0);
	temp1  <=  A(1) and B(0);
	temp2  <=  A(2) and B(0);
	temp3  <=  A(3) and B(0);
	
	temp4  <=  A(0) and B(1);
	temp5  <=  A(1) and B(1);
	temp6  <=  A(2) and B(1);
	temp7  <=  A(3) and B(1);
	
	temp8  <=  A(0) and B(2);
	temp9  <=  A(1) and B(2);
	temp10 <=  A(2) and B(2);
	temp11 <=  A(3) and B(2);
	
	temp12 <=  A(0) and B(3);
	temp13 <=  A(1) and B(3);
	temp14 <=  A(2) and B(3);
	temp15 <=  A(3) and B(3);

	
	
	
	F(0) <= temp0;
	Add0: entity work.fadd1(dfl)
		port map (opa => temp1, opb => temp4, cin => '0', sum => F(1), cout => ci1(1));
		
	Add1: entity work.fadd1(dfl)
		port map (opa => temp2, opb => temp5, cin => ci1(1), sum => tmp1(0), cout => ci1(2));
		
	Add2: entity work.fadd1(dfl)
		port map (opa => temp3, opb => temp6, cin => ci1(2), sum => tmp1(1), cout => ci1(3));
		
	Add3: entity work.fadd1(dfl)
		port map (opa => '0', opb => temp7, cin =>  ci1(3), sum => tmp1(2), cout => tmp1(3));	 
		
		--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		
	Add4: entity work.fadd1(dfl)
		port map (opa => tmp1(0), opb => temp8, cin => '0', sum => F(2), cout => ci2(1));
		
	Add5: entity work.fadd1(dfl)
		port map (opa => tmp1(1), opb => temp9, cin => ci2(1), sum => tmp2(0), cout => ci2(2));
		
	Add6: entity work.fadd1(dfl)
		port map (opa => tmp1(2), opb => temp10, cin => ci2(2), sum => tmp2(1), cout => ci2(3));
		
	Add7: entity work.fadd1(dfl)
		port map (opa => tmp1(3), opb => temp11, cin => ci2(3), sum => tmp2(2), cout => tmp2(3));
		
		--%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		
	Add8: entity work.fadd1(dfl)
		port map (opa => tmp2(0), opb => temp12, cin => '0', sum => F(3), cout => ci3(1));
		
	Add9: entity work.fadd1(dfl)
		port map (opa => tmp2(1), opb => temp13, cin => ci3(1), sum => F(4), cout => ci3(2));
		
	Add10: entity work.fadd1(dfl)
		port map (opa => tmp2(2), opb => temp14, cin => ci3(2), sum => F(5), cout => ci3(3));
		
	Add11: entity work.fadd1(dfl)
		port map (opa => tmp2(3), opb => temp15, cin => ci3(3), sum => F(6), cout => F(7));

end PRODUCTOR;
