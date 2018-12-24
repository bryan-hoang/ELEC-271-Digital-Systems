library ieee;
use ieee.std_logic_1164.all;

entity lab4 is
  port (
    clk, reset_n : in std_logic;
    le : in std_logic;
    ledg3, ledg2, ledg1, ledg0 : out std_logic
  );
end entity;

architecture logic of lab4 is

signal d3, d2, d1, d0 : std_logic;  -- flip-flop d inputs
signal q3, q2, q1, q0 : std_logic;  -- flip-flop q outputs

begin

-- single process encompassing all four flip-flops
-- (i.e., a register, but without using std_logic_vector type)

the_flipflops : process (clk, reset_n)
begin
  if (reset_n = '0') then
    q3 <= '0';	q2 <= '0';	q1 <= '0';	q0 <= '0';
  elsif (clk'event and clk = '1') then
    if (le = '1') then
      q3 <= d3; q2 <= d2; q1 <= d1; q0 <= d0;
    end if;
  end if;
end process;

-- Combinational functions that generate
-- the new d value from the current q outputs.
-- (optimized by exploiting don't-care cases)

d3 <=      not q3 or  not q1;
d2 <=          q3 and not q2;
d1 <=     (    q3 and     q2) 
      or  (    q1 and     q0);
d0 <=      not q3 or  not q1;

ledg3 <= q3;
ledg2 <= q2;
ledg1 <= q1;
ledg0 <= q0;

end architecture;
