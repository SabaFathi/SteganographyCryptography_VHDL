library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use work.AES_DEPENDENCY_PKG.ALL;

entity sbox_inverted_mapper is
port(indexes_matrix : in matrix_4X4;

	  values_matrix : out matrix_4X4);
end sbox_inverted_mapper;

architecture Behavioral of sbox_inverted_mapper is
begin

	values_matrix(0, 0) <= INVERTED_SBOX(conv_integer(indexes_matrix(0, 0)));
	values_matrix(0, 1) <= INVERTED_SBOX(conv_integer(indexes_matrix(0, 1)));
	values_matrix(0, 2) <= INVERTED_SBOX(conv_integer(indexes_matrix(0, 2)));
	values_matrix(0, 3) <= INVERTED_SBOX(conv_integer(indexes_matrix(0, 3)));
	values_matrix(1, 0) <= INVERTED_SBOX(conv_integer(indexes_matrix(1, 0)));
	values_matrix(1, 1) <= INVERTED_SBOX(conv_integer(indexes_matrix(1, 1)));
	values_matrix(1, 2) <= INVERTED_SBOX(conv_integer(indexes_matrix(1, 2)));
	values_matrix(1, 3) <= INVERTED_SBOX(conv_integer(indexes_matrix(1, 3)));
	values_matrix(2, 0) <= INVERTED_SBOX(conv_integer(indexes_matrix(2, 0)));
	values_matrix(2, 1) <= INVERTED_SBOX(conv_integer(indexes_matrix(2, 1)));
	values_matrix(2, 2) <= INVERTED_SBOX(conv_integer(indexes_matrix(2, 2)));
	values_matrix(2, 3) <= INVERTED_SBOX(conv_integer(indexes_matrix(2, 3)));
	values_matrix(3, 0) <= INVERTED_SBOX(conv_integer(indexes_matrix(3, 0)));
	values_matrix(3, 1) <= INVERTED_SBOX(conv_integer(indexes_matrix(3, 1)));
	values_matrix(3, 2) <= INVERTED_SBOX(conv_integer(indexes_matrix(3, 2)));
	values_matrix(3, 3) <= INVERTED_SBOX(conv_integer(indexes_matrix(3, 3)));

end Behavioral;
