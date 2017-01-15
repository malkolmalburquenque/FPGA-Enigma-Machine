library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity g04_stecker is
port (input_code : in std_logic_vector(4 downto 0);
      output_code: out std_logic_vector(4 downto 0));
end g04_stecker;

architecture behav of g04_stecker is
signal temp_output_code: std_logic_vector(4 downto 0);
begin
process (input_code)
begin
case input_code is
		when "00000"=>--**A**
			temp_output_code <= "00001";--**B**
		when "00001"=>--**B**
			temp_output_code <= "00000";--**A**
		when "00010"=>--**C**
			temp_output_code <= "00011";--**D**
		when "00011"=>--**D**
			temp_output_code <= "00010";--**C**
		when "00100"=>--**E**
			temp_output_code <= "00101";--**F**
		when "00101"=>--**F**
			temp_output_code <= "00100";--**E**
		when "00110"=>--**G**
			temp_output_code <= "00111";--**H**
		when "00111"=>--**H**
			temp_output_code <= "00110";--**G**
		when "01000"=>--**I**
			temp_output_code <= "01001";--**J**
		when "01001"=>--**J**
			temp_output_code <= "01000";--**I**
		when others =>
			temp_output_code <= input_code;
END CASE;
END PROCESS;
output_code<=temp_output_code;
end behav;