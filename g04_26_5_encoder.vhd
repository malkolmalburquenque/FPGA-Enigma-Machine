-- This circuit takes as input a 26-bit vector and produces a 5-bit output named
-- INDEX which indicates the highest bit position over all input bits that have
-- a high value. If no inputs bits are high, then assert an ERROR signal.
--
-- entity name: g04_26_5_encoder
--
-- Copyright (C) 2016 Malkolm Alburquenque & Ryan Xu
-- Version 1.0
-- Author: Malkolm Alburquenque & Ryan Xu; malkolm.alburquenque@mail.mcgill.ca & shicheng.xu@mail.mcgill.ca
-- Date: Febuary 10, 2016

library ieee; -- allows use of the std_logic_vector type
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity g04_26_5_encoder is
port ( letter : in std_logic_vector(25 downto 0);
 INDEX : out std_logic_vector(4 downto 0);
 ERROR : out std_logic);
end g04_26_5_encoder; 

architecture behaviour of g04_26_5_encoder is  
	begin
	process (letter)
	begin
		ERROR <= '1';
		for i in 25 downto 0 loop
			if (letter(i) ='1') then 
				INDEX <= std_logic_vector(to_unsigned(i,5));
				ERROR <= '0';
				exit;
			end if;
		end loop;
	end process;
end behaviour;
