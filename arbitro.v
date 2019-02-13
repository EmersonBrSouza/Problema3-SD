module arbitro (
	input rx,
	input clk,
	input reset,
	input start,
	input [31:0] dataa,
	input [31:0] datab,
	output [31:0] result,
	output done,
	output tx
);


wire rdy, tx_busy, wr_en, rdy_clr, tx_busy_detected;

wire [7:0] rxdata, txdata;

maquina maquina (
	.clk(clk),
	.reset(reset),
	.rdy(rdy),
	.wr_en(wr_en),
	.rdy_clr(rdy_clr),
	.tx_busy(tx_busy_detected),
	.txdata(txdata),
	.dataa(dataa),
	.datab(datab),
	.result(result),
	.done(done)
);

uart uart(
	.rx(rx),
	.tx(tx),
	.clk(clk),
	.rdy(rdy),
	.wr_en(wr_en),
	.tx_busy(tx_busy),
	.rdy_clr(rdy_clr),
	.data_send(txdata),
	.received_data(rxdata)
);

negedge_detector detector(
	.signal(tx_busy),
	.clk(clk),
	.edge_n(tx_busy_detected)
);

endmodule
