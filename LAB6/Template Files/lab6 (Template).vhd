library ieee;
use ieee.std_logic_1164.all;

entity lab6 is
  port (clk, reset_n : in   std_logic;
        ..., ...     : in   std_logic; -- Primary inputs to both implementations
        ..., ...     : out  std_logic; -- Gate-level fsm primary outputs
        ..., ...     : out  std_logic; -- Gate-level fsm state-bit outputs
        ..., ...     : out  std_logic  -- High-level fsm primary outputs
        );
end entity;

architecture combined of lab6 is

-- For gate-level specification:

-- Define internal signals q0, q1, ... for individual state flip-flop outputs
signal ... : ...;

-- Define internal signals d0, d1, ... for individual state flip-flop inputs
signal ... : ...;

-- For high-level specification;

-- Define state type and signal for single-process high-level specification
type ... is (...);
signal ... : ...;

begin

-- For gate-level specification:

-- Define combined process for behavior of individual state flip-flops
the_state_dffs : process(clk, reset_n)
begin
  .
  .
  .
end process;

-- Signal assignment statements for next-state d0, d1, ... functions
... <= ...;

-- Signal assignment statements for gate-level fsm primary output functions
... <= ...;

-- Signal assignment statements for gate-level fsm state-bit outputs
... <= ...;

-- For high-level specification:

-- Define the process that implements the state transitions on clock edges
the_fsm : process (clk, reset_n)
begin
  .
  .
  .
end process;

-- Use signal assignment statements with when...else... syntax
-- to specify the behavior of high-level fsm outputs
... <= ...;

end architecture;
