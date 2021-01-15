library ieee; 
use ieee.std_logic_1164.all;

ENTITY LFSR_16_bit_tb is
END;

ARCHITECTURE RTL OF LFSR_16_bit_tb is

constant c_CLOCK_PERIOD : time := 10 ns; 

signal CLK_IN	: STD_LOGIC := '1';
signal reset_n  : STD_LOGIC := '0';
signal sync_reset   : STD_LOGIC := '0';
signal seed	: STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
signal EN	: STD_LOGIC := '0';
signal LFSR_OUT : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');


COMPONENT LFSR_16_bit
PORT(
	CLK_IN		: IN STD_LOGIC;
	reset_n		: IN STD_LOGIC;
	sync_reset	: IN STD_LOGIC;
	seed		: IN STD_LOGIC_VECTOR(15 downto 0);
	EN		: IN STD_LOGIC;
	LFSR_OUT	: OUT STD_LOGIC_VECTOR(15 downto 0)
	);
END COMPONENT;

BEGIN

DUT: LFSR_16_bit
port map(

	CLK_IN		=> CLK_IN,
	reset_n		=> reset_n,
	sync_reset	=> sync_reset,
	seed		=> seed,
	EN		=> EN,	
	LFSR_OUT	=> LFSR_OUT	
);

--clock generation
p_CLK_GEN : process is
    begin
      wait for c_CLOCK_PERIOD/2;
      CLK_IN <= not CLK_IN;
end process p_CLK_GEN;

--reset release
process                               
begin
    wait for 10*c_CLOCK_PERIOD;
    reset_n <= '1';
    wait for 2 sec;
end process;

--Enable LFSR module and load the seed value.
--Reset to different seed value after 1000 cycles.
process                               
begin
    wait for 20*c_CLOCK_PERIOD;
    EN <= '1';
    seed <= x"AAAA";
    wait for 1000*c_CLOCK_PERIOD;
    seed <= x"BBBB";
    sync_reset <= '1';
    wait for c_CLOCK_PERIOD;
    sync_reset <= '0';
    wait for 2 sec;
end process;



END RTL;


