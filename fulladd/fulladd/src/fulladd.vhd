LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY fulladd IS
 PORT ( x1, y1, cin: IN STD_LOGIC;sum, cout: OUT STD_LOGIC);
END ENTITY fulladd;

ARCHITECTURE simple OF fulladd IS
BEGIN
 sum <= cin XOR x1 XOR y1;
 cout <= ( x1 AND y1 ) OR ( cin AND x1 ) OR ( y1 AND cin );
END ARCHITECTURE simple; 