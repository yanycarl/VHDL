library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ir is
	port( 
	rom_addr:out std_logic_vector(6 downto 0);
	opcode:out std_logic_vector(5 downto 0);
	instruction:in std_logic_vector(31 downto 0);
	clk:in std_logic;
	mem_w: out std_logic:='0';
	mem_r: out std_logic;
	reg_a: out std_logic_vector(1 downto 0);
	reg_b: out std_logic_vector(1 downto 0);
	reg_c: out std_logic_vector(1 downto 0);
	addr1:out std_logic_vector(4 downto 0);
	addr2:out std_logic_vector(4 downto 0);
	addr3:out std_logic_vector(4 downto 0);
	instance_number:out std_logic_vector(31 downto 0);
	instance_en: out std_logic; 
	pc_fromalu:	in std_logic_vector(6 downto 0)
	);
end entity ir;

architecture sample of ir is
signal pc:std_logic_vector(6 downto 0):="0000000";
begin 	 
process(clk) 
begin 
	case instruction (31 downto 20) is
	when X"020" =>  	   --alus
		opcode<= instruction(21 downto 16);
		mem_r<='0';
		reg_a<=instruction(11 downto 10);
		reg_b<=instruction(6 downto 5);
		reg_c<=instruction(1 downto 0);
		mem_w<='0';
	when others =>
		case instruction(31 downto 16) is
		when X"0100" =>	
		mem_r<='0';		   --mov
		reg_a<=instruction(11 downto 10);
		reg_b<="00";
		reg_c<=instruction(1 downto 0);
		opcode<="000100";
		instance_en<='0';
		mem_w<='0';
		when X"0101" =>	   --movi
		mem_r<='0';
		opcode<="000100";
		reg_a<=instruction(11 downto 10);
		instance_number(4 downto 0)<=instruction(9 downto 5);
		instance_number(31 downto 5)<=(others => '0');
		reg_c<=instruction(1 downto 0);
		mem_w<='0';
		instance_en<='1';
		when X"0300" =>	   --Load
		mem_r<='1';
	    addr1<=instruction(14 downto 10);
		addr2<=(others => '0');
		reg_c<=instruction(1 downto 0);
		opcode<="000100";
		mem_w<='0';
		instance_en<='0';
		when X"0400" =>		--STORE
		mem_r<='0';
		opcode<="000100";
		reg_a<=instruction(11 downto 10);
		reg_b<="00";
		mem_w<='1';
		instance_en<='0';
		addr3<=instruction(4 downto 0);
		when X"0500" =>		--Goto
		mem_r<='0';
		opcode<="000100";
		reg_a<="00";
		reg_b<="00";
		mem_w<='0';
		instance_number(4 downto 0)<=instruction(4 downto 0);
		instance_number(31 downto 5)<=(others => '0');
		instance_en<='1';
		when X"0600" =>		--Others
		when others =>
		mem_w<='0';
		mem_r<='0';
		opcode<="000000";
		instance_en<='0';	
		end case;
	end case;
	
	
	if(rising_edge(clk)) then  
		case instruction(31 downto 20) is
		when X"050" =>
			pc<=pc_fromalu;
			rom_addr<=pc;
		when others=>
			pc<=std_logic_vector(to_unsigned(conv_integer(pc)+1, 7));
			rom_addr<=pc;
		end case;
	end if;
end process;
end architecture sample;