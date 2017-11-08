library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity irwb is
	port( 		
	clk:in std_logic;
	instruction:in std_logic_vector(31 downto 0):= ( others => '0');
	mem_w: out std_logic:='0';
	reg_c: out std_logic_vector(1 downto 0);
	addr3:out std_logic_vector(4 downto 0)
	);
end entity irwb;

architecture sample of irwb is
begin 	 
process(clk) 
begin 
	case instruction (31 downto 20) is
	when X"020" =>  	   --alus
		reg_c<=instruction(1 downto 0);
		mem_w<='0';
	when others =>
		case instruction(31 downto 16) is
		when X"0100" =>	
		reg_c<=instruction(1 downto 0);
		mem_w<='0';
		when X"0101" =>	   --movi
		reg_c<=instruction(1 downto 0);
		mem_w<='0';
		when X"0300" =>	   --Load
		reg_c<=instruction(1 downto 0);
		mem_w<='0';
		when X"0400" =>		--STORE
		mem_w<='1';
		addr3<=instruction(4 downto 0);
		when X"0500" =>		--Goto
		mem_w<='0';
		when X"0600" =>		--Others
		when others =>
		mem_w<='0';
		end case;
	end case;

end process;
end architecture sample;