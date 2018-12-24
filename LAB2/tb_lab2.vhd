library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;

library std;
use std.textio.all;

entity tb_lab2 is
-- no external ports/pins for a simulation textbench entity
end entity;

architecture testbench of tb_lab2 is

component lab2
    port (a, b, c : in  std_logic;
          f       : out std_logic);
end component;

for all: lab2 use entity work.lab2(pos);

-- define the input/output signals for this textbench,
-- all of which have the same names as the ports of the entity under test

signal a, b, c, f : std_logic;

begin

lab2_under_test : lab2  -- instantiate the system under test
    port map (          -- and map entity ports to testbench signals
              a => a,
              b => b,
              c => c,
              f => f
            );

-- process to read vectors from a file and drive the system under test
-- using assertions to verify the correct output for each vector

test_driver_with_assertions: process

variable line_in, line_out : line;
variable i                 : integer;
file     input_file        : text is "signal_values.txt";
variable in_vector         : std_logic_vector(2 downto 0);
variable out_vector        : std_logic_vector(0 downto 0);

begin

  -- loop for the number of input/output vector pairs in file
  for i in 0 to 7 loop

    -- retrieve input vector and assign to variable
    readline (input_file, line_in);
    read (line_in, in_vector);
    -- prepare portion od output line
    write (line_out, string'("input vector: "));
    write (line_out, in_vector);

    -- retrive output vector and assign to variable
    readline (input_file, line_in);
    read (line_in, out_vector);

    -- prepare remainder of output and send to output
    write (line_out, string'("  output vector: "));
    write (line_out, out_vector);
    writeline (output, line_out);

    -- assign individual signals from input vector and delay
    a <= in_vector(2);
    b <= in_vector(1);
    c <= in_vector(0);
    wait for 10 ns;

    -- check generated output signal against testbench output value
    assert (f = out_vector(0))
      report "output did not match"
      severity error;

    -- additional delay before handling the next input vector
    -- allows for centering of error symbol on waveform display
    wait for 10ns;

  end loop;
  
  -- after loop, force inputs to zero for remainder of simulation time
  a <= '0';
  b <= '0';
  c <= '0';
  wait;

end process;

end architecture;
