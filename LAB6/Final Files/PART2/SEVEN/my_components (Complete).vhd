library ieee;
use ieee.std_logic_1164.all;

package my_components is -- Declares custom components found in other files

component lab5
  port (
        -- clock and reset connectiongs that will use pushbuttons
        clk, reset_n : in std_logic;

        -- 3-bit pattern choice input to feed hex (7-segment) code converter
        pattern : in std_logic_vector(2 downto 0);

        -- 2-bit hex display selection input to feed 2-to-4 decoder
        display : in std_logic_vector(1 downto 0);

        -- enable input for 2-to-4 decoder
        enable : in std_logic;

        -- four 7-bit pin outputs, one vector for each hex (7-segment) display
        hex_d0, hex_d1, hex_d2, hex_d3 : out std_logic_vector(6 downto 0)
       );
end component;

component fsm
  port (
        clk, reset_n, go_n : in  std_logic;
        pattern            : out std_logic_vector(2 downto 0);
        display            : out std_logic_vector(1 downto 0);
        enable             : out std_logic
       );
end component;

end package;
