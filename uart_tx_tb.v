`timescale 10ps/10ps

module uart_tx_tb();

reg [7:0] data_input;
reg wr_en, clk, clk_en;

wire tx, tx_busy;

integer counter = -1;

uart_tx uart_tx(
	.data_input(data_input),
	.wr_en(wr_en),
	.clk(clk),
	.clk_en(clk_en),
	.tx(tx),
	.tx_busy(tx_busy)

);

initial begin
	$display("Setting initial state");
	
	data_input = 8'b0;
	wr_en = 0;
	clk = 0;
	clk_en = 0;

	$display("Initial value for data_input: %b", data_input);
	$display("Initial value for wr_en: %b", wr_en);
	$display("Initial value for clk: %b", clk);
	$display("Initial value for clk_en: %b", clk_en);
	$display("Initial value for tx: %b", tx);
	$display("Initial value for tx_busy: %b", tx_busy);
	
	$display("Starting Test");
end

always @(posedge clk) begin
	if (counter < 1) begin
		data_input <= 8'd97;
		wr_en = 1;	
	end
	else begin
		$stop;
	end
	
	#2 $display("Output TX: %b", tx);

end

always @(posedge tx_busy) begin
	$display("Transmitindo: %b", data_input);
end

always @(negedge tx_busy) begin
	counter <= counter + 1;
end

always #1 clk = ~clk;
always #1 clk_en = ~clk_en;

endmodule
