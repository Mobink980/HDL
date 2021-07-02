-------------------------------------------------------------------------------
--
-- Title       : COMP4_MULTIPLIER
-- Design      : MULTIPLIERS
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : COMP4_MULTIPLIER.vhd
-- Generated   : Thu Jun 24 01:10:00 2021
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
--{entity {COMP4_MULTIPLIER} architecture {COMP4_MULTIPLIER}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity COMP4_MULTIPLIER is 
	port ( --port declaration  
		signal op0: in std_logic_vector(7 downto 0); -- First operand
		signal op1: in std_logic_vector(7 downto 0); -- Second operand
		
		signal answer: out std_logic_vector(16 downto 0) -- Answer of Multiplication
		
		);
end COMP4_MULTIPLIER;

--}} End of automatically maintained section

architecture RTL of COMP4_MULTIPLIER is
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
signal s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26: std_logic;  
signal c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26: std_logic;

--Middle signals for carries of the CPA
signal t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10: std_logic; 	
signal t11, t12, t13, t14, t15, t16, t17, t18, t19, t20: std_logic;	
signal t21, t22, t23, t24, t25, t26, t27, t28, t29, t30, t31, t32: std_logic;
begin
-- Following process calculates partial products
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
		
	-- instantiating the COMPRESSOR_4_TO_2 unit
	COMPRESS_4_0: entity work.COMPRESSOR_4_TO_2(RTL)
		port map (x(0) => PA0(3), x(1) => PA1(2), x(2) => PA2(1), x(3) => PA3(0), cin => '0', cout => t0, s => S1, c => C1);	
		
	-- instantiating the COMPRESSOR_4_TO_2 unit
	COMPRESS_4_1: entity work.COMPRESSOR_4_TO_2(RTL)
		port map (x(0) => PA0(4), x(1) => PA1(3), x(2) => PA2(2), x(3) => PA3(1), cin => t0, cout => t1, s => S2, c => C2);	
		
	-- instantiating the COMPRESSOR_4_TO_2 unit
	COMPRESS_4_2: entity work.COMPRESSOR_4_TO_2(RTL)
		port map (x(0) => PA0(5), x(1) => PA1(4), x(2) => PA2(3), x(3) => PA3(2), cin => t1, cout => t2, s => S3, c => C3);	
		
	-- instantiating the COMPRESSOR_4_TO_2 unit
	COMPRESS_4_3: entity work.COMPRESSOR_4_TO_2(RTL)
		port map (x(0) => PA0(6), x(1) => PA1(5), x(2) => PA2(4), x(3) => PA3(3), cin => t2, cout => t3, s => S4, c => C4);	
		
	-- instantiating the COMPRESSOR_4_TO_2 unit
	COMPRESS_4_4: entity work.COMPRESSOR_4_TO_2(RTL)
		port map (x(0) => PA0(7), x(1) => PA1(6), x(2) => PA2(5), x(3) => PA3(4), cin => t3, cout => t4, s => S5, c => C5);	
		
	-- instantiating the COMPRESSOR_4_TO_2 unit
	COMPRESS_4_5: entity work.COMPRESSOR_4_TO_2(RTL)
		port map (x(0) => PA1(7), x(1) => PA2(6), x(2) => PA3(5), x(3) => PA4(4), cin => t4, cout => t5, s => S6, c => C6);	
		
	-- instantiating the COMPRESSOR_4_TO_2 unit
	COMPRESS_4_6: entity work.COMPRESSOR_4_TO_2(RTL)
		port map (x(0) => PA2(7), x(1) => PA3(6), x(2) => PA4(5), x(3) => PA5(4), cin => t5, cout => t6, s => S7, c => C7);	
		
	-- instantiating the COMPRESSOR_4_TO_2 unit
	COMPRESS_4_7: entity work.COMPRESSOR_4_TO_2(RTL)
		port map (x(0) => PA3(7), x(1) => PA4(6), x(2) => PA5(5), x(3) => PA6(4), cin => t6, cout => t7, s => S8, c => C8);	
		
	-- instantiating the COMPRESSOR_4_TO_2 unit
	COMPRESS_4_8: entity work.COMPRESSOR_4_TO_2(RTL)
		port map (x(0) => PA4(7), x(1) => PA5(6), x(2) => PA6(5), x(3) => PA7(4), cin => t7, cout => t8, s => S9, c => C9);	
		
	-- instantiating the COMPRESSOR_4_TO_2 unit
	COMPRESS_4_9: entity work.COMPRESSOR_4_TO_2(RTL)
		port map (x(0) => '0', x(1) => PA5(7), x(2) => PA6(6), x(3) => PA7(5), cin => t8, cout => t9, s => S10, c => C10);	
		
	-- instantiating the CSA unit
	CSA1: entity work.FA(RTL)
		port map (a => t9, b => PA6(7), cin => PA7(6), sum => S11, cout => C11);
		
	-- instantiating the CSA unit
	CSA2: entity work.FA(RTL)
		port map (a => PA4(2), b => PA5(1), cin => PA6(0), sum => S12, cout => C12);
		
	-- instantiating the COMPRESSOR_4_TO_2 unit
	COMPRESS_4_10: entity work.COMPRESSOR_4_TO_2(RTL)
		port map (x(0) => PA4(3), x(1) => PA5(2), x(2) => PA6(1), x(3) => PA7(0), cin => '0', cout => t10, s => S13, c => C13);
		
	-- instantiating the COMPRESSOR_4_TO_2 unit
	COMPRESS_4_11: entity work.COMPRESSOR_4_TO_2(RTL)
		port map (x(0) => '0', x(1) => PA5(3), x(2) => PA6(2), x(3) => PA7(1), cin => t10, cout => t11, s => S14, c => C14);
		
	-- instantiating the CSA unit
	CSA3: entity work.FA(RTL)
		port map (a => t11, b => PA6(3), cin => PA7(2), sum => S15, cout => C15);
		
		
		
		
	--===================================================================================
	--                         SECOND PHASE OF COMPRESSION
	--===================================================================================	
	
	-- instantiating the CSA unit
	CSA4: entity work.FA(RTL)
		port map (a => s2, b => c1, cin => PA4(0), sum => S16, cout => C16); 
		
	-- instantiating the COMPRESSOR_4_TO_2 unit
	COMPRESS_4_12: entity work.COMPRESSOR_4_TO_2(RTL)
		port map (x(0) => s3, x(1) => c2, x(2) => PA4(1), x(3) => PA5(0), cin => '0', cout => t12, s => S17, c => C17);
		
	-- instantiating the COMPRESSOR_4_TO_2 unit
	COMPRESS_4_13: entity work.COMPRESSOR_4_TO_2(RTL)
		port map (x(0) => s4, x(1) => c3, x(2) => s12, x(3) => '0', cin => t12, cout => t13, s => S18, c => C18);
		
	-- instantiating the COMPRESSOR_4_TO_2 unit
	COMPRESS_4_14: entity work.COMPRESSOR_4_TO_2(RTL)
		port map (x(0) => s5, x(1) => c4, x(2) => s13, x(3) => c12, cin => t13, cout => t14, s => S19, c => C19);
		
	-- instantiating the COMPRESSOR_4_TO_2 unit
	COMPRESS_4_15: entity work.COMPRESSOR_4_TO_2(RTL)
		port map (x(0) => s6, x(1) => c5, x(2) => s14, x(3) => c13, cin => t14, cout => t15, s => S20, c => C20);
		
	-- instantiating the COMPRESSOR_4_TO_2 unit
	COMPRESS_4_16: entity work.COMPRESSOR_4_TO_2(RTL)
		port map (x(0) => s7, x(1) => c6, x(2) => s15, x(3) => c14, cin => t15, cout => t16, s => S21, c => C21);
		
	-- instantiating the COMPRESSOR_4_TO_2 unit
	COMPRESS_4_17: entity work.COMPRESSOR_4_TO_2(RTL)
		port map (x(0) => s8, x(1) => c7, x(2) => PA7(3), x(3) => c15, cin => t16, cout => t17, s => S22, c => C22);
		
	-- instantiating the CSA unit
	CSA5: entity work.FA(RTL)
		port map (a => s9, b => c8, cin => t17, sum => S23, cout => C23); 
	
		
	-- instantiating the HA unit
	HA0: entity work.HA(RTL)
		port map (a => s10, b => c9, sum => S24, cout => C24);	 
		
	-- instantiating the HA unit
	HA1: entity work.HA(RTL)
		port map (a => s11, b => c10, sum => S25, cout => C25);
		
	-- instantiating the HA unit
	HA2: entity work.HA(RTL)
		port map (a => PA7(7), b => c11, sum => S26, cout => C26);
	
	
	--===================================================================================
	--                         CARRY PRPAGATE ADDER (CPA)
	--===================================================================================  
	
	-- instantiating the CSA unit
	CPA0: entity work.FA(RTL)
		port map (a => PA0(0), b => '0', cin => '0', sum => answer(0), cout => t18);	
		
	-- instantiating the CSA unit
	CPA1: entity work.FA(RTL)
		port map (a => PA0(1), b => PA1(0), cin => t18, sum => answer(1), cout => t19);	
		
	-- instantiating the CSA unit
	CPA2: entity work.FA(RTL)
		port map (a => s0, b => '0', cin => t19, sum => answer(2), cout => t20);	
		
	-- instantiating the CSA unit
	CPA3: entity work.FA(RTL)
		port map (a => s1, b => c0, cin => t20, sum => answer(3), cout => t21);	
		
	-- instantiating the CSA unit
	CPA4: entity work.FA(RTL)
		port map (a => s16, b => '0', cin => t21, sum => answer(4), cout => t22);	
		
	-- instantiating the CSA unit
	CPA5: entity work.FA(RTL)
		port map (a => s17, b => c16, cin => t22, sum => answer(5), cout => t23);	
		
	-- instantiating the CSA unit
	CPA6: entity work.FA(RTL)
		port map (a => s18, b => c17, cin => t23, sum => answer(6), cout => t24);	
		
	-- instantiating the CSA unit
	CPA7: entity work.FA(RTL)
		port map (a => s19, b => c18, cin => t24, sum => answer(7), cout => t25);	
		
	-- instantiating the CSA unit
	CPA8: entity work.FA(RTL)
		port map (a => s20, b => c19, cin => t25, sum => answer(8), cout => t26);	
		
	-- instantiating the CSA unit
	CPA9: entity work.FA(RTL)
		port map (a => s21, b => c20, cin => t26, sum => answer(9), cout => t27);	
		
	-- instantiating the CSA unit
	CPA10: entity work.FA(RTL)
		port map (a => s22, b => c21, cin => t27, sum => answer(10), cout => t28);	
		
	-- instantiating the CSA unit
	CPA11: entity work.FA(RTL)
		port map (a => s23, b => c22, cin => t28, sum => answer(11), cout => t29);	
		
	-- instantiating the CSA unit
	CPA12: entity work.FA(RTL)
		port map (a => s24, b => c23, cin => t29, sum => answer(12), cout => t30);	
		
	-- instantiating the CSA unit
	CPA13: entity work.FA(RTL)
		port map (a => s25, b => c24, cin => t30, sum => answer(13), cout => t31);	
		
	-- instantiating the CSA unit
	CPA14: entity work.FA(RTL)
		port map (a => s26, b => c25, cin => t31, sum => answer(14), cout => t32);
		
	-- instantiating the CSA unit
	CPA15: entity work.FA(RTL)
		port map (a => '0', b => c26, cin => t32, sum => answer(15), cout => answer(16));

end architecture RTL;
