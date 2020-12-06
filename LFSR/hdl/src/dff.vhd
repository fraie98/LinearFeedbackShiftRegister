-- D Flip-Flop with Set/Reset
library ieee;
use ieee.std_logic_1164.all;

entity DFF is
	port(
			clk		:	in 	std_logic;
			reset 	:	in 	std_logic;
			set		: 	in 	std_logic;
			d 		:	in 	std_logic;
			q 		:	out std_logic
		);
	end DFF;


architecture rtl of DFF is
begin
	dff_p:process(reset,clk)
	begin
		if reset='0' then
			q <= set;
		elsif(rising_edge(clk)) then
			q <= d;
		end if;
	end process;
end rtl;