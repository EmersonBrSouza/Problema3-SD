	main u0 (
		.clk_clk                                    (<connected-to-clk_clk>),                                    //                              clk.clk
		.arbitro_0_conduit_end_beginbursttransfer   (<connected-to-arbitro_0_conduit_end_beginbursttransfer>),   //            arbitro_0_conduit_end.beginbursttransfer
		.arbitro_0_conduit_end_writeresponsevalid_n (<connected-to-arbitro_0_conduit_end_writeresponsevalid_n>), //                                 .writeresponsevalid_n
		.button_exit_external_connection_export     (<connected-to-button_exit_external_connection_export>),     //  button_exit_external_connection.export
		.button_enter_external_connection_export    (<connected-to-button_enter_external_connection_export>),    // button_enter_external_connection.export
		.button_down_external_connection_export     (<connected-to-button_down_external_connection_export>),     //  button_down_external_connection.export
		.button_up_external_connection_export       (<connected-to-button_up_external_connection_export>),       //    button_up_external_connection.export
		.lcd_output_external_RS                     (<connected-to-lcd_output_external_RS>),                     //              lcd_output_external.RS
		.lcd_output_external_RW                     (<connected-to-lcd_output_external_RW>),                     //                                 .RW
		.lcd_output_external_data                   (<connected-to-lcd_output_external_data>),                   //                                 .data
		.lcd_output_external_E                      (<connected-to-lcd_output_external_E>),                      //                                 .E
		.led_b_external_connection_export           (<connected-to-led_b_external_connection_export>),           //        led_b_external_connection.export
		.led_g_external_connection_export           (<connected-to-led_g_external_connection_export>),           //        led_g_external_connection.export
		.led_r_external_connection_export           (<connected-to-led_r_external_connection_export>),           //        led_r_external_connection.export
		.uart_main_external_connection_rxd          (<connected-to-uart_main_external_connection_rxd>),          //    uart_main_external_connection.rxd
		.uart_main_external_connection_txd          (<connected-to-uart_main_external_connection_txd>)           //                                 .txd
	);

