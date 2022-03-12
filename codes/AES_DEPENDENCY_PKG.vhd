library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

package AES_DEPENDENCY_PKG is

type matrix_4X4 is array(0 to 3, 0 to 3) of std_logic_vector(7 downto 0);

type matrix_16X16 is array(0 to 15, 0 to 15) of std_logic_vector(7 downto 0);

type map_table is array(0 to 255) of std_logic_vector(7 downto 0);

constant GALOIS_FIELD_E_TABLE : map_table := (X"01", X"03", X"05", X"0F", X"11", X"33", X"55", X"FF", X"1A", X"2E", X"72", X"96", X"A1", X"F8", X"13", X"35",
															 X"5F", X"E1", X"38", X"48", X"D8", X"73", X"95", X"A4", X"F7", X"02", X"06", X"0A", X"1E", X"22", X"66", X"AA",
															 X"E5", X"34", X"5C", X"E4", X"37", X"59", X"EB", X"26", X"6A", X"BE", X"D9", X"70", X"90", X"AB", X"E6", X"31",
															 X"53", X"F5", X"04", X"0C", X"14", X"3C", X"44", X"CC", X"4F", X"D1", X"68", X"B8", X"D3", X"6E", X"B2", X"CD",
															 X"4C", X"D4", X"67", X"A9", X"E0", X"3B", X"4D", X"D7", X"62", X"A6", X"F1", X"08", X"18", X"28", X"78", X"88",
															 X"83", X"9E", X"B9", X"D0", X"6B", X"BD", X"DC", X"7F", X"81", X"98", X"B3", X"CE", X"49", X"DB", X"76", X"9A",
															 X"B5", X"CD", X"57", X"F9", X"10", X"30", X"50", X"F0", X"0B", X"1D", X"27", X"69", X"BB", X"D6", X"61", X"A3",
															 X"FE", X"19", X"2B", X"7D", X"87", X"92", X"AD", X"EC", X"2F", X"71", X"93", X"AE", X"E9", X"20", X"60", X"A0",
															 X"FB", X"16", X"3A", X"4E", X"D2", X"6D", X"B7", X"C2", X"5D", X"E7", X"32", X"56", X"FA", X"15", X"3F", X"41",
															 X"C3", X"5E", X"E2", X"3D", X"47", X"C9", X"40", X"C0", X"5B", X"ED", X"2C", X"74", X"9C", X"BF", X"DA", X"75",
															 X"9F", X"BA", X"D5", X"64", X"AC", X"EF", X"2A", X"7E", X"82", X"9D", X"BC", X"DF", X"7A", X"8E", X"89", X"80",
															 X"9B", X"B6", X"C1", X"58", X"E8", X"23", X"65", X"AF", X"EA", X"25", X"6F", X"B1", X"C8", X"43", X"C5", X"54",
															 X"FC", X"1F", X"21", X"63", X"A5", X"F4", X"07", X"09", X"1B", X"2D", X"77", X"99", X"B0", X"CB", X"46", X"CA",
															 X"45", X"CF", X"4A", X"DE", X"79", X"8B", X"86", X"91", X"A8", X"E3", X"3E", X"42", X"C6", X"51", X"F3", X"0E",
															 X"12", X"36", X"5A", X"EE", X"29", X"7B", X"8D", X"8C", X"8F", X"8A", X"85", X"94", X"A7", X"F2", X"0D", X"17",
															 X"39", X"4B", X"DD", X"7C", X"84", X"97", X"A2", X"FD", X"1C", X"24", X"6C", X"B4", X"C7", X"52", X"F6", X"01");

constant GALOIS_FIELD_L_TABLE : map_table := (X"00", X"00", X"19", X"01", X"32", X"02", X"1A", X"C6", X"4B", X"C7", X"1B", X"68", X"33", X"EE", X"DF", X"03",
															 X"64", X"04", X"E0", X"0E", X"34", X"8D", X"81", X"EF", X"4C", X"71", X"08", X"C8", X"F8", X"69", X"1C", X"C1",
															 X"7D", X"C2", X"1D", X"B5", X"F9", X"B9", X"27", X"6A", X"4D", X"E4", X"A6", X"72", X"9A", X"C9", X"09", X"78",
															 X"65", X"2F", X"8A", X"05", X"21", X"0F", X"E1", X"24", X"12", X"F0", X"82", X"45", X"35", X"93", X"DA", X"8E",
															 X"96", X"8F", X"DB", X"BD", X"36", X"D0", X"CE", X"94", X"13", X"5C", X"D2", X"F1", X"40", X"46", X"83", X"38",
															 X"66", X"DD", X"FD", X"30", X"BF", X"06", X"8B", X"62", X"B3", X"25", X"E2", X"98", X"22", X"88", X"91", X"10",
															 X"7E", X"6E", X"48", X"C3", X"A3", X"B6", X"1E", X"42", X"3A", X"6B", X"28", X"54", X"FA", X"85", X"3D", X"BA",
															 X"2B", X"79", X"0A", X"15", X"9B", X"9F", X"5E", X"CA", X"4E", X"D4", X"AC", X"E5", X"F3", X"73", X"A7", X"57",
															 X"AF", X"58", X"A8", X"50", X"F4", X"EA", X"D6", X"74", X"4F", X"AE", X"E9", X"D5", X"E7", X"E6", X"AD", X"E8",
															 X"2C", X"D7", X"75", X"7A", X"EB", X"16", X"0B", X"F5", X"59", X"CB", X"5F", X"B0", X"9C", X"A9", X"51", X"A0",
															 X"7F", X"0C", X"F6", X"6F", X"17", X"C4", X"49", X"EC", X"D8", X"43", X"1F", X"2D", X"A4", X"76", X"7B", X"B7",
															 X"CC", X"BB", X"CE", X"5A", X"FB", X"60", X"B1", X"86", X"3B", X"52", X"A1", X"6C", X"AA", X"55", X"29", X"9D",
															 X"97", X"B2", X"87", X"90", X"61", X"BE", X"DC", X"FC", X"BC", X"95", X"CF", X"CD", X"37", X"3F", X"5B", X"D1",
															 X"53", X"39", X"84", X"3C", X"41", X"A2", X"6D", X"47", X"14", X"2A", X"9E", X"5D", X"56", X"F2", X"D3", X"AB",
															 X"44", X"11", X"92", X"D9", X"23", X"20", X"2E", X"89", X"B4", X"7C", X"B8", X"26", X"77", X"99", X"E3", X"A5",
															 X"67", X"4A", X"ED", X"DE", X"C5", X"31", X"FE", X"18", X"0D", X"63", X"8C", X"80", X"C0", X"F7", X"70", X"07");

constant S_BOX : map_table := (X"63", X"7C", X"77", X"7B", X"F2", X"6B", X"6F", X"C5", X"30", X"01", X"67", X"2B", X"FE", X"D7", X"AB", X"76",
										 X"CA", X"82", X"C9", X"7D", X"FA", X"59", X"47", X"F0", X"AD", X"D4", X"A2", X"AF", X"9C", X"A4", X"72", X"C0",
										 X"B7", X"FD", X"93", X"26", X"36", X"3F", X"F7", X"CC", X"34", X"A5", X"E5", X"F1", X"71", X"D8", X"31", X"15",
										 X"04", X"C7", X"23", X"C3", X"18", X"96", X"05", X"9A", X"07", X"12", X"80", X"E2", X"EB", X"27", X"B2", X"75",
										 X"09", X"83", X"2C", X"1A", X"1B", X"6E", X"5A", X"A0", X"52", X"3B", X"D6", X"B3", X"29", X"E3", X"2F", X"84",
										 X"53", X"D1", X"00", X"ED", X"20", X"FC", X"B1", X"5B", X"6A", X"CB", X"BE", X"39", X"4A", X"4C", X"58", X"CF",
										 X"D0", X"EF", X"AA", X"FB", X"43", X"4D", X"33", X"85", X"45", X"F9", X"02", X"7F", X"50", X"3C", X"9F", X"A8",
										 X"51", X"A3", X"40", X"8F", X"92", X"9D", X"38", X"F5", X"BC", X"B6", X"DA", X"21", X"10", X"FF", X"F3", X"D2",
										 X"CD", X"0C", X"13", X"EC", X"5F", X"97", X"44", X"17", X"C4", X"A7", X"7E", X"3D", X"64", X"5D", X"19", X"73",
										 X"60", X"81", X"4F", X"DC", X"22", X"2A", X"90", X"88", X"46", X"EE", X"B8", X"14", X"DE", X"5E", X"0B", X"DB",
										 X"E0", X"32", X"3A", X"0A", X"49", X"06", X"24", X"5C", X"C2", X"D3", X"AC", X"62", X"91", X"95", X"E4", X"79",
										 X"E7", X"C8", X"37", X"6D", X"8D", X"D5", X"4E", X"A9", X"6C", X"56", X"F4", X"EA", X"65", X"7A", X"AE", X"08",
										 X"BA", X"78", X"25", X"2E", X"1C", X"A6", X"B4", X"C6", X"E8", X"DD", X"74", X"1F", X"4B", X"BD", X"8B", X"8A",
										 X"70", X"3E", X"B5", X"66", X"48", X"03", X"F6", X"0E", X"61", X"35", X"57", X"B9", X"86", X"C1", X"1D", X"9E",
										 X"E1", X"F8", X"98", X"11", X"69", X"D9", X"8E", X"94", X"9B", X"1E", X"87", X"E9", X"CE", X"55", X"28", X"DF",
										 X"8C", X"A1", X"89", X"0D", X"BF", X"E6", X"42", X"68", X"41", X"99", X"2D", X"0F", X"B0", X"54", X"BB", X"16");

constant INVERTED_SBOX : map_table := (X"52", X"09", X"6A", X"D5", X"30", X"36", X"A5", X"38", X"BF", X"40", X"A3", X"9E", X"81", X"F3", X"D7", X"FB",
													X"7C", X"E3", X"39", X"82", X"9B", X"2F", X"FF", X"87", X"34", X"8E", X"43", X"44", X"C4", X"DE", X"E9", X"CB",
													X"54", X"7B", X"94", X"32", X"A6", X"C2", X"23", X"3D", X"EE", X"4C", X"95", X"0B", X"42", X"FA", X"C3", X"4E",
													X"08", X"2E", X"A1", X"66", X"28", X"D9", X"24", X"B2", X"76", X"5B", X"A2", X"49", X"6D", X"8B", X"D1", X"25",
													X"72", X"F8", X"F6", X"64", X"86", X"68", X"98", X"16", X"D4", X"A4", X"5C", X"CC", X"5D", X"65", X"B6", X"92",
													X"6C", X"70", X"48", X"50", X"FD", X"ED", X"B9", X"DA", X"5E", X"15", X"46", X"57", X"A7", X"8D", X"9D", X"84",
													X"90", X"D8", X"AB", X"00", X"8C", X"BC", X"D3", X"0A", X"F7", X"E4", X"58", X"05", X"B8", X"B3", X"45", X"06",
													X"D0", X"2C", X"1E", X"8F", X"CA", X"3F", X"0F", X"02", X"C1", X"AF", X"BD", X"03", X"01", X"13", X"8A", X"6B",
													X"3A", X"91", X"11", X"41", X"4F", X"67", X"DC", X"EA", X"97", X"F2", X"CF", X"CE", X"F0", X"B4", X"E6", X"73",
													X"96", X"AC", X"74", X"22", X"E7", X"AD", X"35", X"85", X"E2", X"F9", X"37", X"E8", X"1C", X"75", X"DF", X"6E",
													X"47", X"F1", X"1A", X"71", X"1D", X"29", X"C5", X"89", X"6F", X"B7", X"62", X"0E", X"AA", X"18", X"BE", X"1B",
													X"FC", X"56", X"3E", X"4B", X"C6", X"D2", X"79", X"20", X"9A", X"DB", X"C0", X"FE", X"78", X"CD", X"5A", X"F4",
													X"1F", X"DD", X"A8", X"33", X"88", X"07", X"C7", X"31", X"B1", X"12", X"10", X"59", X"27", X"80", X"EC", X"5F",
													X"60", X"51", X"7F", X"A9", X"19", X"B5", X"4A", X"02", X"2D", X"E5", X"7A", X"9F", X"93", X"C9", X"9C", X"EF",
													X"A0", X"E0", X"3B", X"4D", X"AE", X"2A", X"F5", X"B0", X"C8", X"EB", X"BB", X"3C", X"83", X"53", X"99", X"61",
													X"17", X"2B", X"04", X"7E", X"BA", X"77", X"D6", X"26", X"E1", X"69", X"14", X"63", X"55", X"21", X"0C", X"7D");

end AES_DEPENDENCY_PKG;

package body AES_DEPENDENCY_PKG is
end AES_DEPENDENCY_PKG;
