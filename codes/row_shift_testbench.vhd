LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

USE work.AES_DEPENDENCY_PKG.ALL;

ENTITY row_shift_testbench IS
END row_shift_testbench;
 
ARCHITECTURE behavior OF row_shift_testbench IS 

	-- Component Declaration for the Unit Under Test (UUT)
	component row_shifter is
	port(in_matrix : in matrix_4X4;
		  clk : in std_logic;
		  enable : in std_logic;
		  out_matrix : out matrix_4X4);
	end component;
	
	component row_inverted_shifter is
	port(in_matrix : in matrix_4X4;
		  clk : in std_logic;
		  enable : in std_logic;
		  out_matrix : out matrix_4X4);
	end component;
	
	
	-- signals
	signal in_matrix : matrix_4X4;
	signal clk : std_logic := '0';
	signal en1, en2 : std_logic;
	signal shifted_matrix : matrix_4X4;
	signal unshifted_matrix : matrix_4X4;
	
BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut_shift: row_shifter port map(in_matrix => in_matrix, clk => clk, enable => en1, out_matrix => shifted_matrix);
	uut_unshift : row_inverted_shifter port map(in_matrix => shifted_matrix, clk => clk, enable => en2, out_matrix => unshifted_matrix);

	clk <= not clk after 5 ns;
	en1 <= '1';
	en2 <= '0' after 0 ns, '1' after 10 ns;

	in_matrix(0, 0) <= X"FE";
	in_matrix(0, 1) <= X"05";
	in_matrix(0, 2) <= X"49";
	in_matrix(0, 3) <= X"3A";
	in_matrix(1, 0) <= X"2F";
	in_matrix(1, 1) <= X"58";
	in_matrix(1, 2) <= X"D0";
	in_matrix(1, 3) <= X"E7";
	in_matrix(2, 0) <= X"6C";
	in_matrix(2, 1) <= X"1B";
	in_matrix(2, 2) <= X"AE";
	in_matrix(2, 3) <= X"F4";
	in_matrix(3, 0) <= X"7D";
	in_matrix(3, 1) <= X"80";
	in_matrix(3, 2) <= X"97";
	in_matrix(3, 3) <= X"CD";

END;
