library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use work.AES_DEPENDENCY_PKG.ALL;

entity AES_decrypter is
port(encryption_key : in std_logic_vector(127 downto 0);
     cipher_data : in std_logic_vector(127 downto 0);
	  
	  enable : in std_logic;
	  clk : in std_logic;
	  
	  plain_data : out std_logic_vector(127 downto 0));
end AES_decrypter;

architecture Structural of AES_decrypter is

component column_inverted_mixer is
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

component sbox_inverted_mapper is
port(indexes_matrix : in matrix_4X4;
	  values_matrix : out matrix_4X4);
end component;

component matrix4x4_xor is
port(matrix1 : in matrix_4X4;
	  matrix2 : in matrix_4X4;
	  matrix_result : out matrix_4X4);
end component;

signal key_matrix : matrix_4X4;
signal cipher_data_matrix : matrix_4X4;

signal xor_matrix : matrix_4X4;
signal mapped_matrix : matrix_4X4;
signal unshifted_matrix : matrix_4X4;
--signal unmixed_data_matrix : matrix_4X4;
signal shift_en : std_logic := '0';
signal mix_en : std_logic := '0';

type state is (unmix_columns, unshift_row, substitution_xor);
signal cur_state : state := unmix_columns;

begin

--STEP 0 : data to matrix(column by column)
--STEP 1 : undo MixColumns
--STEP 2 : undo ShiftRows
--STEP 3 : undo SubBytes (Substitution) (using Rijndael inverted S-BOX)
--STEP 4 : undo data XOR key

	key_matrix(0, 0) <= encryption_key(127 downto 120);
	key_matrix(1, 0) <= encryption_key(119 downto 112);
	key_matrix(2, 0) <= encryption_key(111 downto 104);
	key_matrix(3, 0) <= encryption_key(103 downto 96 );
	key_matrix(0, 1) <= encryption_key(95  downto 88 );
	key_matrix(1, 1) <= encryption_key(87  downto 80 );
	key_matrix(2, 1) <= encryption_key(79  downto 72 );
	key_matrix(3, 1) <= encryption_key(71  downto 64 );
	key_matrix(0, 2) <= encryption_key(63  downto 56 );
	key_matrix(1, 2) <= encryption_key(55  downto 48 );
	key_matrix(2, 2) <= encryption_key(47  downto 40 );
	key_matrix(3, 2) <= encryption_key(39  downto 32 );
	key_matrix(0, 3) <= encryption_key(31  downto 24 );
	key_matrix(1, 3) <= encryption_key(23  downto 16 );
	key_matrix(2, 3) <= encryption_key(15  downto 8  );
	key_matrix(3, 3) <= encryption_key(7   downto 0  );

	cipher_data_matrix(0, 0) <= cipher_data(127 downto 120);
	cipher_data_matrix(1, 0) <= cipher_data(119 downto 112);
	cipher_data_matrix(2, 0) <= cipher_data(111 downto 104);
	cipher_data_matrix(3, 0) <= cipher_data(103 downto 96 );
	cipher_data_matrix(0, 1) <= cipher_data(95  downto 88 );
	cipher_data_matrix(1, 1) <= cipher_data(87  downto 80 );
	cipher_data_matrix(2, 1) <= cipher_data(79  downto 72 );
	cipher_data_matrix(3, 1) <= cipher_data(71  downto 64 );
	cipher_data_matrix(0, 2) <= cipher_data(63  downto 56 );
	cipher_data_matrix(1, 2) <= cipher_data(55  downto 48 );
	cipher_data_matrix(2, 2) <= cipher_data(47  downto 40 );
	cipher_data_matrix(3, 2) <= cipher_data(39  downto 32 );
	cipher_data_matrix(0, 3) <= cipher_data(31  downto 24 );
	cipher_data_matrix(1, 3) <= cipher_data(23  downto 16 );
	cipher_data_matrix(2, 3) <= cipher_data(15  downto 8  );
	cipher_data_matrix(3, 3) <= cipher_data(7   downto 0  );

	--unmix_instance : column_inverted_mixer port map(in_matrix => cipher_data_matrix, clk => clk, enable => mix_en, out_matrix => unmixed_data_matrix);
	
	unshift_instance : row_inverted_shifter port map(in_matrix => cipher_data_matrix, clk => clk, enable => shift_en, out_matrix => unshifted_matrix);
	sbox_instance : sbox_inverted_mapper port map(indexes_matrix => unshifted_matrix, values_matrix => mapped_matrix);
	xor_instance : matrix4x4_xor port map(matrix1 => key_matrix, matrix2 => mapped_matrix, matrix_result => xor_matrix);

	process(clk)
	begin
		if(rising_edge(clk))
		then
			if(enable = '1')
			then
				case cur_state is
				when unmix_columns =>
						mix_en <= '1';
						cur_state <= unshift_row;
				when unshift_row =>
						mix_en <= '0';
						shift_en <= '1';
						cur_state <= substitution_xor;
				when substitution_xor =>
						shift_en <= '0';
						cur_state <= unmix_columns;
						
						plain_data(127 downto 120) <= xor_matrix(0, 0);
						plain_data(119 downto 112) <= xor_matrix(1, 0);
						plain_data(111 downto 104) <= xor_matrix(2, 0);
						plain_data(103 downto 96 ) <= xor_matrix(3, 0);
						plain_data(95  downto 88 ) <= xor_matrix(0, 1);
						plain_data(87  downto 80 ) <= xor_matrix(1, 1);
						plain_data(79  downto 72 ) <= xor_matrix(2, 1);
						plain_data(71  downto 64 ) <= xor_matrix(3, 1);
						plain_data(63  downto 56 ) <= xor_matrix(0, 2);
						plain_data(55  downto 48 ) <= xor_matrix(1, 2);
						plain_data(47  downto 40 ) <= xor_matrix(2, 2);
						plain_data(39  downto 32 ) <= xor_matrix(3, 2);
						plain_data(31  downto 24 ) <= xor_matrix(0, 3);
						plain_data(23  downto 16 ) <= xor_matrix(1, 3);
						plain_data(15  downto 8  ) <= xor_matrix(2, 3);
						plain_data(7   downto 0  ) <= xor_matrix(3, 3);
				when others =>
				end case;
			end if;
		end if;
	end process;

end Structural;
