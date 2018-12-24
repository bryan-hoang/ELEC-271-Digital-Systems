library ieee;
use ieee.std_logic_1164.all;

entity fsm is -- Controller for the lab5 datapath
  port (
        clk, reset_n, go_n : in  std_logic;
        pattern            : out std_logic_vector(2 downto 0);
        display            : out std_logic_vector(1 downto 0);
        enable             : out std_logic
       );
end entity;

architecture behavior of fsm is

-- Define state type and signal for single-process high-level specification
type ... is (...);
signal ... : ...;

begin

-- Define the process that implements the state transitions on clock edges
the_fsm : process (clk, reset_n)
begin
  .
  .
  .
end process;

-- Use signal assignment statements with when...else... syntax
-- to specific the behavior of the pattern, display, and enable outputs

... <= ...;

... <= ...;

... <= ...;

end architecture;
