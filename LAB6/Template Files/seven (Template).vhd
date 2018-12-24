library ieee;
use ieee.std_logic_1164.all;     -- For std_logic and std_logic_vector types
use ieee.std_logic_unsigned.all; -- Needed to permet the use of '+' in counter

use work.my_componenets.all;     -- Declarations for components used below

entity seven is
  port (
        clk, reset_n, go_n : in std_logic;
        slow_clk_out : out std_logic;
        hex_d0, hex_d1, hex_d3 : out std_logic_vector(6 downto 0)
       );
end entity;

architecture structure of seven is

-- Define internal signals needed to connect component instances together
signal ... : ...;

-- Define internal signals related to counter process for slow clock
signal ... : ...;

-- Indicate which lab5 architecture to use when that component is instantiated
for all : lab5 use ...;

begin

-- Include a 32-bit counter process based on the example in Lab 1 Part 7
-- (which was also used in Lab 5 Part 2)
the_count : process (clk, reset_n)
begin
  .
  .
  .
end process;

-- Associate internal slow clock signal with a particaular counter register bit
... <= ...;

-- Associate the output pin for the slow clk with the internal signal
... <= ...;

the_lab5 : lab5 port map
                (
                  -- Associate the component ports with
                  -- either internal signals
                  -- or top-level entity ports
                );
the_controller : fsm port map
                     (
                       -- Associate the component ports with
                       -- either internal signals
                       -- or top-level entity ports
                     );

end architecture;
