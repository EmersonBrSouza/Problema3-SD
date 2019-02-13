module uart(
	input rx,
	input clk,
	input rdy_clr,
	input wr_en,
	input [7:0] data_send,
	output rdy,
	output tx,
	output tx_busy,
	output [7:0] received_data 
);


wire rx_clk, tx_clk;

baudrate_generator baud_gen(
	.clk(clk),
	.rx_clk(rx_clk),
	.tx_clk(tx_clk)
);

uart_tx transmitter (
	.tx(tx),
	.clk(clk),
	.wr_en(wr_en),
	.clk_en(tx_clk),
	.tx_busy(tx_busy),
	.data_input(data_send)	
);

uart_rx receiver (
	.rx(rx),
	.clk(clk),
	.rdy_clr(rdy_clr),
	.clk_en(rx_clk),
	.rdy(rdy),
	.data(received_data)	
);
endmodule
