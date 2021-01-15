library ieee; 
use ieee.std_logic_1164.all;

ENTITY LFSR_16_bit is
	
	PORT(
		CLK_IN		: IN STD_LOGIC;
		reset_n		: IN STD_LOGIC;
		sync_reset	: IN STD_LOGIC; --resets the output to the seed value.
		seed			: IN STD_LOGIC_VECTOR(15 downto 0);
		EN				: IN STD_LOGIC;
		LFSR_OUT		: OUT STD_LOGIC_VECTOR(15 downto 0)
	);
END;

ARCHITECTURE RTL OF LFSR_16_bit IS 

signal r_LFSR	: STD_LOGIC_VECTOR(16 downto 1) := (others => '0');

BEGIN

LFSR_proc: process(CLK_IN,reset_n)
begin
	if (reset_n = '0') then
		r_LFSR <= (others => '1');
		
	elsif(rising_edge(CLK_IN)) then
		if(sync_reset = '1') then
			r_LFSR <= seed;
		elsif(EN = '1') then
			r_LFSR(16) <= r_LFSR(1);
			r_LFSR(15) <= r_LFSR(16);
			r_LFSR(14) <= r_LFSR(15) xor r_LFSR(1);
			r_LFSR(13) <= r_LFSR(14) xor r_LFSR(1);
			r_LFSR(12) <= r_LFSR(13);
			r_LFSR(11) <= r_LFSR(12) xor r_LFSR(1);
			r_LFSR(10) <= r_LFSR(11);
			r_LFSR(9)  <= r_LFSR(10);
			r_LFSR(8)  <= r_LFSR(9);
			r_LFSR(7)  <= r_LFSR(8);
			r_LFSR(6)  <= r_LFSR(7);
			r_LFSR(5)  <= r_LFSR(6);
			r_LFSR(4)  <= r_LFSR(5);
			r_LFSR(3)  <= r_LFSR(4);
			r_LFSR(2)  <= r_LFSR(3);
			r_LFSR(1)  <= r_LFSR(2);
		end if;	
			
	end if;
end process LFSR_proc;

LFSR_OUT <= r_LFSR(16 downto 1);
END RTL;