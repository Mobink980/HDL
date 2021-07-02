-------------------------------------------------------------------------------
--
-- Title       : COMP8_MULT_APPROX
-- Design      : MULTIPLIERS
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : COMP8_MULT_APPROX.vhd
-- Generated   : Fri Jun 25 19:13:09 2021
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
--{entity {COMP8_MULT_APPROX} architecture {COMP8_MULT_APPROX}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity COMP8_MULT_APPROX is
	port ( --port declaration  
		signal op0: in std_logic_vector(7 downto 0); -- First operand
		signal op1: in std_logic_vector(7 downto 0); -- Second operand
		
		signal answer: out std_logic_vector(15 downto 0) -- Answer of Multiplication
		
		);
end COMP8_MULT_APPROX;

--}} End of automatically maintained section

architecture RTL of COMP8_MULT_APPROX is
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
signal s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11: std_logic;  
signal c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11: std_logic;  

--Middle signals for carries of the CPA
signal t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10: std_logic; 	
signal t11, t12, t13, t14, t15, t16, t17, t18, t19, t20: std_logic;	
signal t21, t22, t23, t24, t25, t26, t27, t28, t29, t30, t31, t32: std_logic;
signal t33, t34, t35, t36, t37, t38, t39, t40, t41, t42, t43: std_logic;
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
		port map (x(0) => PA0(3), x(1) => PA1(2), x(2) => PA2(1), x(3) => PA3(0), 
		cin => '0', cout => t0, s => S1, c => C1);
		
	-- instantiating the COMPRESSOR_5_TO_2 unit
	COMPRESS_5_0: entity work.COMPRESSOR_5_TO_2(RTL)
		port map (x(0) => PA0(4), x(1) => PA1(3), x(2) => PA2(2), x(3) => PA3(1), x(4) => PA4(0), 
		cin1 => '0', cin2 => t0, cout1 => t1, cout2 => t2, s => S2, c => C2);
		
	-- instantiating the COMPRESSOR_6_TO_2 unit
	COMPRESS_6_0: entity work.COMPRESSOR_6_TO_2(RTL)
		port map (x(0) => PA0(5), x(1) => PA1(4), x(2) => PA2(3), x(3) => PA3(2), x(4) => PA4(1), x(5) => PA5(0),
		cin1 => '0', cin2 => t1, cin3 => t2, cout1 => t3, cout2 => t4, cout3 => t5, s => S3, c => C3);
		
	-- instantiating the COMPRESSOR_7_TO_2 unit
	COMPRESS_7_0: entity work.COMPRESSOR_7_TO_2(RTL)
		port map (x(0) => PA0(6), x(1) => PA1(5), x(2) => PA2(4), x(3) => PA3(3), x(4) => PA4(2), x(5) => PA5(1), x(6) => PA6(0),
		cin1 => '0', cin2 => t3, cin3 => t4, cin4 => t5, cout1 => t6, cout2 => t7, cout3 => t8, cout4 => t9, s => S4, c => C4); 
		
	-- instantiating the COMPRESSOR_8_TO_2 unit
	COMPRESS_8_0_approx: entity work.COMPRESSOR8_2_APPROXIMATE(RTL)
		port map (a => PA0(7), b => PA1(6), c => PA2(5), d => PA3(4), e => PA4(3), f => PA5(2), g => PA6(1), h => PA7(0),
		cin0 => '0', cin1 => t6, cin2 => t7, cin3 => t8, cin4 => t9, cout0 => t10, cout1 => t11, cout2 => t12, cout3 => t13, cout4 => t14, sum => S5, carry => C5); 
		
	-- instantiating the COMPRESSOR_8_TO_2 unit
	COMPRESS_8_1_approx: entity work.COMPRESSOR8_2_APPROXIMATE(RTL)
		port map (a => '0', b => PA1(7), c => PA2(6), d => PA3(5), e => PA4(4), f => PA5(3), g => PA6(2), h => PA7(1),
		cin0 => t10, cin1 => t11, cin2 => t12, cin3 => t13, cin4 => t14, cout0 => t15, cout1 => t16, cout2 => t17, cout3 => t18, cout4 => t19, sum => S6, carry => C6);
		
	-- instantiating the COMPRESSOR_7_TO_2 unit
	COMPRESS_7_1: entity work.COMPRESSOR_7_TO_2(RTL)
		port map (x(0) => t15, x(1) => PA2(7), x(2) => PA3(6), x(3) => PA4(5), x(4) => PA5(4), x(5) => PA6(3), x(6) => PA7(2),
		cin1 => t16, cin2 => t17, cin3 => t18, cin4 => t19, cout1 => t20, cout2 => t21, cout3 => t22, cout4 => t23, s => S7, c => C7); 
		
	-- instantiating the COMPRESSOR_6_TO_2 unit
	COMPRESS_6_1: entity work.COMPRESSOR_6_TO_2(RTL)
		port map (x(0) => t20, x(1) => PA3(7), x(2) => PA4(6), x(3) => PA5(5), x(4) => PA6(4), x(5) => PA7(3),
		cin1 => t21, cin2 => t22, cin3 => t23, cout1 => t24, cout2 => t25, cout3 => t26, s => S8, c => C8);
		
	-- instantiating the COMPRESSOR_5_TO_2 unit
	COMPRESS_5_1: entity work.COMPRESSOR_5_TO_2(RTL)
		port map (x(0) => t24, x(1) => PA4(7), x(2) => PA5(6), x(3) => PA6(5), x(4) => PA7(4), 
		cin1 => t25, cin2 => t26, cout1 => t27, cout2 => t28, s => S9, c => C9);
		
	-- instantiating the COMPRESSOR_4_TO_2 unit
	COMPRESS_4_1: entity work.COMPRESSOR_4_TO_2(RTL)
		port map (x(0) => t27, x(1) => PA5(7), x(2) => PA6(6), x(3) => PA7(5), 
		cin => t28, cout => t29, s => S10, c => C10);
		
	-- instantiating the CSA unit
	CSA1: entity work.FA(RTL)
		port map (a => t29, b => PA6(7), cin => PA7(6), sum => S11, cout => C11);
		
		
		
	
	--===================================================================================
	--                         CARRY PRPAGATE ADDER (CPA)
	--===================================================================================  
	
	-- instantiating the CSA unit
	CPA0: entity work.FA(RTL)
		port map (a => PA0(0), b => '0', cin => '0', sum => answer(0), cout => t30);	
		
	-- instantiating the CSA unit
	CPA1: entity work.FA(RTL)
		port map (a => PA0(1), b => PA1(0), cin => t30, sum => answer(1), cout => t31);	
		
	-- instantiating the CSA unit
	CPA2: entity work.FA(RTL)
		port map (a => s0, b => '0', cin => t31, sum => answer(2), cout => t32);	
		
	-- instantiating the CSA unit
	CPA3: entity work.FA(RTL)
		port map (a => s1, b => c0, cin => t32, sum => answer(3), cout => t33);	
		
	-- instantiating the CSA unit
	CPA4: entity work.FA(RTL)
		port map (a => s2, b => c1, cin => t33, sum => answer(4), cout => t34);	
		
	-- instantiating the CSA unit
	CPA5: entity work.FA(RTL)
		port map (a => s3, b => c2, cin => t34, sum => answer(5), cout => t35);	
		
	-- instantiating the CSA unit
	CPA6: entity work.FA(RTL)
		port map (a => s4, b => c3, cin => t35, sum => answer(6), cout => t36);	
		
	-- instantiating the CSA unit
	CPA7: entity work.FA(RTL)
		port map (a => s5, b => c4, cin => t36, sum => answer(7), cout => t37);	
		
	-- instantiating the CSA unit
	CPA8: entity work.FA(RTL)
		port map (a => s6, b => c5, cin => t37, sum => answer(8), cout => t38);	
		
	-- instantiating the CSA unit
	CPA9: entity work.FA(RTL)
		port map (a => s7, b => c6, cin => t38, sum => answer(9), cout => t39);	
		
	-- instantiating the CSA unit
	CPA10: entity work.FA(RTL)
		port map (a => s8, b => c7, cin => t39, sum => answer(10), cout => t40);	
		
	-- instantiating the CSA unit
	CPA11: entity work.FA(RTL)
		port map (a => s9, b => c8, cin => t40, sum => answer(11), cout => t41);	
		
	-- instantiating the CSA unit
	CPA12: entity work.FA(RTL)
		port map (a => s10, b => c9, cin => t41, sum => answer(12), cout => t42);	
		
	-- instantiating the CSA unit
	CPA13: entity work.FA(RTL)
		port map (a => s11, b => c10, cin => t42, sum => answer(13), cout => t43);	
		
	-- instantiating the CSA unit
	CPA14: entity work.FA(RTL)
		port map (a => PA7(7), b => c11, cin => t43, sum => answer(14), cout => answer(15));

end architecture RTL;
