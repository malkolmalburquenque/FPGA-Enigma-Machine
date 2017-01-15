library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity g04_Rotor is
port(input_code, inv_input_code, data, ring_setting: in std_logic_vector(4 downto 0);
	 clock, enable, load, direction_0, direction_1, direction_2, direction_3,reset : in std_logic;
	 rotor_type_value: in std_logic_vector(1 downto 0);
	 output_code, inv_output_code, count_output: out std_logic_vector(4 downto 0));
end g04_Rotor;

architecture behav of g04_Rotor is

component g04_0_25_counter_load 
	port ( 
	reset: in std_logic;
	Clk : in std_logic;
	Enable: in std_logic;
	load: in std_logic;
	load_value: in std_logic_vector(4 downto 0);
	Count_out: out std_logic_vector (4 downto 0)
	);
end component;

component g04_26_5_encoder
port ( letter : in std_logic_vector(25 downto 0);
 INDEX : out std_logic_vector(4 downto 0);
 ERROR : out std_logic);
end component;

component g04_lr_barrel_shifter
port ( x : in std_logic_vector(25 downto 0);
		 N : in std_logic_vector(4 downto 0);
		 sel: in std_logic;
		 y : out std_logic_vector(25 downto 0));
end component;

component g04_Enigma
port(x: in std_logic_vector(4 downto 0);
	y: out std_logic_vector(25 downto 0);
	e: out std_logic);
end component;

component g04_permutation
port (input_code: in std_logic_vector(4 downto 0);
		rotor_type: in std_logic_vector(1 downto 0);
		output_code: out std_logic_vector(4 downto 0);
		inv_output_code: out std_logic_vector(4 downto 0));
end component;

signal temp_counter_out, temp_encoder_out, temp_perm_out: std_logic_vector(4 downto 0);
signal temp_decoder0_out, temp_decoder1_out, temp_barrel_0_out, temp_barrel_1_out, temp_barrel_2_out, temp_barrel_3_out: std_logic_vector(25 downto 0);


signal inv_temp_counter_out, inv_temp_encoder_out, inv_temp_perm_out: std_logic_vector(4 downto 0);
signal inv_temp_decoder0_out, inv_temp_decoder1_out, inv_temp_barrel_0_out, inv_temp_barrel_1_out, inv_temp_barrel_2_out, inv_temp_barrel_3_out: std_logic_vector(25 downto 0);
signal not_direction_0,not_direction_1,not_direction_2,not_direction_3: std_logic;
begin

not_direction_0<=not direction_0;
not_direction_1<=not direction_1;
not_direction_2<=not direction_2;
not_direction_3<=not direction_3;

counter: g04_0_25_counter_load port map(load_value => data, enable => enable, load => load, clk => clock, count_out=>temp_counter_out,reset=>reset);
inv_counter: g04_0_25_counter_load port map(load_value => data, enable => enable, load => load, clk => clock, count_out=>inv_temp_counter_out,reset=>reset);

decoder0: g04_Enigma port map (x => input_code, y=>temp_decoder0_out);
decoder1: g04_Enigma port map (x=> temp_perm_out, y=>temp_decoder1_out);
inv_decoder0: g04_Enigma port map (x => inv_input_code, y=>inv_temp_decoder0_out);
inv_decoder1: g04_Enigma port map (x=> inv_temp_perm_out, y=>inv_temp_decoder1_out);

barrelshifter0: g04_lr_barrel_shifter port map (x=>temp_decoder0_out, sel=>direction_0,N=>temp_counter_out, y=> temp_barrel_0_out);
barrelshifter1: g04_lr_barrel_shifter port map (x=>temp_barrel_0_out, sel=>direction_1,N=>ring_setting,y=>temp_barrel_1_out);
barrelshifter2: g04_lr_barrel_shifter port map (x=>temp_decoder1_out, sel=>direction_2,N=>ring_setting,y=>temp_barrel_2_out);
barrelshifter3: g04_lr_barrel_shifter port map (x=>temp_barrel_2_out, sel=>direction_3,N=>temp_counter_out, y=>temp_barrel_3_out);
inv_barrelshifter0: g04_lr_barrel_shifter port map (x=>inv_temp_decoder0_out, sel=>not_direction_0,N=>inv_temp_counter_out, y=> inv_temp_barrel_0_out);
inv_barrelshifter1: g04_lr_barrel_shifter port map (x=>inv_temp_barrel_0_out, sel=>not_direction_1,N=>ring_setting,y=>inv_temp_barrel_1_out);
inv_barrelshifter2: g04_lr_barrel_shifter port map (x=>inv_temp_decoder1_out, sel=>not_direction_2,N=>ring_setting,y=>inv_temp_barrel_2_out);
inv_barrelshifter3: g04_lr_barrel_shifter port map (x=>inv_temp_barrel_2_out, sel=>not_direction_3,N=>inv_temp_counter_out, y=>inv_temp_barrel_3_out);

encoder0: g04_26_5_encoder port map(letter => temp_barrel_1_out, index=>temp_encoder_out);
encoder1: g04_26_5_encoder port map(letter=>temp_barrel_3_out, index=>output_code);
inv_encoder0: g04_26_5_encoder port map(letter => inv_temp_barrel_1_out, index=>inv_temp_encoder_out);
inv_encoder1: g04_26_5_encoder port map(letter=>inv_temp_barrel_3_out, index=>inv_output_code);

permutator: g04_permutation port map (input_code=>temp_encoder_out,rotor_type=>rotor_type_value, output_code=>temp_perm_out);
inv_permutator: g04_permutation port map (input_code=>inv_temp_encoder_out,rotor_type=>rotor_type_value, inv_output_code=>inv_temp_perm_out);

count_output<=temp_counter_out;

end behav;