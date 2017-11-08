----------------------------------------------------------------------------------
-- Company: University of Birmingham
-- Engineer: CAO YANYAO 1855116
-- 
-- Create Date:    10:29:30 10/12/2017 
-- Design Name: 
-- Module Name:    alu - sample 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity alu is
	port(a,b:in std_logic_vector(31 downto 0 );
		opcode:in std_logic_vector(5 downto 0 );
		result:out std_logic_vector(31 downto 0);
		clk:in std_logic);
end entity alu;

architecture sample of alu is
	signal int_a:integer;
	signal int_b:integer;
	
begin
process (clk)
begin  
	int_a<=conv_integer(a);
	int_b<=conv_integer(b);
	case opcode is
	when "000100" =>
		result<= std_logic_vector(to_signed(int_a+int_b, 32));
	when "001101" =>
		result<= std_logic_vector(to_signed(int_a-int_b, 32));
	when "001000" =>
		if (int_a<0) then
			result<= std_logic_vector(to_signed(0-int_a, 32));
		else
			result<= std_logic_vector(to_signed(int_a, 32));
		end if;
	when "000111" =>
		result<= std_logic_vector(to_signed(0-int_a, 32));
	when "001010" =>
		if (int_b<0) then
		result<= std_logic_vector(to_signed(0-int_b, 32));
		else
		result<= std_logic_vector(to_signed(int_b, 32));
		end if;
	when "000101" =>
		result<= std_logic_vector(to_signed(0-int_b, 32));
	when "001011" =>
		result<=a or b;
	when "001100" =>
		result<=not a;
	when "001110" =>
		result<=not b;
	when "000011" =>
		result<=a and b;
	when "001111" =>
		result<=a xor b;
	when others =>
	end case;
end process;
end architecture sample;
