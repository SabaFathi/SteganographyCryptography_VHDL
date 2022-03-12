library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use work.AES_DEPENDENCY_PKG.ALL;

entity column_inverted_mixer is
port(in_matrix : in matrix_4X4;

	  clk : in std_logic;
	  enable : in std_logic;

	  out_matrix : out matrix_4X4);
end column_inverted_mixer;

architecture Behavioral of column_inverted_mixer is

begin

	process(clk)
	variable helper_vector1 : std_logic_vector(7 downto 0);
	variable helper_vector2 : std_logic_vector(7 downto 0);
	variable helper_vector3 : std_logic_vector(7 downto 0);
	variable helper_vector4 : std_logic_vector(7 downto 0);
	variable helper_carry1 : std_logic_vector(8 downto 0);
	variable helper_carry2 : std_logic_vector(8 downto 0);
	variable helper_carry3 : std_logic_vector(8 downto 0);
	variable helper_carry4 : std_logic_vector(8 downto 0);
	begin
		if(rising_edge(clk))
		then
			if(enable = '1')
			then
				-- | c0 | = E(L(s0)+L(X"0E")) XOR E(L(s1)+L(X"0B")) XOR E(L(s2)+L(X"0D")) XOR E(L(s3)+L(X"09"))
				-- | c1 | = E(L(s0)+L(X"09")) XOR E(L(s1)+L(X"0E")) XOR E(L(s2)+L(X"0B")) XOR E(L(s3)+L(X"0D"))
				-- | c2 | = E(L(s0)+L(X"0D")) XOR E(L(s1)+L(X"09")) XOR E(L(s2)+L(X"0E")) XOR E(L(s3)+L(X"0B"))
				-- | c3 | = E(L(s0)+L(X"0B")) XOR E(L(s1)+L(X"0D")) XOR E(L(s2)+L(X"09")) XOR E(L(s3)+L(X"0E"))
				
				--GALOIS_FIELD_L_TABLE(X"0E") = X"DF"
				--GALOIS_FIELD_L_TABLE(X"0B") = X"68"
				--GALOIS_FIELD_L_TABLE(X"0D") = X"EE"
				--GALOIS_FIELD_L_TABLE(X"09") = X"C7"
				
				--column 0:
				helper_vector1 := in_matrix(0, 0);
				helper_vector2 := in_matrix(1, 0);
				helper_vector3 := in_matrix(2, 0);
				helper_vector4 := in_matrix(3, 0);
				
				helper_carry1 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector1))) + X"DF";
				helper_carry2 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector2))) + X"68";
				helper_carry3 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector3))) + X"EE";
				helper_carry4 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector4))) + X"C7";
				out_matrix(0, 0) <= (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry1(7 downto 0) + helper_carry1(8 downto 8)))) --add with carry
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry2(7 downto 0) + helper_carry2(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry3(7 downto 0) + helper_carry3(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry4(7 downto 0) + helper_carry4(8 downto 8))));
										 
				helper_carry1 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector1))) + X"C7";
				helper_carry2 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector2))) + X"DF";
				helper_carry3 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector3))) + X"68";
				helper_carry4 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector4))) + X"EE";
				out_matrix(1, 0) <= (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry1(7 downto 0) + helper_carry1(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry2(7 downto 0) + helper_carry2(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry3(7 downto 0) + helper_carry3(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry4(7 downto 0) + helper_carry4(8 downto 8))));
				
				helper_carry1 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector1))) + X"EE";
				helper_carry2 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector2))) + X"C7";
				helper_carry3 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector3))) + X"DF";
				helper_carry4 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector4))) + X"68";
				out_matrix(2, 0) <= (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry1(7 downto 0) + helper_carry1(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry2(7 downto 0) + helper_carry2(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry3(7 downto 0) + helper_carry3(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry4(7 downto 0) + helper_carry4(8 downto 8))));
				
				helper_carry1 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector1))) + X"68";
				helper_carry2 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector2))) + X"EE";
				helper_carry3 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector3))) + X"C7";
				helper_carry4 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector4))) + X"DF";
				out_matrix(3, 0) <= (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry1(7 downto 0) + helper_carry1(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry2(7 downto 0) + helper_carry2(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry3(7 downto 0) + helper_carry3(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry4(7 downto 0) + helper_carry4(8 downto 8))));
				
				--column 1:
				helper_vector1 := in_matrix(0, 1);
				helper_vector2 := in_matrix(1, 1);
				helper_vector3 := in_matrix(2, 1);
				helper_vector4 := in_matrix(3, 1);
				
				helper_carry1 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector1))) + X"DF";
				helper_carry2 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector2))) + X"68";
				helper_carry3 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector3))) + X"EE";
				helper_carry4 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector4))) + X"C7";
				out_matrix(0, 1) <= (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry1(7 downto 0) + helper_carry1(8 downto 8)))) --add with carry
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry2(7 downto 0) + helper_carry2(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry3(7 downto 0) + helper_carry3(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry4(7 downto 0) + helper_carry4(8 downto 8))));
										 
				helper_carry1 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector1))) + X"C7";
				helper_carry2 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector2))) + X"DF";
				helper_carry3 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector3))) + X"68";
				helper_carry4 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector4))) + X"EE";
				out_matrix(1, 1) <= (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry1(7 downto 0) + helper_carry1(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry2(7 downto 0) + helper_carry2(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry3(7 downto 0) + helper_carry3(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry4(7 downto 0) + helper_carry4(8 downto 8))));
				
				helper_carry1 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector1))) + X"EE";
				helper_carry2 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector2))) + X"C7";
				helper_carry3 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector3))) + X"DF";
				helper_carry4 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector4))) + X"68";
				out_matrix(2, 1) <= (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry1(7 downto 0) + helper_carry1(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry2(7 downto 0) + helper_carry2(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry3(7 downto 0) + helper_carry3(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry4(7 downto 0) + helper_carry4(8 downto 8))));
				
				helper_carry1 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector1))) + X"68";
				helper_carry2 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector2))) + X"EE";
				helper_carry3 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector3))) + X"C7";
				helper_carry4 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector4))) + X"DF";
				out_matrix(3, 1) <= (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry1(7 downto 0) + helper_carry1(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry2(7 downto 0) + helper_carry2(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry3(7 downto 0) + helper_carry3(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry4(7 downto 0) + helper_carry4(8 downto 8))));
				
				--column 2:
				helper_vector1 := in_matrix(0, 2);
				helper_vector2 := in_matrix(1, 2);
				helper_vector3 := in_matrix(2, 2);
				helper_vector4 := in_matrix(3, 2);
				
				helper_carry1 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector1))) + X"DF";
				helper_carry2 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector2))) + X"68";
				helper_carry3 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector3))) + X"EE";
				helper_carry4 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector4))) + X"C7";
				out_matrix(0, 2) <= (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry1(7 downto 0) + helper_carry1(8 downto 8)))) --add with carry
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry2(7 downto 0) + helper_carry2(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry3(7 downto 0) + helper_carry3(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry4(7 downto 0) + helper_carry4(8 downto 8))));
										 
				helper_carry1 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector1))) + X"C7";
				helper_carry2 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector2))) + X"DF";
				helper_carry3 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector3))) + X"68";
				helper_carry4 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector4))) + X"EE";
				out_matrix(1, 2) <= (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry1(7 downto 0) + helper_carry1(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry2(7 downto 0) + helper_carry2(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry3(7 downto 0) + helper_carry3(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry4(7 downto 0) + helper_carry4(8 downto 8))));
				
				helper_carry1 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector1))) + X"EE";
				helper_carry2 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector2))) + X"C7";
				helper_carry3 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector3))) + X"DF";
				helper_carry4 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector4))) + X"68";
				out_matrix(2, 2) <= (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry1(7 downto 0) + helper_carry1(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry2(7 downto 0) + helper_carry2(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry3(7 downto 0) + helper_carry3(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry4(7 downto 0) + helper_carry4(8 downto 8))));
				
				helper_carry1 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector1))) + X"68";
				helper_carry2 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector2))) + X"EE";
				helper_carry3 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector3))) + X"C7";
				helper_carry4 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector4))) + X"DF";
				out_matrix(3, 2) <= (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry1(7 downto 0) + helper_carry1(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry2(7 downto 0) + helper_carry2(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry3(7 downto 0) + helper_carry3(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry4(7 downto 0) + helper_carry4(8 downto 8))));
				
				--column 3:
				helper_vector1 := in_matrix(0, 3);
				helper_vector2 := in_matrix(1, 3);
				helper_vector3 := in_matrix(2, 3);
				helper_vector4 := in_matrix(3, 3);
				
				helper_carry1 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector1))) + X"DF";
				helper_carry2 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector2))) + X"68";
				helper_carry3 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector3))) + X"EE";
				helper_carry4 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector4))) + X"C7";
				out_matrix(0, 3) <= (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry1(7 downto 0) + helper_carry1(8 downto 8)))) --add with carry
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry2(7 downto 0) + helper_carry2(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry3(7 downto 0) + helper_carry3(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry4(7 downto 0) + helper_carry4(8 downto 8))));
										 
				helper_carry1 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector1))) + X"C7";
				helper_carry2 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector2))) + X"DF";
				helper_carry3 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector3))) + X"68";
				helper_carry4 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector4))) + X"EE";
				out_matrix(1, 3) <= (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry1(7 downto 0) + helper_carry1(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry2(7 downto 0) + helper_carry2(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry3(7 downto 0) + helper_carry3(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry4(7 downto 0) + helper_carry4(8 downto 8))));
				
				helper_carry1 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector1))) + X"EE";
				helper_carry2 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector2))) + X"C7";
				helper_carry3 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector3))) + X"DF";
				helper_carry4 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector4))) + X"68";
				out_matrix(2, 3) <= (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry1(7 downto 0) + helper_carry1(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry2(7 downto 0) + helper_carry2(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry3(7 downto 0) + helper_carry3(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry4(7 downto 0) + helper_carry4(8 downto 8))));
				
				helper_carry1 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector1))) + X"68";
				helper_carry2 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector2))) + X"EE";
				helper_carry3 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector3))) + X"C7";
				helper_carry4 := ('0' & GALOIS_FIELD_L_TABLE(conv_integer(helper_vector4))) + X"DF";
				out_matrix(3, 3) <= (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry1(7 downto 0) + helper_carry1(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry2(7 downto 0) + helper_carry2(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry3(7 downto 0) + helper_carry3(8 downto 8))))
										 XOR (GALOIS_FIELD_E_TABLE(conv_integer(helper_carry4(7 downto 0) + helper_carry4(8 downto 8))));
				
			end if;
		end if;
	end process;

end Behavioral;
