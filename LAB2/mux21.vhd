library ieee;
use ieee.std_logic_1164.all;

entity mux21 is
	port (s, x, y : in  std_logic;
		  f, g	  : out std_logic);
end entity;

architecture hots of mux21 is

begin

f <=      (not s  and      x)
	  or  (    s  and      y);

g <= x when(s= '0') else y;

end architecture;
