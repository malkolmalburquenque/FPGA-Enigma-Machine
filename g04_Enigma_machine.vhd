library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity g04_Enigma_machine is
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
end g04_Enigma_machine;

architecture behav of g04_Enigma_machine is

component g04_Rotor
port(input_code: in std_logic_vector(4 downto 0);
		inv_input_code: in std_logic_vector(4 downto 0);
		data: in std_logic_vector(4 downto 0);
		ring_setting: in std_logic_vector(4 downto 0);
		clock: in std_logic;
		rotor_type_value: in std_LOGIC_VECTOR(1 downto 0);
		enable: in std_logic;
		load: in std_logic;
		reset: in std_LOGIC;
		direction_0: in std_logic; 
		direction_1: in std_logic;
		direction_2: in std_logic;
		direction_3: in std_logic;
		output_code: out std_logic_vector(4 downto 0);
		inv_output_code: out std_logic_vector(4 downto 0);
		count_output: out std_logic_vector(4 downto 0)
		);
end component;

component g04_Stecker
port (input_code : in std_logic_vector(4 downto 0);
      output_code: out std_logic_vector(4 downto 0)
		);
end component;

component g04_reflector 
port( input_code: in std_logic_vector(4 downto 0);
		reflector_type: in std_logic;
		output_code: out std_logic_vector(4 downto 0));
end component;

component g04_lr_barrel_shifter
port ( x : in std_logic_vector(25 downto 0);
		 N : in std_logic_vector(4 downto 0);
		 y : out std_logic_vector(25 downto 0);
		 sel: in std_logic);
end component;

component g04_rotor_stepper_fsm
port( Clock: in std_logic;
		Keypress: in std_logic;
		init: in std_logic;
		Knock_M: in std_logic;
		Knock_R: in std_logic;
		en_l: out std_logic;
		en_m: out std_logic;
		en_r: out std_logic;
		load: out std_logic
		);
end component;

component g04_5bit_comparator 
	port (A :  IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
			B :  IN  STD_LOGIC_VECTOR(4 DOWNTO 0);
			AeqB :  OUT  STD_LOGIC
			);
end component;

component g04_7_segment_decoder 
  port ( code : in std_logic_vector(4 downto 0); 
  segments : out std_logic_vector(6 downto 0));
end component;

signal Notch_R: std_logic_vector(4 downto 0):="10000"; -- assign value
signal Notch_M: std_logic_vector(4 downto 0):="00100"; -- assign value
constant direction0: std_logic:='1'; --assignvalue
constant direction1: std_logic:='1'; --assignvalue
constant direction2: std_logic:='1'; --assignvalue
constant direction3: std_logic:='1'; --assignvalue
signal temp_stecker_out, temp_inv_stecker_out, temp_reflector_out: std_logic_vector(4 downto 0); 
signal temp_rotorR_out, temp_rotorM_out, temp_rotorL_out: std_logic_vector(4 downto 0);
signal temp_rotorR_inv_out, temp_rotorM_inv_out, temp_rotorL_inv_out: std_logic_vector(4 downto 0);
signal temp_rotorR_count_out, temp_rotorM_count_out: std_logic_vector(4 downto 0);
signal temp_fsm_load, temp_fsm_en_R, temp_fsm_en_M, temp_fsm_en_L,temp_comparatorR_out, temp_comparatorM_out: std_logic;

begin

fsm: g04_rotor_stepper_fsm port map (clock=>clock, keypress=>keypress, init=>init, Knock_M=>temp_comparatorM_out, Knock_R=>temp_comparatorR_out, en_l=>temp_fsm_en_L,
													en_m=>temp_fsm_en_M, en_r=>temp_fsm_en_R, load=>temp_fsm_load);
					
comparatorR: g04_5bit_comparator port map(A=>temp_rotorR_count_out, B=>Notch_R, AeqB=>temp_comparatorR_out);
comparatorM: g04_5bit_comparator port map(A=>temp_rotorM_count_out, B=>Notch_M, AeqB=>temp_comparatorM_out);


stecker: g04_Stecker port map (input_code=>input, output_code=> temp_stecker_out); -- need to change back
inv_stecker: g04_stecker port map (input_code=>temp_rotorR_inv_out, output_code=>temp_inv_stecker_out);

rotorR: g04_Rotor port map (rotor_type_value=>rotor_typeR, input_code=>temp_stecker_out, inv_input_code=>temp_rotorM_inv_out, data=>load_dataR, ring_setting=>ring_settingR, clock=>clock, 
									enable=>temp_fsm_en_R, load=> temp_fsm_load, direction_0=>direction0, direction_1=>direction1, direction_2=>direction2, direction_3=>direction3,
									output_code=>temp_rotorR_out, inv_output_code=>temp_rotorR_inv_out, count_output=>temp_rotorR_count_out,reset=>reset);
rotorM: g04_Rotor port map (rotor_type_value=>rotor_typeM, input_code=>temp_rotorR_out, inv_input_code=>temp_rotorL_inv_out, data=>load_dataM, ring_setting=>ring_settingM, clock=>clock, 
									enable=>temp_fsm_en_M, load=> temp_fsm_load, direction_0=>direction0, direction_1=>direction1, direction_2=>direction2, direction_3=>direction3,
									output_code=>temp_rotorM_out, inv_output_code=>temp_rotorM_inv_out, count_output=>temp_rotorM_count_out,reset=>reset);
rotorL: g04_Rotor port map (rotor_type_value=>rotor_typeL, input_code=>temp_rotorM_out, inv_input_code=>temp_reflector_out, data=>load_dataL, ring_setting=>ring_settingL, clock=>clock,  
									enable=>temp_fsm_en_L, load=> temp_fsm_load, direction_0=>direction0, direction_1=>direction1, direction_2=>direction2, direction_3=>direction3,
									output_code=>temp_rotorL_out, inv_output_code=>temp_rotorL_inv_out,reset=>reset);

reflector: g04_reflector port map (input_code=>temp_rotorL_out, reflector_type=> reflector_type, output_code=> temp_reflector_out);

display: g04_7_segment_decoder port map(code=>temp_inv_stecker_out, segments=>output_display);

scrambled_code<=temp_inv_stecker_out;

end behav;


