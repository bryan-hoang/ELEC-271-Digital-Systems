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
type state_type is (idle, C0, C1, C2, C3, pause, B0, B1, B2, B3);
signal state : state_type;

begin

-- Define the process that implements the state transitions on clock edges
the_fsm : process (clk, reset_n)
begin
  if (reset_n = '0') then
    state <= idle;
  elsif (clk'event and clk = '1') then
    case (state) is
      when idle =>
        if (go_n = '0') then
          state <= C0;
        end if;
      when C0 =>
        state <= C1;
      when C1 =>
        state <= C2;
      when C2 =>
        state <= C3;
      when C3 =>
        state <= pause;
      when pause =>
        if (go_n = '0') then
          state <= B0;
        end if;
      when B0 =>
        state <= B1;
      when B1 =>
        state <= B2;
      when B2 =>
        state <= B3;
      when B3 =>
        state <= idle;
    end case;
  end if;
end process;

-- Use signal assignment statements with when...else... syntax
-- to specific the behavior of the pattern, display, and enable outputs

pattern <=  "001" when(state = C0)
       else "011" when(state = C1)
		 else "010" when(state = C2)
		 else "100" when(state = C3 or state = pause)
		 else "000";

display <=  "00" when(state = C0 or state = B3)
       else "01" when(state = C1 or state = B2)
		 else "10" when(state = C2 or state = B1)
		 else "11"; --when(state = C3)

enable  <=  '0' when(state = idle or state = pause)
       else '1' ;

end architecture;
