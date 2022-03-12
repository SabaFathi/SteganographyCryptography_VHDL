library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity encrypter_caesar_cipher is
port(plain_data: in std_logic_vector(7 downto 0);
     key : in std_logic_vector(6 downto 0); --max value = 127
	  
	  clk : in std_logic;
	  enable : in std_logic;
	  
	  encrypted_data : out std_logic_vector(7 downto 0) := (others => '0'));
end encrypter_caesar_cipher;

architecture Behavioral of encrypter_caesar_cipher is

begin

    process(clk, enable)
	 begin
	     if(rising_edge(clk))
		  then
		      if(enable = '1')
				then
				    encrypted_data <= plain_data + key;
				else
				    encrypted_data <= (others => '0');
				end if;
		  end if;
	 end process;

end Behavioral;
