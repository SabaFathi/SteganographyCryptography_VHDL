LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY extractor_LSB_testbench IS
END extractor_LSB_testbench;
 
ARCHITECTURE behavior OF extractor_LSB_testbench IS 

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT extractor_LSB
    PORT(
         stego_data : IN  std_logic_vector(7 downto 0);
         clk : IN  std_logic;
         enable : IN  std_logic;
         hidden_data : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;

   --Inputs
   signal stego_data : std_logic_vector(7 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal enable : std_logic := '0';
 	--Outputs
   signal hidden_data : std_logic_vector(7 downto 0);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: extractor_LSB PORT MAP (
          stego_data => stego_data,
          clk => clk,
          enable => enable,
          hidden_data => hidden_data
        );

    clk <= not clk after 5 ns;
	 
	 enable <= '1' after 0 ns, '0' after 90 ns;
	 stego_data <= "11111110" after 0 ns, "11111110" after 10 ns, "11111111" after 20 ns, "11111111" after 30 ns,
	               "11111110" after 40 ns, "11111111" after 50 ns, "11111110" after 60 ns, "11111111" after 70 ns;
	 --expected : hidden_data = "10101100"

END;
