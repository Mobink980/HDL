-------------------------------------------------------------------------------
--
-- Title       : CSA_MULTIPLIER
-- Design      : MULTIPLIERS
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : CSA_MULTIPLIER.vhd
-- Generated   : Thu Jun 24 01:08:23 2021
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
--{entity {CSA_MULTIPLIER} architecture {CSA_MULTIPLIER}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity CSA_MULTIPLIER is
	port ( --port declaration  
		signal op0: in std_logic_vector(7 downto 0); -- First operand
		signal op1: in std_logic_vector(7 downto 0); -- Second operand
		
		signal answer: out std_logic_vector(15 downto 0) -- Answer of Multiplication
		
		);
end CSA_MULTIPLIER;

--}} End of automatically maintained section

architecture RTL of CSA_MULTIPLIER is
--Arrays containing the partial products in each row
signal PA0: std_logic_vector(7 downto 0);  
signal PA1: std_logic_vector(7 downto 0); 
signal PA2: std_logic_vector(7 downto 0); 
signal PA3: std_logic_vector(7 downto 0); 
signal PA4: std_logic_vector(7 downto 0); 
signal PA5: std_logic_vector(7 downto 0); 
signal PA6: std_logic_vector(7 downto 0); 
signal PA7: std_logic_vector(7 downto 0); 	 

-- middle signals for storing the results of CSAs
signal s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15: std_logic;  
signal c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15: std_logic;  
signal s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27: std_logic;  
signal c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27: std_logic;
signal s28, s29, s30, s31, s32, s33, s34: std_logic;  
signal c28, c29, c30, c31, c32, c33, c34: std_logic;
signal s35, s36, s37, s38, s39, s40, s41: std_logic;  
signal c35, c36, c37, c38, c39, c40, c41: std_logic;
--Middle signals for carries of the CPA
signal t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13: std_logic; 
begin

process (op0, op1)
begin
	for I in 0 to op1'length-1 loop
		PA0(I) <= op1(0) and op0(I); --First row of partial products
		PA1(I) <= op1(1) and op0(I); --Second row of partial products
		PA2(I) <= op1(2) and op0(I); --Third row of partial products
		PA3(I) <= op1(3) and op0(I); --Fourth row of partial products
		PA4(I) <= op1(4) and op0(I); --Fifth row of partial products
		PA5(I) <= op1(5) and op0(I); --Sixth row of partial products
		PA6(I) <= op1(6) and op0(I); --Seventh row of partial products
		PA7(I) <= op1(7) and op0(I); --Eighth row of partial products	
	end loop;
end process;  

	--===================================================================================
	--                         FIRST PHASE OF COMPRESSION
	--===================================================================================
	-- instantiating the CSA unit
	CSA0: entity work.FA(RTL)
		port map (a => PA0(2), b => PA1(1), cin => PA2(0), sum => S0, cout => C0);	
		
	-- instantiating the CSA unit
	CSA1: entity work.FA(RTL)
		port map (a => PA0(3), b => PA1(2), cin => PA2(1), sum => S1, cout => C1);	
		
	-- instantiating the CSA unit
	CSA2: entity work.FA(RTL)
		port map (a => PA0(4), b => PA1(3), cin => PA2(2), sum => S2, cout => C2);	
		
	-- instantiating the CSA unit
	CSA3: entity work.FA(RTL)
		port map (a => PA0(5), b => PA1(4), cin => PA2(3), sum => S3, cout => C3);	
		
	-- instantiating the CSA unit
	CSA4: entity work.FA(RTL)
		port map (a => PA0(6), b => PA1(5), cin => PA2(4), sum => S4, cout => C4);	
		
	-- instantiating the CSA unit
	CSA5: entity work.FA(RTL)
		port map (a => PA0(7), b => PA1(6), cin => PA2(5), sum => S5, cout => C5);	
		
	-- instantiating the CSA unit
	CSA6: entity work.FA(RTL)
		port map (a => PA1(7), b => PA2(6), cin => PA3(5), sum => S6, cout => C6);	
		
	-- instantiating the CSA unit
	CSA7: entity work.FA(RTL)
		port map (a => PA2(7), b => PA3(6), cin => PA4(5), sum => S7, cout => C7);	
		
	-- instantiating the CSA unit
	CSA8: entity work.FA(RTL)
		port map (a => PA3(7), b => PA4(6), cin => PA5(5), sum => S8, cout => C8);	
		
	-- instantiating the CSA unit
	CSA9: entity work.FA(RTL)
		port map (a => PA4(7), b => PA5(6), cin => PA6(5), sum => S9, cout => C9);	
		
	-- instantiating the CSA unit
	CSA10: entity work.FA(RTL)
		port map (a => PA5(7), b => PA6(6), cin => PA7(5), sum => S10, cout => C10);	
		
	-- instantiating the CSA unit
	CSA11: entity work.FA(RTL)
		port map (a => PA3(2), b => PA4(1), cin => PA5(0), sum => S11, cout => C11);	
		
	-- instantiating the CSA unit
	CSA12: entity work.FA(RTL)
		port map (a => PA3(3), b => PA4(2), cin => PA5(1), sum => S12, cout => C12);	
		
	-- instantiating the CSA unit
	CSA13: entity work.FA(RTL)
		port map (a => PA3(4), b => PA4(3), cin => PA5(2), sum => S13, cout => C13);	
		
	-- instantiating the CSA unit
	CSA14: entity work.FA(RTL)
		port map (a => PA4(4), b => PA5(3), cin => PA6(2), sum => S14, cout => C14);	
		
	-- instantiating the CSA unit
	CSA15: entity work.FA(RTL)
		port map (a => PA5(4), b => PA6(3), cin => PA7(2), sum => S15, cout => C15);	
		
		
	--===================================================================================
	--                         SECOND PHASE OF COMPRESSION
	--===================================================================================	 
	
	-- instantiating the CSA unit
	CSA16: entity work.FA(RTL)
		port map (a => s1, b => c0, cin => PA3(0), sum => S16, cout => C16);
		
	-- instantiating the CSA unit
	CSA17: entity work.FA(RTL)
		port map (a => s2, b => c1, cin => PA3(1), sum => S17, cout => C17);
		
	-- instantiating the CSA unit
	CSA18: entity work.FA(RTL)
		port map (a => s3, b => c2, cin => s11, sum => S18, cout => C18);
		
	-- instantiating the CSA unit
	CSA19: entity work.FA(RTL)
		port map (a => s4, b => c3, cin => s12, sum => S19, cout => C19);
		
	-- instantiating the CSA unit
	CSA20: entity work.FA(RTL)
		port map (a => s5, b => c4, cin => s13, sum => S20, cout => C20);
		
	-- instantiating the CSA unit
	CSA21: entity work.FA(RTL)
		port map (a => s6, b => c5, cin => s14, sum => S21, cout => C21);
		
	-- instantiating the CSA unit
	CSA22: entity work.FA(RTL)
		port map (a => s7, b => c6, cin => s15, sum => S22, cout => C22);
		
	-- instantiating the CSA unit
	CSA23: entity work.FA(RTL)
		port map (a => s8, b => c7, cin => PA6(4), sum => S23, cout => C23);
		
	-- instantiating the CSA unit
	CSA24: entity work.FA(RTL)
		port map (a => s9, b => c8, cin => PA7(4), sum => S24, cout => C24);
		
	-- instantiating the CSA unit
	CSA25: entity work.FA(RTL)
		port map (a => PA6(7), b => c10, cin => PA7(6), sum => S25, cout => C25);
		
	-- instantiating the CSA unit
	CSA26: entity work.FA(RTL)
		port map (a => c12, b => PA5(1), cin => PA7(0), sum => S26, cout => C26); 
		
	-- instantiating the HA unit
	HA0: entity work.HA(RTL)
		port map (a => c13, b => PA7(1), sum => S27, cout => C27);
	
	
	
	
	
	
	
	--===================================================================================
	--                         THIRD PHASE OF COMPRESSION
	--=================================================================================== 	
	
	-- instantiating the CSA unit
	CSA27: entity work.FA(RTL)
		port map (a => s17, b => c16, cin => PA4(0), sum => S28, cout => C28); 
		
	-- instantiating the CSA unit
	CSA28: entity work.FA(RTL)
		port map (a => s19, b => c18, cin => c11, sum => S29, cout => C29); 
		
	-- instantiating the CSA unit
	CSA29: entity work.FA(RTL)
		port map (a => s20, b => c19, cin => s26, sum => S30, cout => C30); 
		
	-- instantiating the CSA unit
	CSA30: entity work.FA(RTL)
		port map (a => s21, b => c20, cin => s27, sum => S31, cout => C31); 
		
	-- instantiating the CSA unit
	CSA31: entity work.FA(RTL)
		port map (a => s22, b => c21, cin => c14, sum => S32, cout => C32); 
		
	-- instantiating the CSA unit
	CSA32: entity work.FA(RTL)
		port map (a => s23, b => c22, cin => c15, sum => S33, cout => C33); 
		
	-- instantiating the CSA unit
	CSA33: entity work.FA(RTL)
		port map (a => s10, b => c24, cin => c9, sum => S34, cout => C34); 
		
	
	
	
	--===================================================================================
	--                         FOURTH PHASE OF COMPRESSION
	--===================================================================================  
	
	-- instantiating the CSA unit
	CSA34: entity work.FA(RTL)
		port map (a => s18, b => c28, cin => c17, sum => S35, cout => C35); 
		
	-- instantiating the HA unit
	HA1: entity work.HA(RTL)
		port map (a => s29, b => PA6(0), sum => S36, cout => C36);
		
	-- instantiating the HA unit
	HA2: entity work.HA(RTL)
		port map (a => s30, b => c29, sum => s37, cout => C37);	
		
	-- instantiating the CSA unit
	CSA35: entity work.FA(RTL)
		port map (a => s31, b => c30, cin => c26, sum => S38, cout => C38);
		
	-- instantiating the CSA unit
	CSA36: entity work.FA(RTL)
		port map (a => s32, b => c31, cin => c27, sum => S39, cout => C39);
		
	-- instantiating the CSA unit
	CSA37: entity work.FA(RTL)
		port map (a => s33, b => c32, cin => PA7(3), sum => S40, cout => C40);
		
	-- instantiating the CSA unit
	CSA38: entity work.FA(RTL)
		port map (a => s24, b => c33, cin => c23, sum => S41, cout => C41);	 
		

	--===================================================================================
	--                         CARRY PRPAGATE ADDER (CPA)
	--===================================================================================  
	
	-- instantiating the CSA unit
	CPA0: entity work.FA(RTL)
		port map (a => PA0(0), b => '0', cin => '0', sum => answer(0), cout => t0);	
		
	-- instantiating the CSA unit
	CPA1: entity work.FA(RTL)
		port map (a => PA0(1), b => PA1(0), cin => t0, sum => answer(1), cout => t1);	
		
	-- instantiating the CSA unit
	CPA2: entity work.FA(RTL)
		port map (a => s0, b => '0', cin => t1, sum => answer(2), cout => t2);	
		
	-- instantiating the CSA unit
	CPA3: entity work.FA(RTL)
		port map (a => s16, b => '0', cin => t2, sum => answer(3), cout => t3);	
		
	-- instantiating the CSA unit
	CPA4: entity work.FA(RTL)
		port map (a => s28, b => '0', cin => t3, sum => answer(4), cout => t4);	
		
	-- instantiating the CSA unit
	CPA5: entity work.FA(RTL)
		port map (a => s35, b => '0', cin => t4, sum => answer(5), cout => t5);	
		
	-- instantiating the CSA unit
	CPA6: entity work.FA(RTL)
		port map (a => s36, b => c35, cin => t5, sum => answer(6), cout => t6);	
		
	-- instantiating the CSA unit
	CPA7: entity work.FA(RTL)
		port map (a => s37, b => c36, cin => t6, sum => answer(7), cout => t7);	
		
	-- instantiating the CSA unit
	CPA8: entity work.FA(RTL)
		port map (a => s38, b => c37, cin => t7, sum => answer(8), cout => t8);	
		
	-- instantiating the CSA unit
	CPA9: entity work.FA(RTL)
		port map (a => s39, b => c38, cin => t8, sum => answer(9), cout => t9);	
		
	-- instantiating the CSA unit
	CPA10: entity work.FA(RTL)
		port map (a => s40, b => c39, cin => t9, sum => answer(10), cout => t10);	
		
	-- instantiating the CSA unit
	CPA11: entity work.FA(RTL)
		port map (a => s41, b => c40, cin => t10, sum => answer(11), cout => t11);	
		
	-- instantiating the CSA unit
	CPA12: entity work.FA(RTL)
		port map (a => s34, b => c41, cin => t11, sum => answer(12), cout => t12);	
		
	-- instantiating the CSA unit
	CPA13: entity work.FA(RTL)
		port map (a => s25, b => c34, cin => t12, sum => answer(13), cout => t13);	
		
	-- instantiating the CSA unit
	CPA14: entity work.FA(RTL)
		port map (a => PA7(7), b => c25, cin => t13, sum => answer(14), cout => answer(15));	
		
		


end architecture RTL;
