library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity decrypter_caesar_cipher is
port(encrypted_data: in std_logic_vector(7 downto 0);
     key : in std_logic_vector(6 downto 0); --max value = 127
	  
	  clk : in std_logic;
	  enable : in std_logic;
	  
	  plain_data : out std_logic_vector(7 downto 0) := (others => '0'));
end decrypter_caesar_cipher;

architecture Behavioral of decrypter_caesar_cipher is

begin

    
    process(clk, enable)
	 begin
	     if(rising_edge(clk))
		  then
		      if(enable = '1')
				then
				    plain_data <= encrypted_data - key;
				else
				    plain_data <= (others => '0');
				end if;
		  end if;
	 end process;

end Behavioral;
