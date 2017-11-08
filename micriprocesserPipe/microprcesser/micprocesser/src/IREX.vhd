library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity irex is
	port( 
	clk:in std_logic;
	instruction:in std_logic_vector(31 downto 0):= ( others => '0'); 
	opcode:out std_logic_vector(5 downto 0);
	instructionOut:out std_logic_vector(31 downto 0)
	);
end entity irex; 

architecture sample of irex is
begin 	 
process(clk) 
begin 
	case instruction (31 downto 20) is
	when X"020" =>  	   --alus
		opcode<= instruction(21 downto 16);
	when others =>
		case instruction(31 downto 16) is
		when X"0100" =>	
		opcode<="000100";
		when X"0101" =>	   --movi
		opcode<="000100";
		when X"0300" =>	   --Load
		opcode<="000100";
		when X"0400" =>		--STORE
		opcode<="000100";
		when X"0500" =>		--Goto
		opcode<="000100";
		when X"0600" =>		--Others
		when others =>
		opcode<="000000";
		end case;
	end case;
	
	if(rising_edge(clk)) then  
		instructionOut<= instruction;
	end if;
end process;
end architecture sample;