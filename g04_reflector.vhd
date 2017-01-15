library ieee;
use ieee.std_logic_1164.all;

entity g04_reflector is
port( input_code: in std_logic_vector(4 downto 0);
		reflector_type: in std_logic;
		output_code: out std_logic_vector(4 downto 0));
end g04_reflector;

architecture behav of g04_reflector is
signal temp_output_code: std_logic_vector(4 downto 0);
begin
process(input_code,reflector_type)
begin
case reflector_type is
when '0' => -- REFLECTOR B
	case input_code is
		when "00000"=>--**A**
			temp_output_code <= "11000";--**Y**
		when "00001"=>--**B**
			temp_output_code <= "10001";--**R**
		when "00010"=>--**C**
			temp_output_code <= "10100";--**U**
		when "00011"=>--**D**
			temp_output_code <= "00111";--**H**
		when "00100"=>--**E**
			temp_output_code <= "10000";--**Q**
		when "00101"=>--**F**
			temp_output_code <= "10010";--**S**
		when "00110"=>--**G**
			temp_output_code <= "01011";--**L**
		when "00111"=>--**H**
			temp_output_code <= "00011";--**D**
		when "01000"=>--**I**
			temp_output_code <= "01111";--**P**
		when "01001"=>--**J**
			temp_output_code <= "10111";--**X**
		when "01010"=>--**K**
			temp_output_code <= "01101";--**N**
		when "01011"=>--**L**
			temp_output_code <= "00110";--**G**
		when "01100"=>--**M**
			temp_output_code <= "01110";--**O**
		when "01101"=>--**N**
			temp_output_code <= "01010"; --**K**
		when "01110"=>--**O**
			temp_output_code <= "01100"; --**M**	
		when "01111"=>--**P**
			temp_output_code <= "01000"; --**I**
		when "10000"=>--**Q**
			temp_output_code <= "00100"; --**E**
		when "10001"=>--**R**
			temp_output_code <= "00001"; --**B**					 
		when "10010"=>--**S**
			temp_output_code <= "00101"; --**F**
		when "10011"=>--**T**
			temp_output_code <= "11001"; --**Z**	
		when "10100"=>--**U**
			temp_output_code <= "00010"; --**C**
		when "10101"=>--**V**
			temp_output_code <= "10110"; --**W**
		when "10110"=>--**W**
			temp_output_code <= "10101"; --**V**		
		when "10111"=>--**X**
			temp_output_code <= "01001"; --**J**
		when "11000"=>--**Y**
			temp_output_code <= "00000"; --**A**	
		when others=>--**Z**
			temp_output_code <= "10011"; --**T**
	END CASE;
when others => -- REFLECTOR C
	case input_code is
		when "00000"=>--**A**
			temp_output_code <= "00101"; --**F**
		when "00001"=>--**B**
			temp_output_code <= "10101"; --**V**
		when "00010"=>--**C**
			temp_output_code <= "01111";--**P**
		when "00011"=>--**D**
			temp_output_code <= "01001"; --**J**
		when "00100"=>--**E**
			temp_output_code <= "01000"; --**I**
		when "00101"=>--**F**
			temp_output_code <= "00000"; --**A**
		when "00110"=>--**G**
			temp_output_code <= "01110";--**O**
		when "00111"=>--**H**
			temp_output_code <= "11000";--**Y**
		when "01000"=>--**I**
			temp_output_code <= "00100"; --**E**
		when "01001"=>--**J**
			temp_output_code <= "00011";--**D**
		when "01010"=>--**K**
			temp_output_code <= "10001";--**R**
		when "01011"=>--**L**
			temp_output_code <= "11001"; --**Z**
		when "01100"=>--**M**
			temp_output_code <= "10111";--**X**		
		when "01101"=>--**N**
			temp_output_code <= "10110"; --**W**
		when "01110"=>--**O**
			temp_output_code <= "00110";--**G**	
		when "01111"=>--**P**
			temp_output_code <= "00010"; --**C**
		when "10000"=>--**Q**
			temp_output_code <= "10011"; --**T**		
		when "10001"=>--**R**
			temp_output_code <= "01010"; --**K**					 
		when "10010"=>--**S**
			temp_output_code <= "10100";--**U**
		when "10011"=>--**T**
			temp_output_code <= "10000";--**Q**		
		when "10100"=>--**U**
			temp_output_code <= "10010";--**S**
		when "10101"=>--**V**
			temp_output_code <= "00001"; --**B**
		when "10110"=>--**W**
			temp_output_code <= "01101";--**N**		
		when "10111"=>--**X**
			temp_output_code <= "01100"; --**M**
		when "11000"=>--**Y**
			temp_output_code <= "00111";--**H**				
		when others=>--**Z**
			temp_output_code <= "01011";--**L**
	END CASE;
END CASE;
END PROCESS;
output_code<=temp_output_code;
end behav;