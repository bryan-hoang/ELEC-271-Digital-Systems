library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;

library std;
use std.textio.all;

entity tb_lab3 is
-- no external ports/pins for x simulation textbench entity
end entity;

architecture testbench of tb_lab3 is

component lab3
    port (x  , y  , z   : in  std_logic;
          fsp, fps      : out std_logic);
end component;

for all: lab3 use entity work.lab3(logic);

-- define the input/output signals for this textbench,
-- all of which have the same names as the ports of the entity under test

signal x, y, z, fsp, fps : std_logic;

begin

lab3_under_test : lab3  -- instantiate the system under test
    port map (          -- and map entity ports to testbench signals
              x   => x,
              y   => y,
              z   => z,
              fsp => fsp,
              fps => fps
            );

-- process to read vectors from x file and drive the system under test
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
    x <= in_vector(2);
    y <= in_vector(1);
    z <= in_vector(0);
    wait for 10 ns;

    -- check generated output signal against testbench output value
    assert (fsp = out_vector(0))
      report "SOP output did not match."
      severity error;
      
    assert (fps = out_vector(0))
      report "POS output did not match."
      severity error;

    -- additional delay before handling the next input vector
    -- allows for centering of error symbol on waveform display
    wait for 10ns;

  end loop;
  
  -- after loop, force inputs to zero for remainder of simulation time
  x <= '0';
  y <= '0';
  z <= '0';
  wait;

end process;

end architecture;
