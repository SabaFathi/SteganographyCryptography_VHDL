library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use work.AES_DEPENDENCY_PKG.ALL;

entity matrix4x4_xor is
port(matrix1 : in matrix_4X4;
	  matrix2 : in matrix_4X4;

	  matrix_result : out matrix_4X4);
end matrix4x4_xor;

architecture Behavioral of matrix4x4_xor is
begin

	matrix_result(0, 0) <= matrix1(0, 0) XOR matrix2(0, 0);
	matrix_result(0, 1) <= matrix1(0, 1) XOR matrix2(0, 1);
	matrix_result(0, 2) <= matrix1(0, 2) XOR matrix2(0, 2);
	matrix_result(0, 3) <= matrix1(0, 3) XOR matrix2(0, 3);
	matrix_result(1, 0) <= matrix1(1, 0) XOR matrix2(1, 0);
	matrix_result(1, 1) <= matrix1(1, 1) XOR matrix2(1, 1);
	matrix_result(1, 2) <= matrix1(1, 2) XOR matrix2(1, 2);
	matrix_result(1, 3) <= matrix1(1, 3) XOR matrix2(1, 3);
	matrix_result(2, 0) <= matrix1(2, 0) XOR matrix2(2, 0);
	matrix_result(2, 1) <= matrix1(2, 1) XOR matrix2(2, 1);
	matrix_result(2, 2) <= matrix1(2, 2) XOR matrix2(2, 2);
	matrix_result(2, 3) <= matrix1(2, 3) XOR matrix2(2, 3);
	matrix_result(3, 0) <= matrix1(3, 0) XOR matrix2(3, 0);
	matrix_result(3, 1) <= matrix1(3, 1) XOR matrix2(3, 1);
	matrix_result(3, 2) <= matrix1(3, 2) XOR matrix2(3, 2);
	matrix_result(3, 3) <= matrix1(3, 3) XOR matrix2(3, 3);

end Behavioral;
