library ieee;
use ieee.std_logic_1164.all;

entity lab2 is
    port (a, b, c : in  std_logic;
          f       : out std_logic);
end entity;

architecture sop of lab2 is

begin

f <=    (not a  and      b  and  not c)     -- m2
	  or  (not a  and      b  and      c)     -- m3
	  or  (    a  and  not b  and      c)     -- m5
	  or  (    a  and      b  and  not c)     -- m6
	  or  (    a  and      b  and      c);    -- m7
	  
end architecture;


architecture pos of lab2 is

begin

f <=    (	   a  or       b  or       c)     -- M0
	  and (    a  or       b  or  not  c)     -- M1
	  and (not a  or       b  or       c);    -- M4

end architecture;
