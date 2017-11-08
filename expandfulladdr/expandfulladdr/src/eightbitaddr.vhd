library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity eightbitaddr	is
	generic (n:integer:=7);
	port(x1,y1: in std_logic_vector(n downto 0);
	cin:in  std_logic;
	sum:out  std_logic_vector(n downto 0);
	cout: out std_logic);
end entity eightbitaddr;		   

architecture behavial of eightbitaddr is

	signal carry:std_logic_vector(n-1 downto 0);
begin 
	
	g0:entity work.fulladd(simple) port map(x1(0),y1(0),cin,sum(0),carry(0));
	p1:for i in 1 to n-1 generate
		gi: entity work.fulladd(simple) port map(x1(i),y1(i),carry(i-1),sum(i),carry(i));
	end generate;
	
	g7:entity work.fulladd(simple) port map(x1(7),y1(7),carry(6),sum(7),cout);
		
end architecture behavial;