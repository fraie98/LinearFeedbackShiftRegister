use STD.textio.all;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;

entity lfsr_wrapper_tb is
end lfsr_wrapper_tb;

architecture bhv of lfsr_wrapper_tb is
	
	file OUT_LFSR : text is out "fileout_wrapper.tv";

	constant Nbit : positive := 16;
	constant T_CLK   : time := 10 ns;
	constant T_RESET : time := 25 ns;

	-- SIGNALS
	signal clk_tb 		: std_logic := '0';
	signal reset_tb 	: std_logic := '1';
	signal seed_tb		: std_logic_vector(0 to 3);
	signal led_out_tb 	: std_logic_vector(0 to 3);
	signal end_sim		: std_logic := '1';
	signal yq_tb		:std_logic_vector(5 downto 0);

	-- COMPONENT
	component lfsr_wrapper is
	port(
			clk		:	in std_logic;
			reset	:	in std_logic;	
			seed	:	in std_logic_vector(0 to 3);
			led_out	:	out std_logic_vector(0 to 3);
			yq		:	out std_logic_vector(5 downto 0)
		);
	end component;

begin
	clk_tb <= (not(clk_tb) and end_sim) after T_CLK / 2;
	reset_tb <= '0' after T_RESET;

	test_lfsr_wrapper : lfsr_wrapper
	port map(	
			clk		=> clk_tb,
			reset 	=> reset_tb,
			seed	=> seed_tb,
			led_out	=> led_out_tb,
			yq 		=> yq_tb
		);

	lfsr_test_process : process(clk_tb,reset_tb)
	variable t : integer := 0;
	begin
		if(reset_tb='1') then
			t:=0;
			seed_tb <= "0000";		
		elsif (rising_edge(clk_tb)) then
			case(t) is
				when 65535 => end_sim <= '0';
				when others => null;
			end case ;
			t:=t+1;
		end if;
	end process;

	write_file : process
	variable BUF : line;
	begin
		loop
			wait on clk_tb until clk_tb='1';
				if reset_tb='0' then
					WRITE(BUF,yq_tb(0));
					WRITEline(OUT_LFSR,BUF);
				end if;
		end loop;
	end process;

end bhv;