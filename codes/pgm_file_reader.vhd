library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use ieee.numeric_std.all ;
use std.textio.all;

entity pgm_file_reader is
generic(FILE_NAME : string := "test_data.txt");
port(clk : in std_logic;
     reset : in std_logic;
	  
	  data_out : out std_logic_vector(7 downto 0);
	  end_of_file : out std_logic := '0');
end pgm_file_reader;

architecture Behavioral of pgm_file_reader is
begin

	process(clk)
	file file_read : text is in FILE_NAME;
	variable line_read : line;
	variable int_value : integer range 0 to 255;
	begin
		if(rising_edge(clk))
		then
			if(reset = '1')
			then
				data_out <= (others => '0');
				end_of_file <= '0';
			else
				if(endfile(file_read))
				then
					end_of_file <= '1';
				else
					readline(file_read, line_read);
					read(line_read, int_value);
					data_out <= conv_std_logic_vector(int_value, 8);
				end if;
			end if;
		end if;
	end process;

end Behavioral;
