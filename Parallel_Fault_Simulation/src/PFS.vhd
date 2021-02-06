-------------------------------------------------------------------------------
--
-- Title       : PFS
-- Design      : Fault_Simulation
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : PFS.vhd
-- Generated   : Sun Jan 10 11:15:58 2021
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
--{entity {PFS} architecture {PFS}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity PFS is 
	port( 
	clk:   in std_logic;
	reset: in std_logic;
	a, b, c, f, h: in std_logic; -- Primary Inputs
	mo1, mo2, mo3, mo4, mo5, mo6, mo7, mo8, mo9, moA: out std_logic; -- 10 parallel data paths
	detect: out std_logic_vector(8 downto 0);	-- to find out if the SS-at is detectable 
	Q: out std_logic;	 -- First Primary Output 
	W: out std_logic	 -- Second Primary Output
	);
end PFS;

--}} End of automatically maintained section

architecture PFS of PFS is 
signal i1, j1, k1, l1, e1, g1, m1, d1: std_logic; -- middle signals
signal i2, j2, k2, l2, e2, g2, m2, d2: std_logic;
signal i3, j3, k3, l3, e3, g3, m3, d3: std_logic;
signal i4, j4, k4, l4, e4, g4, m4, d4: std_logic;  
signal i5, j5, k5, l5, e5, g5, m5, d5: std_logic;
signal i6, j6, k6, l6, e6, g6, m6, d6: std_logic; 
signal i7, j7, k7, l7, e7, g7, m7, d7: std_logic;
signal i8, j8, k8, l8, e8, g8, m8, d8: std_logic;
signal i9, j9, k9, l9, e9, g9, m9, d9: std_logic;
signal iA, jA, kA, lA, eA, gA, mA, dA: std_logic; 

signal mid: std_logic;

signal fi1, fi2, fi3, fi4, fi5, fi6, fi7, fi8: std_logic; -- for fault injection
begin 
	--======================================= FIRST DATA PATH (FAULT-FREE CIRCUIT)
	d1 <= c;
	e1 <= c;
	g1 <= not e1;	
	i1 <= b and d1; 
	j1 <= f or g1;
	k1 <= i1 nor j1;
	l1 <= k1 nand a;
	m1 <= h xor l1;	
	--===========================================================================	
	
	--======================================= SECOND DATA PATH (SS-at-0 in d2)
	d2 <= c and '0'; -- *** fault injection ***
	e2 <= c;
	g2 <= not e2;
	i2 <= b and d2;
	j2 <= f or g2;
	k2 <= i2 nor j2;
	l2 <= k2 nand a;
	m2 <= h xor l2;	
	--=========================================================================== 
	
	--======================================= THIRD DATA PATH (SS-at-1 in k3)	
	d3 <= c;
	e3 <= c;
	g3 <= not e3;
	i3 <= b and d3;
	j3 <= f or g3;
	k3 <= i3 nor j3;
	fi1 <= k3 or '1';    -- *** fault injection ***
	l3 <= fi1 nand a;    -- *** fault injection ***
	m3 <= h xor l3;		
	--===========================================================================
	
	--======================================= FOURTH DATA PATH (SS-at-0 in j4) 
	d4 <= c;
	e4 <= c;
	g4 <= not e4;
	i4 <= b and d4;
	j4 <= f or g4;
	fi2 <= j4 and '0';  -- *** fault injection ***
	k4 <= i4 nor fi2;   -- *** fault injection ***
	l4 <= k4 nand a;
	m4 <= h xor l4;		
	--===========================================================================
	
	--======================================= FIFTH DATA PATH (SS-at-1 in m5) 
	d5 <= c;
	e5 <= c;
	g5 <= not e5;
	i5 <= b and d5;
	j5 <= f or g5; 
	k5 <= i5 nor j5;   
	l5 <= k5 nand a;
	fi3 <= h xor l5;  -- *** fault injection ***
	m5 <= fi3 or '1'; -- *** fault injection ***	
	--===========================================================================	 
	
	--======================================= SIXTH DATA PATH (SS-at-0 in h) 
	d6 <= c;
	e6 <= c;
	g6 <= not e6;	
	i6 <= b and d6; 
	j6 <= f or g6;
	k6 <= i6 nor j6;
	l6 <= k6 nand a;
	fi4 <= h and '0'; -- *** fault injection ***
	m6 <= fi4 xor l6; -- *** fault injection ***		
	--===========================================================================	
	
	--======================================= SEVENTH DATA PATH (SS-at-1 in g7) 
	d7 <= c;
	e7 <= c;
	g7 <= not e7;	
	i7 <= b and d7; 
	fi5 <= g7 or '1'; -- *** fault injection ***
	j7 <= f or fi5;	  -- *** fault injection ***
	k7 <= i7 nor j7;
	l7 <= k7 nand a;
	m7 <= h xor l7;		
	--===========================================================================	
	
	--======================================= EIGHTH DATA PATH (SS-at-0 in l8) 
	d8 <= c;
	e8 <= c;
	g8 <= not e8;	
	i8 <= b and d8; 
	j8 <= f or g8;
	k8 <= i8 nor j8;
	l8 <= k8 nand a;
	fi6 <= l8 and '0';	-- *** fault injection ***
	m8 <= h xor fi6;	-- *** fault injection ***	
	--===========================================================================	
	
	--======================================= NINTH DATA PATH (SS-at-0 in f) 
	d9 <= c;
	e9 <= c;
	g9 <= not e9;	
	i9 <= b and d9; 
	fi7 <= f and '0'; -- *** fault injection ***
	j9 <= fi7 or g9;  -- *** fault injection ***
	k9 <= i9 nor j9;
	l9 <= k9 nand a;
	m9 <= h xor l9;	
	--===========================================================================	
	
	--======================================= TENTH DATA PATH (SS-at-1 in iA) 
	dA <= c;
	eA <= c;
	gA <= not eA;	
	iA <= b and dA; 
	jA <= f or gA;
	fi8 <= iA or '1'; -- *** fault injection ***
	kA <= fi8 nor jA; -- *** fault injection ***
	lA <= kA nand a;
	mA <= h xor lA;		
	--===========================================================================	
	
	
	mo1 <= m1; -- showing middle outputs in the simulation
	mo2 <= m2;
	mo3 <= m3;
	mo4 <= m4;
	mo5 <= m5;
	mo6 <= m6;
	mo7 <= m7;
	mo8 <= m8;
	mo9 <= m9;
	moA <= mA;
	
	-- showing which faults can be found (observable faults)
	detect(8) <= m2 xor m1;	
	detect(7) <= m3 xor m1;
	detect(6) <= m4 xor m1;
	detect(5) <= m5 xor m1;	
	detect(4) <= m6 xor m1;
	detect(3) <= m7 xor m1;
	detect(2) <= m8 xor m1;
	detect(1) <= m9 xor m1;
	detect(0) <= mA xor m1;
	
	-- PRIMARY OUTPUTS
	mid <= m1 xnor m2 xnor m3 xnor m4 xnor m5 xnor m6 xnor m7 xnor m8 xnor m9 xnor mA; 
	Q <= mid;
	W <= mid when (m1 and m6) = '0' else (mA or m4);
	


end PFS;
