library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity extractor_LSB is
port(stego_data : in std_logic_vector(7 downto 0);

     clk : in std_logic;
	  enable : in std_logic;
	  
	  hidden_data : out std_logic_vector(7 downto 0) := (others => '0'));
end extractor_LSB;

architecture Behavioral of extractor_LSB is
signal index : std_logic_vector(2 downto 0) := "000";
signal extracted_data : std_logic_vector(7 downto 0) := (others => '0');
begin

    process(clk, enable)
	 begin
	     if(rising_edge(clk))
		  then
		      if(enable = '1')
				then
				    if(index = "000")
					 then
				        hidden_data <= extracted_data;
					 end if;
					 
				    extracted_data(conv_integer(index)) <= stego_data(0);
					 index <= index + 1;
				else
				    index <= "000";
					 extracted_data <= (others => '0');
					 hidden_data <= (others => '0');
				end if;
		  end if;
	 end process;

end Behavioral;
