library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use IEEE.NUMERIC_STD.ALL;

use std.textio.all;

entity pgm_file_writer is
generic(FILE_NAME : string := "test_wr.txt");
port(clk : in std_logic;
     en : in std_logic;
	  data_in : in std_logic_vector(7 downto 0));
end pgm_file_writer;

architecture Behavioral of pgm_file_writer is
begin

	process(clk)
	file file_write : text;
	variable line_write : line;
	begin
		if(rising_edge(clk))
		then
			if(en = '1')
			then
				file_open(file_write, FILE_NAME, APPEND_MODE);
				write(line_write, conv_integer(data_in));
				writeline(file_write, line_write);
				file_close(file_write);
			end if;
		end if;
	end process;

end Behavioral;
