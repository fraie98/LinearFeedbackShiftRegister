library IEEE;
use IEEE.std_logic_1164.all;

entity lfsr_dff_tap_c_tb is
end lfsr_dff_tap_c_tb;

architecture bhv of lfsr_dff_tap_c_tb is
	constant T_CLK   : time := 10 ns;
	constant T_RESET : time := 25 ns;

	-- SIGNALS
	signal clk_tb 		: std_logic := '0'; 	
	signal reset_tb 	: std_logic := '0';
	signal isTap_tb 	: std_logic;
	signal seed_tb		: std_logic_vector(1 downto 0);
	signal output_tb	: std_logic;
	signal end_sim 		: std_logic := '1';
	signal actual_state : std_logic_vector(1 downto 0);

	-- COMPONENT
	component lfsr is
	generic (Nbit : positive := 8);
	port(
			clock			:	in 	std_logic;
			reset 		:	in 	std_logic;
			--isTap		: 	in 	std_logic_vector(Nbit-2 downto 0):
			--seed		:	in 	std_logic_vector(Nbit-1 downto 0);
			isTap		:	in std_logic;
			seed		: 	in std_logic_vector(1 downto 0);
			outputBit	: 	out std_logic;
						-- debugging
			state		: out std_logic_vector(1 downto 0)
		);
	end component;

begin
	clk_tb <= (not(clk_tb) and end_sim) after T_CLK / 2;
	reset_tb <= '1' after T_RESET;

	test_lfsr : lfsr
	port map(	
			clock		=> clk_tb,
			reset 		=> reset_tb,
			isTap		=> isTap_tb,
			seed		=> seed_tb,
			outputBit	=> output_tb,
			state 		=> actual_state
		);

	dff_process : process(clk_tb,reset_tb)
	variable t : integer := 0;
	begin
		if(reset_tb='0') then
			t:=0;
			isTap_tb <= '0'; 	-- It's not a tap so it's a simple shift register
			seed_tb <= "01";
		elsif (rising_edge(clk_tb)) then
			case(t) is
					
				--when 10 => isTap_tb <= '1';

				when 20 => end_sim <= '0';

				when others => null;
			
			end case ;
			t:=t+1;
		end if;
	end process;

end bhv;