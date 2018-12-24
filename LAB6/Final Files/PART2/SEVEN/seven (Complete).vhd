library ieee;
use ieee.std_logic_1164.all;     -- For std_logic and std_logic_vector types
use ieee.std_logic_unsigned.all; -- Needed to permet the use of '+' in counter

use work.my_components.all;     -- Declarations for components used below

entity seven is
  port (
        clk, reset_n, go_n : in std_logic;
        slow_clk_out : out std_logic;
        hex_d0, hex_d1, hex_d2, hex_d3 : out std_logic_vector(6 downto 0)
       );
end entity;

architecture structure of seven is

-- Define internal signals needed to connect component instances together
signal slow_clk, enable : std_logic;
signal display : std_logic_vector(1 downto 0);
signal pattern : std_logic_vector(2 downto 0);

-- Define internal signals related to counter process for slow clock
signal count : std_logic_vector(31 downto 0);

-- Indicate which lab5 architecture to use when that component is instantiated
for all : lab5 use entity work.lab5(logic);

begin

-- Include a 32-bit counter process based on the example in Lab 1 Part 7
-- (which was also used in Lab 5 Part 2)
the_count : process (clk, reset_n)
begin
  if (reset_n = '0') then
    count <= (others => '0');
  elsif (clk'event and clk = '1') then 
	 count <= count + '1';
  end if;
end process;

-- Associate internal slow clock signal with a particular counter register bit
slow_clk <= count(25);

-- Associate the output pin for the slow clk with the internal signal
slow_clk_out <= slow_clk;

the_lab5 : lab5 port map
                (
                 clk      => slow_clk, -- Associate the component ports with
                 pattern  => pattern,
					  display  => display,
					  hex_d0   => hex_d0,
					  hex_d1   => hex_d1,
					  hex_d2   => hex_d2,
					  hex_d3   => hex_d3,
					  enable   => enable,
					  reset_n  => reset_n -- either internal signals
                  -- or top-level entity ports
                );
the_controller : fsm port map
					(
					 clk       => slow_clk,
					 pattern   => pattern,
					 display   => display,
					 go_n      => go_n,
					 reset_n   => reset_n,
					 enable    => enable
					  -- Associate the component ports with
					  -- either internal signals
					  -- or top-level entity ports
					  
					);

end architecture;
