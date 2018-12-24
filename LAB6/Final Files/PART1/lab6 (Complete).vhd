library ieee;
use ieee.std_logic_1164.all;

entity lab6 is
  port (clk, reset_n   : in   std_logic;
        w, x           : in   std_logic; -- Primary inputs to both implementations
        y_gl, z_gl     : out  std_logic; -- Gate-level fsm primary outputs
        q1_out, q0_out : out  std_logic; -- Gate-level fsm state-bit outputs
        y_hl, z_hl     : out  std_logic  -- High-level fsm primary outputs
        );
end entity;

architecture combined of lab6 is

------------------------------ Signal Assignment ------------------------------

--                       For gate-level specification:

-- Define internal signals q0, q1, ... for individual state flip-flop outputs
signal q1, q0 : std_logic;

-- Define internal signals d0, d1, ... for individual state flip-flop inputs
signal d1, d0 : std_logic;

--                       For high-level specification;

-- Define state type and signal for single-process high-level specification
type state_type is (A, B, C, D);
signal state : state_type;

--------------------------- Implementation of Logic ---------------------------

--                       For gate-level specification:
begin
-- Define combined process for behavior of individual state flip-flops
the_state_dffs : process (clk, reset_n)
begin
  if (reset_n = '0') then
    q1 <= '0';
    q0 <= '0';
  elsif (clk'event and clk = '1') then
	 q1 <= d1;
	 q0 <= d0;
  end if;
end process;

-- Signal assignment statements for next-state d0, d1, ... functions
d1 <= (not q1 and q0) or (not w and q1 and not q0) or (not x and q1 and not q0);
d0 <= (x and not q1 and q0) or (w and not q1 and not q0) or (w and not x and not q0);

-- Signal assignment statements for gate-level fsm primary output functions
y_gl <= q0;
z_gl <= not q1 or not q0;

-- Signal assignment statements for gate-level fsm state-bit outputs
q1_out <= q1;
q0_out <= q0;

--                       For high-level specification:

-- Define the process that implements the state transitions on clock edges
the_fsm : process (clk, reset_n)
begin
  if (reset_n = '0') then
    state <= A;
  elsif (clk'event and clk = '1') then
    case (state) is
      when A =>
        if (w = '1') then
          state <= B;
        end if;
		when B =>
		  if (x = '1') then
		    state <= D;
		  elsif (x = '0') then
			 state <= C;
        end if;
		when C =>
		  if (w = '1' and x = '0') then
			state <= D;
		  elsif (w = '1' and x = '1') then
			state <= A;
		  end if;
		when D =>
		 state <= A;
    end case;
  end if;
end process;

-- Use signal assignment statements with when...else... syntax
-- to specify the behavior of high-level fsm outputs
y_hl <= '1'      when (state = B or state = D)
    else '0'; -- when (state = ?)

z_hl <=  '0'     when (state = D)
    else '1'; -- when (state = ?)
end architecture;
