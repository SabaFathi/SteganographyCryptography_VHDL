LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

USE work.AES_DEPENDENCY_PKG.ALL;

ENTITY sbox_testbench IS
END sbox_testbench;
 
ARCHITECTURE behavior OF sbox_testbench IS 

	-- Component Declaration for the Unit Under Test (UUT)
	component sbox_mapper is
	port(indexes_matrix : in matrix_4X4;
		  values_matrix : out matrix_4X4);
	end component;
	
	component sbox_inverted_mapper is
	port(indexes_matrix : in matrix_4X4;
		  values_matrix : out matrix_4X4);
	end component;
	
	
	-- signals
	signal indexes_matrix : matrix_4X4;
	signal mapped_values_matrix : matrix_4X4;
	signal mapped_indexes_matrix : matrix_4X4;
	
BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut_mapper: sbox_mapper port map(indexes_matrix => indexes_matrix, values_matrix => mapped_values_matrix);
	uut_inverted_mapper: sbox_inverted_mapper port map(indexes_matrix => mapped_values_matrix, values_matrix => mapped_indexes_matrix);

	indexes_matrix(0, 0) <= X"00" after 0 ns, X"01" after 5 ns, X"02" after 10 ns, X"03" after 15 ns, X"04" after 20 ns, X"05" after 25 ns, X"06" after 30 ns, X"07" after 35 ns, X"08" after 40 ns, X"09" after 45 ns, X"0A" after 50 ns, X"0B" after 55 ns, X"0C" after 60 ns, X"0D" after 65 ns, X"0E" after 70 ns, X"0F" after 75 ns;
	indexes_matrix(0, 1) <= X"10" after 0 ns, X"11" after 5 ns, X"12" after 10 ns, X"13" after 15 ns, X"14" after 20 ns, X"15" after 25 ns, X"16" after 30 ns, X"17" after 35 ns, X"18" after 40 ns, X"19" after 45 ns, X"1A" after 50 ns, X"1B" after 55 ns, X"1C" after 60 ns, X"1D" after 65 ns, X"1E" after 70 ns, X"1F" after 75 ns;
	indexes_matrix(0, 2) <= X"20" after 0 ns, X"21" after 5 ns, X"22" after 10 ns, X"23" after 15 ns, X"24" after 20 ns, X"25" after 25 ns, X"26" after 30 ns, X"27" after 35 ns, X"28" after 40 ns, X"29" after 45 ns, X"2A" after 50 ns, X"2B" after 55 ns, X"2C" after 60 ns, X"2D" after 65 ns, X"2E" after 70 ns, X"2F" after 75 ns;
	indexes_matrix(0, 3) <= X"30" after 0 ns, X"31" after 5 ns, X"32" after 10 ns, X"33" after 15 ns, X"34" after 20 ns, X"35" after 25 ns, X"36" after 30 ns, X"37" after 35 ns, X"38" after 40 ns, X"39" after 45 ns, X"3A" after 50 ns, X"3B" after 55 ns, X"3C" after 60 ns, X"3D" after 65 ns, X"3E" after 70 ns, X"3F" after 75 ns;
	indexes_matrix(1, 0) <= X"40" after 0 ns, X"41" after 5 ns, X"42" after 10 ns, X"43" after 15 ns, X"44" after 20 ns, X"45" after 25 ns, X"46" after 30 ns, X"47" after 35 ns, X"48" after 40 ns, X"49" after 45 ns, X"4A" after 50 ns, X"4B" after 55 ns, X"4C" after 60 ns, X"4D" after 65 ns, X"4E" after 70 ns, X"4F" after 75 ns;
	indexes_matrix(1, 1) <= X"50" after 0 ns, X"51" after 5 ns, X"52" after 10 ns, X"53" after 15 ns, X"54" after 20 ns, X"55" after 25 ns, X"56" after 30 ns, X"57" after 35 ns, X"58" after 40 ns, X"59" after 45 ns, X"5A" after 50 ns, X"5B" after 55 ns, X"5C" after 60 ns, X"5D" after 65 ns, X"5E" after 70 ns, X"5F" after 75 ns;
	indexes_matrix(1, 2) <= X"60" after 0 ns, X"61" after 5 ns, X"62" after 10 ns, X"63" after 15 ns, X"64" after 20 ns, X"65" after 25 ns, X"66" after 30 ns, X"67" after 35 ns, X"68" after 40 ns, X"69" after 45 ns, X"6A" after 50 ns, X"6B" after 55 ns, X"6C" after 60 ns, X"6D" after 65 ns, X"6E" after 70 ns, X"6F" after 75 ns;
	indexes_matrix(1, 3) <= X"70" after 0 ns, X"71" after 5 ns, X"72" after 10 ns, X"73" after 15 ns, X"74" after 20 ns, X"75" after 25 ns, X"76" after 30 ns, X"77" after 35 ns, X"78" after 40 ns, X"79" after 45 ns, X"7A" after 50 ns, X"7B" after 55 ns, X"7C" after 60 ns, X"7D" after 65 ns, X"7E" after 70 ns, X"7F" after 75 ns;
	indexes_matrix(2, 0) <= X"80" after 0 ns, X"81" after 5 ns, X"82" after 10 ns, X"83" after 15 ns, X"84" after 20 ns, X"85" after 25 ns, X"86" after 30 ns, X"87" after 35 ns, X"88" after 40 ns, X"89" after 45 ns, X"8A" after 50 ns, X"8B" after 55 ns, X"8C" after 60 ns, X"8D" after 65 ns, X"8E" after 70 ns, X"8F" after 75 ns;
	indexes_matrix(2, 1) <= X"90" after 0 ns, X"91" after 5 ns, X"92" after 10 ns, X"93" after 15 ns, X"94" after 20 ns, X"95" after 25 ns, X"96" after 30 ns, X"97" after 35 ns, X"98" after 40 ns, X"99" after 45 ns, X"9A" after 50 ns, X"9B" after 55 ns, X"9C" after 60 ns, X"9D" after 65 ns, X"9E" after 70 ns, X"9F" after 75 ns;
	indexes_matrix(2, 2) <= X"A0" after 0 ns, X"A1" after 5 ns, X"A2" after 10 ns, X"A3" after 15 ns, X"A4" after 20 ns, X"A5" after 25 ns, X"A6" after 30 ns, X"A7" after 35 ns, X"A8" after 40 ns, X"A9" after 45 ns, X"AA" after 50 ns, X"AB" after 55 ns, X"AC" after 60 ns, X"AD" after 65 ns, X"AE" after 70 ns, X"AF" after 75 ns;
	indexes_matrix(2, 3) <= X"B0" after 0 ns, X"B1" after 5 ns, X"B2" after 10 ns, X"B3" after 15 ns, X"B4" after 20 ns, X"B5" after 25 ns, X"B6" after 30 ns, X"B7" after 35 ns, X"B8" after 40 ns, X"B9" after 45 ns, X"BA" after 50 ns, X"BB" after 55 ns, X"BC" after 60 ns, X"BD" after 65 ns, X"BE" after 70 ns, X"BF" after 75 ns;
	indexes_matrix(3, 0) <= X"C0" after 0 ns, X"C1" after 5 ns, X"C2" after 10 ns, X"C3" after 15 ns, X"C4" after 20 ns, X"C5" after 25 ns, X"C6" after 30 ns, X"C7" after 35 ns, X"C8" after 40 ns, X"C9" after 45 ns, X"CA" after 50 ns, X"CB" after 55 ns, X"CC" after 60 ns, X"CD" after 65 ns, X"CE" after 70 ns, X"CF" after 75 ns;
	indexes_matrix(3, 1) <= X"D0" after 0 ns, X"D1" after 5 ns, X"D2" after 10 ns, X"D3" after 15 ns, X"D4" after 20 ns, X"D5" after 25 ns, X"D6" after 30 ns, X"D7" after 35 ns, X"D8" after 40 ns, X"D9" after 45 ns, X"DA" after 50 ns, X"DB" after 55 ns, X"DC" after 60 ns, X"DD" after 65 ns, X"DE" after 70 ns, X"DF" after 75 ns;
	indexes_matrix(3, 2) <= X"E0" after 0 ns, X"E1" after 5 ns, X"E2" after 10 ns, X"E3" after 15 ns, X"E4" after 20 ns, X"E5" after 25 ns, X"E6" after 30 ns, X"E7" after 35 ns, X"E8" after 40 ns, X"E9" after 45 ns, X"EA" after 50 ns, X"EB" after 55 ns, X"EC" after 60 ns, X"ED" after 65 ns, X"EE" after 70 ns, X"EF" after 75 ns;
	indexes_matrix(3, 3) <= X"F0" after 0 ns, X"F1" after 5 ns, X"F2" after 10 ns, X"F3" after 15 ns, X"F4" after 20 ns, X"F5" after 25 ns, X"F6" after 30 ns, X"F7" after 35 ns, X"F8" after 40 ns, X"F9" after 45 ns, X"FA" after 50 ns, X"FB" after 55 ns, X"FC" after 60 ns, X"FD" after 65 ns, X"FE" after 70 ns, X"FF" after 75 ns;

END;
