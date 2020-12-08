-- LinearFeedbackShiftRegister
library ieee;
use ieee.std_logic_1164.all;

entity lfsr_two_dff is
	generic (Nbit : positive := 8);
	port(
			clock		:	in 	std_logic;
			reset 		:	in 	std_logic;
			isTap		:	in std_logic;
			seed		: 	in std_logic_vector(1 downto 0);
			outputBit	: 	out std_logic;
			state		: 	out std_logic_vector(1 downto 0)
		);
	end lfsr_two_dff;


architecture rtl of lfsr_two_dff is
	component dff_tap_circuit is
	port(
			clk			:	in 	std_logic;
			reset 		:	in 	std_logic;
			set			: 	in 	std_logic;  -- initialization input
			d_in		:	in 	std_logic;	
			isTap		:	in 	std_logic;	-- it indicates if the input must be changed (it does if the previous ff is a tap)
			feedback	:	in 	std_logic;  -- it is the feedback bit (the N-1)
			q_out		:	out std_logic
		);
	end component;

	signal lastBit : std_logic := '0';
	signal int : std_logic;
begin
	FF1 : dff_tap_circuit port map(clock, reset, seed(0), lastBit,'0', lastBit,int);
	FFI : dff_tap_circuit port map(clock, reset, seed(1), int, isTap, lastBit, lastBit);
	state <= int&lastBit;
	outputBit <= lastBit;
end rtl;