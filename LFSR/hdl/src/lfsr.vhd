-- LinearFeedbackShiftRegister
library ieee;
use ieee.std_logic_1164.all;

entity lfsr is
	generic (Nbit : positive := 16);
	port(
			clock		:	in 	std_logic;
			reset 		:	in 	std_logic;
			isTap		: 	in 	std_logic_vector(0 to Nbit-2);
			seed		:	in 	std_logic_vector(0 to Nbit-1);
			outputBit	: 	out std_logic;
			-- Debugging: it's necessary to stop the simulation in ModelSim. But can be useful also in normal application.
			state		: 	out std_logic_vector(Nbit-1 downto 0)
		);
	end lfsr;


architecture rtl of lfsr is
	component dff_tap_circuit is
	port(
			clk			:	in 	std_logic;
			reset 		:	in 	std_logic;
			set			: 	in 	std_logic; 	-- initialization input (necessary for seed initialization)
			d_in		:	in 	std_logic;	
			isTap		:	in 	std_logic;	-- it indicates if the input must be changed (it does if the previous ff is a tap)
			feedback	:	in 	std_logic;  -- it is the feedback bit (the N-1 bit of the LFSR)
			q_out		:	out std_logic
		);
	end component;

	signal lastBit : std_logic := '0';					-- Last bit of the LFSR, it is the feedback bit and also the output
	signal intercon : std_logic_vector(0 to Nbit-2);	-- Interconnections among flip-flops
begin
	GEN:for i in 0 to Nbit-1 generate
		FIRST: 	if i = 0 generate
					FF1 : dff_tap_circuit port map(clock, reset, seed(i), lastBit,'0', lastBit,intercon(i));
				end generate FIRST;
		INTERNAL:	if (i>=1) and (i<Nbit-1) generate
						FFI : dff_tap_circuit port map(clock, reset, seed(i), intercon(i-1), isTap(i-1), lastBit, intercon(i));
					end generate INTERNAL;
		LAST:	if i=Nbit-1 generate
					FFL : dff_tap_circuit port map(clock, reset, seed(i), intercon(i-1), isTap(i-1), lastBit, lastBit);
				end generate LAST;
	end generate GEN;

	state <= intercon & lastBit;
	outputBit <= lastBit;
end rtl;