library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity g04_Complete_Enigma_FPGA is
port (
      clock: in std_logic;
		switches: in std_logic_vector (5 downto 0);
		display3: out std_logic_vector(6 downto 0);
		display2: out std_logic_vector(6 downto 0);
		display1: out std_logic_vector(6 downto 0);
		display0: out std_logic_vector(6 downto 0);
		resetSettings: in std_logic;--pushbutton0
		resetEnigma: in std_logic;  --pushbutton1
		keypress: in std_logic;     --pushbutton3
		init: in std_logic   		 --pushbutton2
		);
end g04_Complete_Enigma_FPGA;

architecture behav of g04_Complete_Enigma_FPGA is

type state_type is (s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10);
signal current_state,next_state: state_type;

component g04_5bit_register is  
  port(D : in std_logic_vector(4 downto 0);
		clock: in std_logic;
      Q : out std_logic_vector(4 downto 0));  
end component;

component g04_2bit_register is  
  port(D : in std_logic_vector(1 downto 0); 
 		clock: in std_logic; 
      Q : out std_logic_vector(1 downto 0));  
end component;

component g04_1bit_register is  
  port(D : in std_logic; 
 		clock: in std_logic; 
      Q : out std_logic_vector);  
end component;

component g04_enigma_machine is
		port (keypress, clock, init,reset: in std_logic;
		input: in std_logic_vector(4 downto 0);
		rotor_typeL, rotor_typeM, rotor_typeR: in std_logic_vector(1 downto 0);
		reflector_type: in std_LOGIC;
		ring_settingL, ring_settingM, ring_settingR: in std_logic_vector(4 downto 0);
		load_dataR: std_logic_vector(4 downto 0);
		load_dataM: std_logic_vector(4 downto 0);
		load_dataL: std_logic_vector(4 downto 0);
		scrambled_code: out std_logic_vector(4 downto 0);
		output_display: out std_logic_vector(6 downto 0)
		);
end component;

signal lrt_in, lrt_out, mrt_in,mrt_out, rrt_in,rrt_out: std_logic_vector(1 downto 0);
signal lrs_in,lrs_out, mrs_in,mrs_out, rrs_in,rrs_out, lip_in,lip_out, mip_in,mip_out, rip_in,rip_out, temp_input : std_logic_vector(4 downto 0);
signal rt: std_logic;

begin 

dLRT: g04_2bit_register port map (D=>lrt_in, Q=>lrt_out, clock=>clock);
dLRS: g04_5bit_register port map (D=>lrs_in, Q=>lrs_out, clock=>clock);
dLIP: g04_5bit_register port map (D=>lip_in, Q=>lip_out, clock=>clock);
dMRT: g04_2bit_register port map (D=>mrt_in, Q=>mrt_out, clock=>clock);
dMRS: g04_5bit_register port map (D=>mrs_in, Q=>mrs_out, clock=>clock);
dMIP: g04_5bit_register port map (D=>mip_in, Q=>mip_out, clock=>clock);
dRRT: g04_2bit_register port map (D=>rrt_in, Q=>rrt_out, clock=>clock);
dRRS: g04_5bit_register port map (D=>rrs_in, Q=>rrs_out, clock=>clock);
dRIP: g04_5bit_register port map (D=>rip_in, Q=>rip_out, clock=>clock);

enigmamachine: g04_enigma_machine port map (clock=>clock, keypress=>not keypress, init=> not init,reset=>not resetEnigma, input=>temp_input, rotor_typeL=>lrt_out, rotor_typeM=>mrt_out, rotor_typeR=>rrt_out,
															reflector_type=>rt, ring_settingL=>lrs_out, ring_settingM=>mrs_out, ring_settingR=>rrs_out, load_dataL=>lip_out,
															load_dataM=>mip_out, load_dataR=>rip_out, output_display=>display0);



process(Clock,resetSettings)
begin

if resetSettings='0' then 
current_state<=s0;
elsif (rising_edge(clock))  then
current_state<=next_state;
end if;
end process;

process (current_state,clock)
begin
case current_state is 
when s0=>
	if switches(5)='1' then
	next_state<=s1;
	else
	next_state<=s0;
	end if;

when s1=>
	if switches(5)='0' then
	next_state<=s2;
	else
	next_state<=s1;
	end if;
	
when s2=>
	if switches(5)='1' then
	next_state<=s3;
	else
	next_state<=s2;
	end if;
	
when s3=>
	if switches(5)='0' then
	next_state<=s4;
	else
	next_state<=s3;
	end if;
	
when s4=>
	if switches(5)='1' then
	next_state<=s5;
	else
	next_state<=s4;
	end if;
	
when s5=>
	if switches(5)='0' then
	next_state<=s6;
	else
	next_state<=s5;
	end if;

when s6=>
	if switches(5)='1' then
	next_state<=s7;
	else
	next_state<=s6;
	end if;
	
when s7=>
	if switches(5)='0' then
	next_state<=s8;
	else
	next_state<=s7;
	end if;
	
when s8=>
	if switches(5)='1' then
	next_state<=s9;
	else
	next_state<=s8;
	end if;
	
when s9=>
	if switches(5)='0' then
	next_state<=s10;
	else 
	next_state<=s9;
	end if;

when s10=>
	next_state<=s10;
	
end case;	
end process;

process(current_state)
begin
case current_state is

when s0=>
display3<="1000111";--L
display2<="1001110";--R
display1<="0000111";--T
--display0<="1111111";
lrt_in<=switches(1 downto 0);


when s1=>
display3<="1000111";--L
display2<="1001110";--R
display1<="0010010";--S
--display0<="1111111";
lrs_in<=switches(4 downto 0);

when s2=>
display3<="1000111";--L
display2<="1001111";--I
display1<="0001100";--P
--display0<="1111111";
lip_in<=switches(4 downto 0);

when s3=>
display3<="1001000";--M
display2<="1001110";--R
display1<="0000111";--T
--display0<="1111111";
mrt_in<=switches(1 downto 0);

when s4=>
display3<="1001000";--M
display2<="1001110";--R
display1<="0010010";--S
--display0<="1111111";
mrs_in<=switches(4 downto 0);

when s5=>
display3<="1001000";--M
display2<="1001111";--I
display1<="0001100";--P
--display0<="1111111";
mip_in<=switches(4 downto 0);

when s6=>
display3<="1001110";--R
display2<="1001110";--R
display1<="0000111";--T
--display0<="1111111";
rrt_in<=switches(1 downto 0);

when s7=>
display3<="1001110";--R
display2<="1001110";--R
display1<="0010010";--S
--display0<="1111111";
rrs_in<=switches(4 downto 0);

when s8=>
display3<="1001110";--R
display2<="1001111";--I
display1<="0001100";--P
--display0<="1111111";
rip_in<=switches(4 downto 0);

when s9=>
display3<="1001110";--R
display2<="0000110";--E
display1<="0000111";--T
--display0<="1111111";
rt<=switches(0);

when s10=>
display3<="1111111";
display2<="1111111";
display1<="1111111";
temp_input<=switches(4 downto 0);

end case;
end process;
end behav;

	
