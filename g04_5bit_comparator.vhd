LIBRARY ieee;
USE ieee.std_logic_1164.all; 

ENTITY g04_5bit_comparator IS 
	PORT
	(
		A :  IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		B :  IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
		AeqB :  OUT  STD_LOGIC
	);
END g04_5bit_comparator;

ARCHITECTURE behav OF g04_5bit_comparator IS
begin
process(A,B)
begin
if (A=B) then
	AeqB <= '1';
	else
	AeqB<='0';
end if;
end process;
end behav;

