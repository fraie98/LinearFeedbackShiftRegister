library IEEE;
use IEEE.std_logic_1164.all;

entity lfsr_wrapper is
	port(
			clk		:	in std_logic;
			reset	:	in std_logic;	
			seed	:	in std_logic_vector(0 to 3);
			led_out	:	out std_logic_vector(0 to 3);
			yq		:	out std_logic_vector(5 downto 0)
		);
end lfsr_wrapper;

architecture struct of lfsr_wrapper is

signal seed_internal : std_logic_vector(0 to 15) := "0000101011000110";
signal isTap_internal : std_logic_vector(0 to 14) := "000000000010110";
signal state_internal : std_logic_vector(15 downto 0);
signal out_internal :std_logic;
signal reset_internal : std_logic;

component lfsr is
	generic (Nbit : positive := 16);
	port(
			clock		:	in 	std_logic;
			reset 		:	in 	std_logic;
			isTap		: 	in 	std_logic_vector(0 to Nbit-2);
			seed		:	in 	std_logic_vector(0 to Nbit-1);
			outputBit	: 	out std_logic;
			state		: 	out std_logic_vector(Nbit-1 downto 0)
		);
	end component;
 
begin
	LFSR_MAPPING : lfsr
	port map(
			seed 		=> seed_internal,
			outputBit	=> out_internal,
			reset		=> reset_internal,
			clock 		=> clk,
			isTap 		=> isTap_internal,
			state 		=> state_internal
		);

	seed_internal(0 to 3) <= seed;
	seed_internal(4 to 15) <= "101011000110";
  	reset_internal <= not(reset);

  	yq<= "00000"&out_internal;
	--yq(0) <= out_internal; 
	--yq(5 downto 1) <= (others => '0');

  	led_out <= seed;
end struct;
