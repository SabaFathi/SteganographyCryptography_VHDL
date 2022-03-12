LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY encrypter_caesar_cipher_testbench IS
END encrypter_caesar_cipher_testbench;

ARCHITECTURE behavior OF encrypter_caesar_cipher_testbench IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT encrypter_caesar_cipher
    PORT(
         plain_data : IN  std_logic_vector(7 downto 0);
         key : IN  std_logic_vector(6 downto 0);
         clk : IN  std_logic;
         enable : IN  std_logic;
         encrypted_data : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal plain_data : std_logic_vector(7 downto 0) := (others => '0');
   signal key : std_logic_vector(6 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal enable : std_logic := '0';
 	--Outputs
   signal encrypted_data : std_logic_vector(7 downto 0);
	
	type data_array is array(0 to 3) of std_logic_vector(7 downto 0);
	constant test_data : data_array  := ("00001111", "11110000", "00000000", "11111111");

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: encrypter_caesar_cipher PORT MAP (
          plain_data => plain_data,
          key => key,
          clk => clk,
          enable => enable,
          encrypted_data => encrypted_data
        );

    clk <= not clk after 5 ns;
	 
	 enable <= '1' after 0 ns, '0' after 80 ns;
	 key <= "0000001" after 0 ns, "1111111" after 40 ns;
	 plain_data <= test_data(0) after 0 ns, test_data(1) after 10 ns, test_data(2) after 20 ns, test_data(3) after 30 ns,
	               test_data(0) after 40 ns, test_data(1) after 50 ns, test_data(2) after 60 ns, test_data(3) after 70 ns;
    --expected : encrypted_data = "00010000", "11110001", "00000001", "00000000",
	 --                            "10001110", "01101111", "01111111", "01111110";

END;
