library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use work.AES_DEPENDENCY_PKG.ALL;

entity row_shifter is
port(in_matrix : in matrix_4X4;

	  clk : in std_logic;
	  enable : in std_logic;

	  out_matrix : out matrix_4X4);
end row_shifter;

architecture Behavioral of row_shifter is
begin

	process(clk)
	begin
		if(rising_edge(clk))
		then
			if(enable = '1')
			then
				--line0 need 0 shift
				out_matrix(0, 0) <= in_matrix(0, 0);
				out_matrix(0, 1) <= in_matrix(0, 1);
				out_matrix(0, 2) <= in_matrix(0, 2);
				out_matrix(0, 3) <= in_matrix(0, 3);
				
				--line1 need 1 shift
				out_matrix(1, 0) <= in_matrix(1, 1);
				out_matrix(1, 1) <= in_matrix(1, 2);
				out_matrix(1, 2) <= in_matrix(1, 3);
				out_matrix(1, 3) <= in_matrix(1, 0);
				
				--line2 need 2 shift
				out_matrix(2, 0) <= in_matrix(2, 2);
				out_matrix(2, 1) <= in_matrix(2, 3);
				out_matrix(2, 2) <= in_matrix(2, 0);
				out_matrix(2, 3) <= in_matrix(2, 1);
				
				--line3 need 3 shift
				out_matrix(3, 0) <= in_matrix(3, 3);
				out_matrix(3, 1) <= in_matrix(3, 0);
				out_matrix(3, 2) <= in_matrix(3, 1);
				out_matrix(3, 3) <= in_matrix(3, 2);
			end if;
		end if;
	end process;

end Behavioral;
