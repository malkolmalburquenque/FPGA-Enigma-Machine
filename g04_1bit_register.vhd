library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity g04_1bit_register is  
  port(D : in std_logic;  
      clock: in std_logic;  
      Q : out std_logic);  
end g04_1bit_register; 
 
architecture behav of g04_1bit_register is  
  begin  
    process (Clock)  
      begin  
        if (Clock'event and Clock='1') then  
          Q <= D;  
        end if;  
    end process;  
end behav; 