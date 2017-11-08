library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity top is
end entity top;

architecture sample of top is 
signal clk:std_logic; 
signal clk1:std_logic:='0';
signal rom_addr:std_logic_vector(6 downto 0);
signal addr1:std_logic_vector(4 downto 0);
signal addr2:std_logic_vector(4 downto 0);
signal addr3:std_logic_vector(4 downto 0);
signal output1:std_logic_vector(31 downto 0);	
signal output2:std_logic_vector(31 downto 0);
signal input:std_logic_vector(31 downto 0);
signal opcode:std_logic_vector(5 downto 0);
signal reg_sa:std_logic_vector(1 downto 0); 
signal reg_sb:std_logic_vector(1 downto 0);
signal reg_sc:std_logic_vector(1 downto 0);
signal alu_a:std_logic_vector(31 downto 0);
signal alu_b:std_logic_vector(31 downto 0);
signal alu_c:std_logic_vector(31 downto 0);
signal mem_w:std_logic;	
signal mem_r:std_logic;
signal instruction:std_logic_vector(31 downto 0);
signal instance_number:std_logic_vector(31 downto 0);
signal instance_en:std_logic;  
signal instructionOut:std_logic_vector(31 downto 0);
signal instructionOut2:std_logic_vector(31 downto 0);
signal processcounter:std_logic_vector(2 downto 0):="000";	
type word is array(3 downto 0) of std_logic_vector(31 downto 0);
signal reg:word:=( others => X"00000000" );
signal pc_fromalu:std_logic_vector(6 downto 0);

begin 
process(clk)
begin
case processcounter is 
	when "000" =>	
	processcounter<=std_logic_vector(to_signed(conv_integer(processcounter)+1, 3));
	clk1<= '1';	
	when "001" =>	
	processcounter<=std_logic_vector(to_signed(conv_integer(processcounter)+1, 3));
	clk1<= '0';		
	processcounter<=std_logic_vector(to_signed(conv_integer(processcounter)+1, 3)); 
	when "010" =>
	processcounter<=std_logic_vector(to_signed(conv_integer(processcounter)+1, 3));
	when "011" =>
	processcounter<=std_logic_vector(to_signed(conv_integer(processcounter)+1, 3));
	when "100" =>
	processcounter<=std_logic_vector(to_signed(conv_integer(processcounter)+1, 3));
	when "101" =>
	processcounter<=std_logic_vector(to_signed(conv_integer(processcounter)+1, 3));
	when "111" =>
	processcounter<="000";
	when others => 
	processcounter<="000";
	end case;
	
	case  mem_r is
	when '0'=>
		case  reg_sa is
			when "01"=>
			alu_a<=reg(1);
			when "10"=>
			alu_a<=reg(2);
			when "11"=>
			alu_a<=reg(3);
			when "00" =>
			alu_a<=reg(0);
		when others =>
		end case;
	
							case instance_en is
							when '0' =>
								case  reg_sb is
									when "01"=>
									alu_b<=reg(1);
									when "10"=>
									alu_b<=reg(2);
									when "11"=>
									alu_b<=reg(3);
									when "00" =>
									alu_b<=reg(0);
								when others =>
								end case;
							when '1'=>
								alu_b<=instance_number;
							when others =>
							end case; 	
	when '1'=>
	alu_a<=output1;
	alu_b<=output2;
	when others =>
	end case;  
	
	case mem_w is
	when '1' =>
		input<=alu_c;
	when '0' =>	
			  case  reg_sc is
				when "00"=>
				reg(0)<=alu_c;
				when "01"=>
				reg(1)<=alu_c;
				when "10"=>
				reg(2)<=alu_c;
				 when "11"=>
				reg(3)<=alu_c;
			when others =>
			end case;
			pc_fromalu<=alu_c(6 downto 0);
	when others =>
	end case;
	
end process;
	reg(0)<=X"00000000";
	g1:entity work.alu(sample) port map (alu_a,alu_b,opcode,alu_c,clk1);
	g2:entity work.mem(sample) port map (addr1,addr2,addr3,input,output1,output2,mem_w,clk);
	g3:entity work.ir(sample) port map (clk1,instruction,pc_fromalu,rom_addr,addr1,addr2,reg_sa,reg_sb,instance_number,instance_en,mem_r,instructionOut);
	g4:entity work.rom(sample) port map(rom_addr,instruction); 
	g5:entity work.irex(sample) port map (clk1,instructionOut,opcode,instructionOut2);
	g6:entity work.irwb(sample) port map (clk1,instructionOut2,mem_w,reg_sc,addr3);
end architecture sample;