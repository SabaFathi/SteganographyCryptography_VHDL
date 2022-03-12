library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use work.AES_DEPENDENCY_PKG.ALL;

entity AES_encrypter is
port(encryption_key : in std_logic_vector(127 downto 0);
     plain_data : in std_logic_vector(127 downto 0);
	  
	  enable : in std_logic;
	  clk : in std_logic;
	  
	  cipher_data : out std_logic_vector(127 downto 0));
end AES_encrypter;

architecture Structural of AES_encrypter is

component matrix4x4_xor is
port(matrix1 : in matrix_4X4;
	  matrix2 : in matrix_4X4;
	  matrix_result : out matrix_4X4);
end component;

component sbox_mapper is
port(indexes_matrix : in matrix_4X4;
	  values_matrix : out matrix_4X4);
end component;

component row_shifter is
port(in_matrix : in matrix_4X4;
	  clk : in std_logic;
	  enable : in std_logic;
	  out_matrix : out matrix_4X4);
end component;

component column_mixer is
port(in_matrix : in matrix_4X4;
	  clk : in std_logic;
	  enable : in std_logic;
	  out_matrix : out matrix_4X4);
end component;

signal key_matrix : matrix_4X4;
signal plain_data_matrix : matrix_4X4;

signal xor_matrix : matrix_4X4;
signal mapped_matrix : matrix_4X4;
signal shifted_matrix : matrix_4X4;
--signal mixed_data_matrix : matrix_4X4;
signal shift_en : std_logic := '0';
signal mix_en : std_logic := '0';

type state is (xor_substitution, shift_row, mix_columns);
signal cur_state : state := xor_substitution;
begin

--STEP 0 : data to matrix(column by column)
--STEP 1 : input-data XOR key
--STEP 2 : SubBytes (Substitution) (using Rijndael S-BOX)
--STEP 3 : ShiftRows
--STEP 4 : MixColumns

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
	
	plain_data_matrix(0, 0) <= plain_data(127 downto 120);
	plain_data_matrix(1, 0) <= plain_data(119 downto 112);
	plain_data_matrix(2, 0) <= plain_data(111 downto 104);
	plain_data_matrix(3, 0) <= plain_data(103 downto 96 );
	plain_data_matrix(0, 1) <= plain_data(95  downto 88 );
	plain_data_matrix(1, 1) <= plain_data(87  downto 80 );
	plain_data_matrix(2, 1) <= plain_data(79  downto 72 );
	plain_data_matrix(3, 1) <= plain_data(71  downto 64 );
	plain_data_matrix(0, 2) <= plain_data(63  downto 56 );
	plain_data_matrix(1, 2) <= plain_data(55  downto 48 );
	plain_data_matrix(2, 2) <= plain_data(47  downto 40 );
	plain_data_matrix(3, 2) <= plain_data(39  downto 32 );
	plain_data_matrix(0, 3) <= plain_data(31  downto 24 );
	plain_data_matrix(1, 3) <= plain_data(23  downto 16 );
	plain_data_matrix(2, 3) <= plain_data(15  downto 8  );
	plain_data_matrix(3, 3) <= plain_data(7   downto 0  );
	
	xor_instance : matrix4x4_xor port map(matrix1 => key_matrix, matrix2 => plain_data_matrix, matrix_result => xor_matrix);
	sbox_instance : sbox_mapper port map(indexes_matrix => xor_matrix, values_matrix => mapped_matrix);
	shift_instance : row_shifter port map(in_matrix => mapped_matrix, clk => clk, enable => shift_en, out_matrix => shifted_matrix);
	
	--mix_instance : column_mixer port map(in_matrix => shifted_matrix, clk => clk, enable => mix_en, out_matrix => mixed_data_matrix);

	process(clk)
	begin
		if(rising_edge(clk))
		then
			if(enable = '1')
			then
				case cur_state is
				when xor_substitution =>
						shift_en <= '1';
						cur_state <= shift_row;
				when shift_row =>
						mix_en <= '1';
						cur_state <= mix_columns;
				when mix_columns =>
						shift_en <= '0';
						mix_en <= '0';
						cur_state <= xor_substitution;
						
						cipher_data(127 downto 120) <= shifted_matrix(0, 0);
						cipher_data(119 downto 112) <= shifted_matrix(1, 0);
						cipher_data(111 downto 104) <= shifted_matrix(2, 0);
						cipher_data(103 downto 96 ) <= shifted_matrix(3, 0);
						cipher_data(95  downto 88 ) <= shifted_matrix(0, 1);
						cipher_data(87  downto 80 ) <= shifted_matrix(1, 1);
						cipher_data(79  downto 72 ) <= shifted_matrix(2, 1);
						cipher_data(71  downto 64 ) <= shifted_matrix(3, 1);
						cipher_data(63  downto 56 ) <= shifted_matrix(0, 2);
						cipher_data(55  downto 48 ) <= shifted_matrix(1, 2);
						cipher_data(47  downto 40 ) <= shifted_matrix(2, 2);
						cipher_data(39  downto 32 ) <= shifted_matrix(3, 2);
						cipher_data(31  downto 24 ) <= shifted_matrix(0, 3);
						cipher_data(23  downto 16 ) <= shifted_matrix(1, 3);
						cipher_data(15  downto 8  ) <= shifted_matrix(2, 3);
						cipher_data(7   downto 0  ) <= shifted_matrix(3, 3);
				when others =>
				end case;
			end if;
		end if;
	end process;

end Structural;
