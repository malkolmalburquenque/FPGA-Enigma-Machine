library ieee; --** allows use of the std_logic_vector type
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity g04_rotor_stepper_fsm is
port( Clock, Keypress, init, Knock_M, KNock_R: in std_logic;
		en_l, en_m, en_r, load: out std_logic);
end g04_rotor_stepper_fsm;
architecture behav of g04_rotor_stepper_fsm is
type state_type is (s0,s1,s2,s3,s4,s5,s6,s7);
signal current_state,next_state: state_type;


begin


process(Clock,init)
begin

if init='1' then 
current_state<=s0;
elsif (rising_edge(clock))  then
current_state<=next_state;
end if;
end process;

process (current_state,clock)
begin
case current_state is 
when s0=>
	next_state<=s1;

	
when s1=>
	if keypress='0' then
	next_state<=s2;
	else
	next_state<=s1;
	end if;
	
when s2=>
	if keypress='1' then
	next_state<=s3;
	else
	next_state<=s2;
	end if;

when s3=>
	if knock_M='0' and knock_R='0' then
	next_state<=s4;
	elsif knock_M='0' and knock_R='1' then
	next_state<=s5;
	elsif knock_M='1' and knock_R='0' then
	next_state<=s6;
	else
	next_state<=s7;
	end if;

when s4=>
	next_state<=s1;
	
when s5=>
	next_state<=s4;

when s6=>
	next_state<=s5;
	
when s7 =>
	next_state<=s6;
	
end case;	
end process;

process(current_state)
begin
case current_state is
when s0=>
	load<='1';
	en_r<='0';
	en_m<='0';
	en_l<='0';
	
when s1=>
	en_r<='0';
	en_m<='0';
	en_l<='0';
	load <= '0';
	
when s2=>
	en_r<='0';
	en_m<='0';
	en_l<='0';
	load <= '0';
	
when s3=>
	en_r<='0';
	en_m<='0';
	en_l<='0';
	load <= '0';

when s4=>
	en_r<='1';
	en_m<='0';
	en_l<='0';
	load<='0';
	
when s5=>
	en_r<='0';
	en_m<='1';
	en_l<='0';
	load<='0';

when s6=>
	en_r<='0';
	en_m<='0';
	en_l<='1';
	load<='0';

when s7=>
	en_r<='0';
	en_m<='1';
	en_l<='0';
	load<='0';
end case;
end process;


end behav;
