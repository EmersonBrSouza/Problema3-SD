
module main (
	clk_clk,
	arbitro_0_conduit_end_beginbursttransfer,
	arbitro_0_conduit_end_writeresponsevalid_n,
	button_exit_external_connection_export,
	button_enter_external_connection_export,
	button_down_external_connection_export,
	button_up_external_connection_export,
	lcd_output_external_RS,
	lcd_output_external_RW,
	lcd_output_external_data,
	lcd_output_external_E,
	led_b_external_connection_export,
	led_g_external_connection_export,
	led_r_external_connection_export,
	uart_main_external_connection_rxd,
	uart_main_external_connection_txd);	

	input		clk_clk;
	input		arbitro_0_conduit_end_beginbursttransfer;
	output		arbitro_0_conduit_end_writeresponsevalid_n;
	input		button_exit_external_connection_export;
	output		button_enter_external_connection_export;
	input		button_down_external_connection_export;
	input		button_up_external_connection_export;
	output		lcd_output_external_RS;
	output		lcd_output_external_RW;
	inout	[7:0]	lcd_output_external_data;
	output		lcd_output_external_E;
	output		led_b_external_connection_export;
	output		led_g_external_connection_export;
	output		led_r_external_connection_export;
	input		uart_main_external_connection_rxd;
	output		uart_main_external_connection_txd;
endmodule
