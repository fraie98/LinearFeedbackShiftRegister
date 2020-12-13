use STD.textio.all;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;

entity lfsr_tb is
end lfsr_tb;

architecture bhv of lfsr_tb is
	
	file OUT_LFSR : text is out "fileout.tv";

	constant Nbit : positive := 16;
	constant T_CLK   : time := 10 ns;
	constant T_RESET : time := 25 ns;

	-- SIGNALS
	signal clk_tb 		: std_logic := '0'; 	
	signal reset_tb 	: std_logic := '0';
	signal isTap_tb 	: std_logic_vector(0 to Nbit-2);
	signal seed_tb		: std_logic_vector(0 to Nbit-1);
	signal output_tb	: std_logic;
	signal end_sim 		: std_logic := '1';
	signal actual_state : std_logic_vector(Nbit-1 downto 0);

	-- COMPONENT
	component lfsr is
	port(
			clock		:	in 	std_logic;
			reset 		:	in 	std_logic;
			isTap		: 	in 	std_logic_vector(0 to Nbit-2);
			seed		:	in 	std_logic_vector(0 to Nbit-1);
			outputBit	: 	out std_logic;
			-- debugging
			state		: out std_logic_vector(Nbit-1 downto 0)
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
			--isTap_tb <= "000000000000000"; 	-- It's not a tap so it's a simple shift register
			isTap_tb <= "000000000010110";		-- 1 + x^11 + x^13 + x^14 + x^16 -> taps are 10 12 13
			seed_tb <= "0000101011000110";
		elsif (rising_edge(clk_tb)) then
			case(t) is

				when 20 => end_sim <= '0';

				when others => null;
			
			end case ;
			t:=t+1;
		end if;
	end process;

	write_file : process
	variable BUF : line;
	begin
		loop
			wait on clk_tb;
			--WRITE(BUF,output_tb,right,10);
			WRITE(BUF,output_tb);
			WRITEline(OUT_LFSR,BUF);
		end loop;
	end process;

end bhv;