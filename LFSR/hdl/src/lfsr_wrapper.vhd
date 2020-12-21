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

signal seed_internal : std_logic_vector(0 to 15);
signal isTap_internal : std_logic_vector(0 to 14);
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
	isTap_internal <= "000000000010110";
	
	LFSR_MAPPING : lfsr
	port map(
			seed 		=> seed_internal,
			outputBit	=> out_internal,
			reset		=> reset,
			clock 		=> clk,
			isTap 		=> isTap_internal,
			state 		=> state_internal
		);

	seed_internal(0 to 3) <= seed;				-- Part of the seed changeable from the user
	seed_internal(4 to 15) <= "101011000110";	-- Pre-fixed value

  	yq<= "00000"&out_internal;

  	led_out <= seed;  -- feedback for the user to see which bits of "seed" are 1 and which are 0
end struct;
