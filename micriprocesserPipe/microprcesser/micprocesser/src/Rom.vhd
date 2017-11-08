library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity rom is
	port(addr: in std_logic_vector(6 downto 0);   
	output: out std_logic_vector(31 downto 0));
end entity rom;

architecture sample of rom is
	type rom_array is array (0 to 127) of std_logic_vector(31 downto 0);
	signal rom_data:rom_array:=( 
	X"03000C01", X"03001002", X"02040443", X"01000C02", X"03001401", X"020D0823", X"01000C02", X"03001801",
	X"020D0823", X"01000C02", X"03000001", X"02040443", X"01000C02", X"03002001", X"020D0823", X"01000C02",
	X"03002401", X"020D0823", X"01000C02", X"03002801", X"020D0823", X"01000C02", X"03000401", X"02040443",
	X"01000C02", X"03003001", X"020D0823", X"01000C02", X"03003401", X"020D0823", X"01000C02", X"03003801",
	
	X"020D0823", X"01000C02", X"03003C01", X"02040443", X"01000C02", X"03004001", X"02040443", X"01000C02",
	X"03004401", X"020D0823", X"01000C02", X"03004801", X"020D0823", X"01000C02", X"03004C01", X"02040443",
	X"01000C02", X"03005001", X"02040443", X"01000C02", X"03005401", X"020D0823", X"01000C02", X"03005801",
	X"020D0823", X"01000C02", X"03005C01", X"02040443", X"01000C02", X"03006001", X"02040443", X"01000C02",
	
	X"03006401", X"020D0823", X"01000C02", X"03006801", X"020D0823", X"01000C02", X"03006C01", X"02040443",
	X"01000C02", X"03007001", X"02040443", X"01000C02", X"03007401", X"020D0823", X"01000C02", X"03007801",
	X"020D0823", X"01000C02", X"03007C01", X"02040443", X"01000C02", X"00000000", X"00000000", X"00000000",
	X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
	
	X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
	X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
	X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000",
	X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000", X"00000000");
begin
	output<=rom_data(conv_integer(addr));
end architecture sample;