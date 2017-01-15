library ieee; -- allows use of the std_logic_vector type
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity g04_0_25_counter_load is
  port ( reset, Clk, enable, load : in std_logic;
			load_value: in std_logic_vector(4 downto 0);
			count_out : out std_logic_vector(4 downto 0));
  end g04_0_25_counter_load;
  
 architecture behaviour of g04_0_25_counter_load is
 signal count : std_logic_vector (4 downto 0);
 begin
 counter1: process (reset, Clk)
 begin 
 if reset = '1' then
	 count <= "00000";
 elsif Clk = '1' and Clk'event then
	if load = '1' then
		count<=load_value;
	else
		if enable = '1' then
			count <= std_logic_vector(unsigned(count) + 1);
		end if;
		if count ="11001" then
			count <="00000";
		end if;
	end if;
end if;	
end process;
		count_out <= count;
end behaviour;
