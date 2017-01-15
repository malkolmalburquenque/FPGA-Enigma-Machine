library ieee; -- allows use of the std_logic_vector type
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity g04_lr_barrel_shifter is
port ( x : in std_logic_vector(25 downto 0);
		 N : in std_logic_vector(4 downto 0);
		 y : out std_logic_vector(25 downto 0);
		 sel: in std_logic);
end g04_lr_barrel_shifter; 
architecture behaviour of g04_lr_barrel_shifter is
signal temp_output: std_logic_vector(25 downto 0);
begin
process(sel, N, x)
begin
case sel is 
when '0'=> --left
case N is 
when "00000"=>
	temp_output<= x;
when "00001"=>
	temp_output<= x(24 downto 0) & x(25);
when "00010"=>
	temp_output<= x(23 downto 0) & x(25 downto 24);
when "00011"=>
	temp_output<= x(22 downto 0) & x(25 downto 23);
when "00100"=>
	temp_output<= x(21 downto 0) & x(25 downto 22);
when "00101"=>
	temp_output<= x(20 downto 0) & x(25 downto 21);
when "00110"=>
	temp_output<= x(19 downto 0) & x(25 downto 20);
when "00111"=>
	temp_output<= x(18 downto 0) & x(25 downto 19);
when "01000"=>
	temp_output<= x(17 downto 0) & x(25 downto 18);
when "01001"=>
	temp_output<= x(16 downto 0) & x(25 downto 17);
when "01010"=>
	temp_output<= x(15 downto 0) & x(25 downto 16);
when "01011"=>
	temp_output<= x(14 downto 0) & x(25 downto 15);
when "01100"=>
	temp_output<= x(13 downto 0) & x(25 downto 14);
when "01101"=>
	temp_output<= x(12 downto 0) & x(25 downto 13);
when "01110"=>
	temp_output<= x(11 downto 0) & x(25 downto 12);
when "01111"=>
	temp_output<= x(10 downto 0) & x(25 downto 11);
when "10000"=>
	temp_output<= x(9 downto 0) & x(25 downto 10);
when "10001"=>
	temp_output<= x(8 downto 0) & x(25 downto 9);
when "10010"=>
	temp_output<= x(7 downto 0) & x(25 downto 8);
when "10011"=>
	temp_output<= x(6 downto 0) & x(25 downto 7); 
when "10100"=>
	temp_output<= x(5 downto 0) & x(25 downto 6);
when "10101"=>
	temp_output<= x(4 downto 0) & x(25 downto 5);
when "10110"=>
	temp_output<= x(3 downto 0) & x(25 downto 4);
when "10111"=>
	temp_output<= x(2 downto 0) & x(25 downto 3) ;
when "11000"=>
	temp_output<= x(1 downto 0) & x(25 downto 2) ;
when others=>
	temp_output<= x(0) & x(25 downto 1);
end case;


when others=> --right
case N is 
when "00000"=>
	temp_output<= x(25 downto 0);
when "00001"=>
   temp_output<= x(0) & x(25 downto 1);
when "00010"=>
   temp_output<= x(1 downto 0) & x(25 downto 2) ;
when "00011"=>
	temp_output<= x(2 downto 0) & x(25 downto 3);
when "00100"=>
	temp_output<= x(3 downto 0) & x(25 downto 4);
when "00101"=>
	temp_output<= x(4 downto 0) & x(25 downto 5);
when "00110"=>
	temp_output<= x(5 downto 0) & x(25 downto 6);
when "00111"=>
	temp_output<= x(6 downto 0) & x(25 downto 7); 
when "01000"=>
	temp_output<= x(7 downto 0) & x(25 downto 8);
when "01001"=>
	temp_output<= x(8 downto 0) & x(25 downto 9);
when "01010"=>
	temp_output<= x(9 downto 0) & x(25 downto 10);
when "01011"=>
	temp_output<= x(10 downto 0) & x(25 downto 11);
when "01100"=>
	temp_output<= x(11 downto 0) & x(25 downto 12);
when "01101"=>
	temp_output<= x(12 downto 0) & x(25 downto 13);
when "01110"=>
	temp_output<= x(13 downto 0) & x(25 downto 14);
when "01111"=>
	temp_output<= x(14 downto 0) & x(25 downto 15);
when "10000"=>
	temp_output<= x(15 downto 0) & x(25 downto 16);
when "10001"=>
	temp_output<= x(16 downto 0) & x(25 downto 17);
when "10010"=>
	temp_output<= x(17 downto 0) & x(25 downto 18);
when "10011"=>
	temp_output<= x(18 downto 0) & x(25 downto 19);
when "10100"=>
	temp_output<= x(19 downto 0) & x(25 downto 20);
when "10101"=>
	temp_output<= x(20 downto 0) & x(25 downto 21);
when "10110"=>
	temp_output<= x(21 downto 0) & x(25 downto 22);
when "10111"=>
	temp_output<= x(22 downto 0) & x(25 downto 23);
when "11000"=>
	temp_output<= x(23 downto 0) & x(25 downto 24);
when others=>
	temp_output<= x(24 downto 0) & x(25);
end case;
end case;
end process;
y<=temp_output;
end behaviour; 

