library ieee;
use ieee.std_logic_1164.all;

entity lab3 is
  port (x  , y  , z   : in  std_logic;
        fsp, fps      : out std_logic);
end entity;

architecture logic of lab3 is

begin

	fsp <=    (    x  and  not z)
			or  (not y  and      z);

	fps <=    (x or z)
	      and (not y or not z);
			
end logic;
