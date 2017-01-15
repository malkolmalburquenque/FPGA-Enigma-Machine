library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;

entity g04_Enigma is
port(x: in std_logic_vector(4 downto 0);
	y: out std_logic_vector(25 downto 0);
	e: out std_logic);
end g04_Enigma;

architecture behaviour of g04_Enigma is 
begin
y(0) <= '1' when x = "00000" else '0';

y(1) <= '1' when x = "00001" else '0';

y(2) <= '1' when x = "00010" else '0';

y(3) <= '1' when x = "00011" else '0';

y(4) <= '1' when x = "00100" else '0';

y(5) <= '1' when x = "00101" else '0';

y(6) <= '1' when x = "00110" else '0';

y(7) <= '1' when x = "00111" else '0';

y(8) <= '1' when x = "01000" else '0';

y(9) <= '1' when x = "01001" else '0';

y(10) <= '1' when x = "01010" else '0';

y(11) <= '1' when x = "01011" else '0';

y(12) <= '1' when x = "01100" else '0';

y(13) <= '1' when x = "01101" else '0';

y(14) <= '1' when x = "01110" else '0';

y(15) <= '1' when x = "01111" else '0';

y(16) <= '1' when x = "10000" else '0';

y(17) <= '1' when x = "10001" else '0';

y(18) <= '1' when x = "10010" else '0';

y(19) <= '1' when x = "10011" else '0';

y(20) <= '1' when x = "10100" else '0';

y(21) <= '1' when x = "10101" else '0';

y(22) <= '1' when x = "10110" else '0';

y(23) <= '1' when x = "10111" else '0';

y(24) <= '1' when x = "11000" else '0';

y(25) <= '1' when x = "11001" else '0';

e <= '1' when x = "11010" or x = "11011" or x = "11100" or x = "11101" or x = "11110" or x = "11111" else '0'; 

end behaviour;

