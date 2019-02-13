	component main is
		port (
			clk_clk                                    : in    std_logic                    := 'X';             -- clk
			arbitro_0_conduit_end_beginbursttransfer   : in    std_logic                    := 'X';             -- beginbursttransfer
			arbitro_0_conduit_end_writeresponsevalid_n : out   std_logic;                                       -- writeresponsevalid_n
			button_exit_external_connection_export     : in    std_logic                    := 'X';             -- export
			button_enter_external_connection_export    : out   std_logic;                                       -- export
			button_down_external_connection_export     : in    std_logic                    := 'X';             -- export
			button_up_external_connection_export       : in    std_logic                    := 'X';             -- export
			lcd_output_external_RS                     : out   std_logic;                                       -- RS
			lcd_output_external_RW                     : out   std_logic;                                       -- RW
			lcd_output_external_data                   : inout std_logic_vector(7 downto 0) := (others => 'X'); -- data
			lcd_output_external_E                      : out   std_logic;                                       -- E
			led_b_external_connection_export           : out   std_logic;                                       -- export
			led_g_external_connection_export           : out   std_logic;                                       -- export
			led_r_external_connection_export           : out   std_logic;                                       -- export
			uart_main_external_connection_rxd          : in    std_logic                    := 'X';             -- rxd
			uart_main_external_connection_txd          : out   std_logic                                        -- txd
		);
	end component main;

	u0 : component main
		port map (
			clk_clk                                    => CONNECTED_TO_clk_clk,                                    --                              clk.clk
			arbitro_0_conduit_end_beginbursttransfer   => CONNECTED_TO_arbitro_0_conduit_end_beginbursttransfer,   --            arbitro_0_conduit_end.beginbursttransfer
			arbitro_0_conduit_end_writeresponsevalid_n => CONNECTED_TO_arbitro_0_conduit_end_writeresponsevalid_n, --                                 .writeresponsevalid_n
			button_exit_external_connection_export     => CONNECTED_TO_button_exit_external_connection_export,     --  button_exit_external_connection.export
			button_enter_external_connection_export    => CONNECTED_TO_button_enter_external_connection_export,    -- button_enter_external_connection.export
			button_down_external_connection_export     => CONNECTED_TO_button_down_external_connection_export,     --  button_down_external_connection.export
			button_up_external_connection_export       => CONNECTED_TO_button_up_external_connection_export,       --    button_up_external_connection.export
			lcd_output_external_RS                     => CONNECTED_TO_lcd_output_external_RS,                     --              lcd_output_external.RS
			lcd_output_external_RW                     => CONNECTED_TO_lcd_output_external_RW,                     --                                 .RW
			lcd_output_external_data                   => CONNECTED_TO_lcd_output_external_data,                   --                                 .data
			lcd_output_external_E                      => CONNECTED_TO_lcd_output_external_E,                      --                                 .E
			led_b_external_connection_export           => CONNECTED_TO_led_b_external_connection_export,           --        led_b_external_connection.export
			led_g_external_connection_export           => CONNECTED_TO_led_g_external_connection_export,           --        led_g_external_connection.export
			led_r_external_connection_export           => CONNECTED_TO_led_r_external_connection_export,           --        led_r_external_connection.export
			uart_main_external_connection_rxd          => CONNECTED_TO_uart_main_external_connection_rxd,          --    uart_main_external_connection.rxd
			uart_main_external_connection_txd          => CONNECTED_TO_uart_main_external_connection_txd           --                                 .txd
		);

