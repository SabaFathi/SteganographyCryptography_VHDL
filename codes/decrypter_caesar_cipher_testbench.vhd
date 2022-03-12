LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY decrypter_caesar_cipher_testbench IS
END decrypter_caesar_cipher_testbench;
 
ARCHITECTURE behavior OF decrypter_caesar_cipher_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT decrypter_caesar_cipher
    PORT(
         encrypted_data : IN  std_logic_vector(7 downto 0);
         key : IN  std_logic_vector(6 downto 0);
         clk : IN  std_logic;
         enable : IN  std_logic;
         plain_data : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal encrypted_data : std_logic_vector(7 downto 0) := (others => '0');
   signal key : std_logic_vector(6 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal enable : std_logic := '0';
 	--Outputs
   signal plain_data : std_logic_vector(7 downto 0);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: decrypter_caesar_cipher PORT MAP (
          encrypted_data => encrypted_data,
          key => key,
          clk => clk,
          enable => enable,
          plain_data => plain_data
        );

    clk <= not clk after 5 ns;
	 
	 enable <= '1' after 0 ns, '0' after 80 ns;
	 key <= "0000001" after 0 ns, "1111111" after 40 ns;
	 encrypted_data <= "00010000" after 0 ns, "11110001" after 10 ns, "00000001" after 20 ns, "00000000" after 30 ns,
	                   "10001110" after 40 ns, "01101111" after 50 ns, "01111111" after 60 ns, "01111110" after 70 ns;
	 --expected : plain_data = "00001111", "11110000", "00000000", "11111111",
	 --                        "00001111", "11110000", "00000000", "11111111";

END;
