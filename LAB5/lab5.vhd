library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity lab5 is
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
end entity;

architecture logic of lab5 is

-- register output vectors to hold current pattern for each hex displlay
signal q_d0, q_d1, q_d2, q_d3 : std_logic_vector(6 downto 0);

-- output vector of code converter to generate hex (7-segment) display pattern
signal code_conv_out : std_logic_vector(6 downto 0);

-- output vector of 2-to-4 decoder to select register that will change
signal load_enables : std_logic_vector(3 downto 0);

begin

-- combined process for behavior of four registers, one for each hex display;
-- load enables are separate, but data input vector is same for all registers=====
hex_display_registers : process (clk, reset_n)
begin
  if (reset_n = '0') then
    q_d0 <= (others => '0');
    q_d1 <= (others => '0');
    q_d2 <= (others => '0');
    q_d3 <= (others => '0');
  elsif (clk'event and clk = '1') then
    if (load_enables(0) = '1') then q_d0 <= code_conv_out; end if;
    if (load_enables(1) = '1') then q_d1 <= code_conv_out; end if;
    if (load_enables(2) = '1') then q_d2 <= code_conv_out; end if;
    if (load_enables(3) = '1') then q_d3 <= code_conv_out; end if;
	end if;
end process;

-- hex display output connections (inversion makes '1' meaning 'LED is on')
hex_d0 <= not q_d0;
hex_d1 <= not q_d1;
hex_d2 <= not q_d2;
hex_d3 <= not q_d3;

-- gate-level specification of 2-to-4 decoder for load-enable signals
--load_enables(0) <= enable and not display(0) and not display(1);
--load_enables(1) <= enable and display(0) and not display(1);
--load_enables(2) <= enable and not display(0) and display(1);
--load_enables(3) <= enable and display(0) and display(1);

-- high-level when..else.. statement performaing deocing with vectors
load_enables <=   "0001"    when(enable = '1' and display = "00")
				 else "0010"    when(enable = '1' and display = "01")
				 else "0100"    when(enable = '1' and display = "10")
				 else "1000";-- when(enable = '1' and display = "11")

-- high_level specification of code converter for hex (7-segment) display
code_conv_out <=   "0000000"     when (pattern = "000")
              else "1110110"     when (pattern = "001")
              else "0111110"     when (pattern = "010")
              else "0111001"     when (pattern = "011")
              else "0111111"; -- when (pattern = "100")

end architecture;

------------------------------------ Part 1 ------------------------------------

--------------------------------------------------------------------------------

------------------------------------ Part 2 ------------------------------------

architecture logic2 of lab5 is

 -- register output vectors to hold current pattern for each hex displlay
signal q_d0, q_d1, q_d2, q_d3 : std_logic_vector(6 downto 0);

-- output vector of code converter to generate hex (7-segment) display pattern
signal code_conv_out, other_code_conv_out : std_logic_vector(6 downto 0);

-- output vector of 2-to-4 decoder to select register that will change
signal load_enables : std_logic_vector(3 downto 0);

-- count
signal count : std_logic_vector(31 downto 0);

begin

-- combined process for behavior of four registers, one for each hex display;
-- load enables are separate, but data input vector is same for all registers
hex_display_registers : process (count(25), reset_n)
begin
  if (reset_n = '0') then
    q_d0 <= "0000001";
    q_d1 <= "0001000";
    q_d2 <= "0000001";
    q_d3 <= "0001000";
  elsif (count(10)'event and count(10) = '1') then
    if (load_enables(0) = '1') then q_d0 <= code_conv_out; end if;
    if (load_enables(1) = '1') then q_d1 <= other_code_conv_out; end if;
    if (load_enables(2) = '1') then q_d2 <= code_conv_out; end if;
    if (load_enables(3) = '1') then q_d3 <= other_code_conv_out; end if;
	end if;
end process;

 -- increment value of count on each edge of the clock input
the_counter : process (clk, reset_n)
begin
  if (reset_n = '0') then
    count <= (others => '0');
  elsif (clk'event and clk = '1') then 
	  count <= count + '1';
  end if;
end process;

-- hex display output connections (inversion makes '1' meaning 'LED is on')
hex_d0 <= not q_d0;
hex_d1 <= not q_d1;
hex_d2 <= not q_d2;
hex_d3 <= not q_d3;

-- gate-level specification of 2-to-4 decoder for load-enable signals
load_enables(0) <= '1';
load_enables(1) <= '1';
load_enables(2) <= '1';
load_enables(3) <= '1';
-- OR load_enables <= "1111";

-- high_level specification of code converter for hex (7-segment) display
code_conv_out <=         "0000001"    when (q_d0 = "0001000")
                    else "0100010"    when (q_d0 = "0000001")
                    else "1000000"    when (q_d0 = "0100010")
						        else "0010100"    when (q_d0 = "1000000")
                    else "0001000";-- when (q_d0 = "0010100")

other_code_conv_out <=   "0001000"    when (q_d1 = "0000001")
						        else "0010100"    when (q_d1 = "0001000")
					  	      else "1000000"    when (q_d1 = "0010100")
						        else "0100010"    when (q_d1 = "1000000")
						        else "0000001";-- when (q_d1 = "0100010")

end architecture;
