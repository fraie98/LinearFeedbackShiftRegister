-- D Flip-Flop with Set/Reset
library ieee;
use ieee.std_logic_1164.all;

entity dff is
	port(
			clk		:	in 	std_logic;
			reset 	:	in 	std_logic;
			set 	:	in 	std_logic;
			d 		:	in 	std_logic;
			q 		:	out std_logic
		);
	end dff;


architecture rtl of dff is
begin
	dff_p:process(reset,clk)
	begin
		
		--if reset='0' then 	 -- Standard Reset Polarity 
		if reset='1' then  -- ZyBo Board Reset Polarity
			q <= set;
		elsif(rising_edge(clk)) then
			q <= d;
		end if;
	end process;
end rtl;