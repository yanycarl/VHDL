LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fulladd IS
 PORT ( x, y, cin: IN STD_LOGIC;sum, cout: OUT STD_LOGIC);
END ENTITY fulladd;

ARCHITECTURE simple OF fulladd IS
BEGIN
 sum <= cin XOR x XOR y;
 cout <= ( x AND y ) OR ( cin AND x ) OR ( y AND cin );
END ARCHITECTURE simple; 