library IEEE;
use IEEE.std_logic_1164.all;

entity dff_tap_circuit_tb is
end dff_tap_circuit_tb;

architecture bhv of dff_tap_circuit_tb is
	constant T_CLK   : time := 10 ns;
	constant T_RESET : time := 25 ns;

	-- SIGNALS
	signal clk_tb 		: std_logic := '0'; 	
	signal reset_tb 	: std_logic := '0';
	signal d_tb 		: std_logic;
	signal q_tb 		: std_logic;
	signal set_tb 		: std_logic;
	signal isTap_tb 	: std_logic;
	signal feedback_tb	: std_logic;
	signal end_sim 		: std_logic := '1';

	-- COMPONENT
	component dff_tap_circuit is
	generic (Nbit : positive := 8);
	port(
			clk			:	in 	std_logic;
			reset 		:	in 	std_logic;
			set			: 	in 	std_logic;  
			d_in		:	in 	std_logic;	
			isTap		:	in 	std_logic;
			feedback	:	in 	std_logic;  
			q_out		:	out std_logic
		);
	end component;

begin
	clk_tb <= (not(clk_tb) and end_sim) after T_CLK / 2;
	reset_tb <= '1' after T_RESET;

	test_dff : dff_tap_circuit
	port map(
			clk 		=> clk_tb,
			reset  		=> reset_tb,
			d_in 		=> d_tb,
			q_out		=> q_tb,
			set			=> set_tb,	
			isTap 		=> isTap_tb,
			feedback 	=> feedback_tb
		);

	dff_process : process(clk_tb,reset_tb)
	variable t : integer := 0;
	begin
		if(reset_tb='0') then
			t:=0;
			set_tb <= '1';
			isTap_tb <= '0'; 	-- It's not a tap so it's a simple shift register
			feedback_tb <= '1';
			d_tb <= '0';
		elsif (rising_edge(clk_tb)) then
			case(t) is
					
				when 10 => set_tb <= '0'; isTap_tb <= '1'; 

				when 20 => end_sim <= '0';

				when others => null;
			
			end case ;
			t:=t+1;
		end if;
	end process;

end bhv;