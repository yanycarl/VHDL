LIBRARY ieee;
USE ieee.std_logic_1164.ALL; 

ENTITY adder4bit IS
 PORT ( x, y: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
 cin: IN STD_LOGIC;
 sum: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
 cout: OUT STD_LOGIC);
END ENTITY adder4bit;  

ARCHITECTURE structural OF adder4bit IS
 SIGNAL carry: STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN
 g0: entity work.fulladd(simple)PORT MAP (x(0),y(0),cin,sum(0),carry(0));
 g1: entity work.fulladd(simple)PORT MAP (x(1),y(1),carry(0),sum(1),carry(1));
 g2: entity work.fulladd(simple)PORT MAP (x(2),y(2),carry(1),sum(2),carry(2));
 g3: entity work.fulladd(simple)PORT MAP (x(3),y(3),carry(2),sum(3),cout);
END ARCHITECTURE structural; 