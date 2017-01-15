-- 7-segment LED decoder
--
-- entity name: g04_7_segment_decoder
--
-- Copyright (C) 2016 Malkolm Alburquenque & Ryan Xu
-- Version 1.0
-- Author: Malkolm Alburquenque & Ryan Xu; malkolm.alburquenque@mail.mcgill.ca & shicheng.xu@mail.mcgill.ca
-- Date: Febuary 15, 2016

library ieee; -- allows use of the std_logic_vector type
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity g04_7_segment_decoder is
  port ( code : in std_logic_vector(4 downto 0); 
  segments : out std_logic_vector(6 downto 0));
  end g04_7_segment_decoder;
 architecture behaviour of g04_7_segment_decoder is
 signal presegment: std_logic_vector(6 downto 0);
 begin
 with code select 
 presegment <=
 "1110111" when "00000", 
	"1111100" when "00001",
	"0111001" when "00010",
	"1011110" when "00011",
	"1111001" when "00100",
	"1110001" when "00101",
	"0111101" when "00110",
	"1110100" when "00111",
	"0110000" when "01000",
	"0011110" when "01001",
	"1110000" when "01010",
	"0111000" when "01011",
	"0110111" when "01100",
	"1010100" when "01101",
	"0111111" when "01110",
	"1110011" when "01111",
	"1011100" when "10000",
	"0110001" when "10001",
	"1101101" when "10010",
	"1111000" when "10011",
	"0111110" when "10100",
	"0100110" when "10101",
	"0011100" when "10110",
	"1110110" when "10111",
	"1101110" when "11000",
	"1011011" when "11001",
	"0000000" when others;
segments <= NOT (presegment);	
end behaviour;