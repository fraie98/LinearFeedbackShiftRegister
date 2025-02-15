-- D Flip-Flop with Set/Reset and tap circuit
library ieee;
use ieee.std_logic_1164.all;

entity dff_tap_circuit is
	port(
			clk			:	in 	std_logic;
			reset 		:	in 	std_logic;
			set			: 	in 	std_logic;  -- initialization input (necessary for seed initialization)
			d_in		:	in 	std_logic;	
			isTap		:	in 	std_logic;	-- it indicates if the input must be changed (it does if the previous ff is a tap)
			feedback	:	in 	std_logic;  -- it is the feedback bit (the N-1 bit of the LFSR)
			q_out		:	out std_logic
		);
	end dff_tap_circuit;


architecture rtl of dff_tap_circuit is
component dff is
	port(
			clk		:	in 	std_logic;
			reset 	:	in 	std_logic;
			set		: 	in 	std_logic;
			d 		:	in 	std_logic;
			q 		:	out std_logic
		);
	end component;

	signal new_d : std_logic; -- signal that is the result of the logic (XOR+AND) and it is the dff input
begin
	internal_dff : dff
		port map(
				clk 	=> clk,
				reset 	=> reset,
				set 	=> set,
				d 		=> new_d,
				q 		=> q_out
			);

	new_d <= d_in xor (isTap and feedback);

end rtl;