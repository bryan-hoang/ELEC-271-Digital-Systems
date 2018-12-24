library ieee;
use ieee.std_logic_1164.all;

entity minilabPart2 is
  port (clk, reset_n, load_en, d : in  std_logic;
        q                        : out std_logic);
end entity;

architecture logic of minilabPart2 is

begin
the_dff : process (clk, reset_n)
begin
	if (reset_n = '0') THEN
	q <= '0';
	elsif (clk'event and clk = '1') then
		if (load_en = '1') then
		q <= d;
		end if;
	end if;
	end process;
end logic;
	