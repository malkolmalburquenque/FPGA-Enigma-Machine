library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity g04_5bit_register is  
  port(D : in std_logic_vector(4 downto 0);
      clock: in std_logic;  
      Q : out std_logic_vector(4 downto 0));  
end g04_5bit_register; 
 
architecture behav of g04_5bit_register is  
  begin  
    process (Clock)  
      begin  
        if (Clock'event and Clock='1') then  
          Q <= D;  
        end if;  
    end process;  
end behav; 