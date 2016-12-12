	component nios_cpu is
		port (
			clk_clk          : in  std_logic                     := 'X';             -- clk
			led_green_export : out std_logic_vector(7 downto 0);                     -- export
			led_red_export   : out std_logic_vector(17 downto 0);                    -- export
			reset_reset_n    : in  std_logic                     := 'X';             -- reset_n
			switches_export  : in  std_logic_vector(17 downto 0) := (others => 'X'); -- export
			push_btns_export : in  std_logic_vector(3 downto 0)  := (others => 'X')  -- export
		);
	end component nios_cpu;

	u0 : component nios_cpu
		port map (
			clk_clk          => CONNECTED_TO_clk_clk,          --       clk.clk
			led_green_export => CONNECTED_TO_led_green_export, -- led_green.export
			led_red_export   => CONNECTED_TO_led_red_export,   --   led_red.export
			reset_reset_n    => CONNECTED_TO_reset_reset_n,    --     reset.reset_n
			switches_export  => CONNECTED_TO_switches_export,  --  switches.export
			push_btns_export => CONNECTED_TO_push_btns_export  -- push_btns.export
		);

