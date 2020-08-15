-------------------------------------------------------------------------------
--
-- Title       : RANDOM_GENERATOR
-- Design      : ELEVATOR
-- Author      : 
-- Company     : 
--
-------------------------------------------------------------------------------
--
-- File        : RANDOM_GENERATOR.vhd
-- Generated   : Wed Jul 22 12:09:37 2020
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
--{entity {RANDOM_GENERATOR} architecture {RANDOM_GENERATOR}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity RANDOM_GENERATOR is
	port(
	clk				: in std_logic;  
	reset			: in std_logic;  
	
	interrupt  		: out std_logic;
	random_floor 	: out std_logic_vector (3 downto 0)
	);
end RANDOM_GENERATOR;

--}} End of automatically maintained section

architecture RTL of RANDOM_GENERATOR is	

 -- maximal length 32-bit xnor LFSR
 function lfsr32(x : std_logic_vector(31 downto 0)) return std_logic_vector is
 	begin
 	return x(30 downto 0) & (x(0) xnor x(1) xnor x(21) xnor x(31));
 end function;
begin	  

	process(clk)
	variable random: std_logic_vector (31 downto 0);
	-- For determining the random_floor
	variable random_number : std_logic_vector (3 downto 0); -- random number genereated from LFSR 
	variable count: integer := 0;	 -- for making the results of the circuit more random
	variable inter : std_logic := '0'; 	 -- variable for saving the value of interrupt
	variable prev_inter : std_logic := '0';	-- making interrupt only one clock cycle on
	begin
	 	if rising_edge(clk) then
	 		if reset='1' then
	 			random := (others => '0');
	 		else   
	 			random := lfsr32(random);
	 		end if;	
			 
			 
			inter := random(23);
			
			-- Making sure that the interrupt stays one only for one clock cycle in a row
			if (inter = '1' and prev_inter = '1') then
				inter := '0';
			end if;
			 
			
			if (count = 0) then 				
				random_number := random(2) & random(11) & random(13) & random (25);	  
				count := count +1;
				prev_inter := inter;
			elsif (count = 1) then	
				random_number := random(4) & random(20) & random(15) & random (14);	  
				count := count +1; 
				prev_inter := inter;
			else		
				random_number := random(9) & random(7) & random(13) & random (8);	  
				count := 0;	
				prev_inter := inter;
			end if;
				
			
				
			-- Making sure that the random_floor is some number between 0 and 10
			if (to_integer(unsigned(random_number)) > 10) then
				random_number := std_logic_vector(unsigned(random_number) - 6);
			else
				random_number := random_number;
					
			end if;	
			
			-- putting the values of variables into the ports
			interrupt <= inter;
			random_floor <= random_number;
					
	 	end if;
		 
		

		
	end process;

end architecture RTL;
