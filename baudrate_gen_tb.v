`timescale 10ps/10ps

module baudrate_gen_tb();

reg clk;

wire tx_clk, rx_clk;

integer counter = 0;
integer tx_pulses = 0;
integer rx_pulses = 0;

baudrate_generator baud_gen(
	.clk(clk),
	.tx_clk(tx_clk),
	.rx_clk(rx_clk)
);

initial begin
	clk = 0;
end

always @(posedge clk) begin
	counter = counter + 1;
	if (tx_pulses > 1 && rx_pulses > 1) begin
		$stop;
	end
end

always @(posedge tx_clk) begin
	tx_pulses <= tx_pulses + 1;
	#20 $display("TX Clock pulse after %d clock pulses", counter);
end

always @(posedge rx_clk) begin
	rx_pulses <= rx_pulses + 1;
	$display("RX Clock pulse after %d clock pulses", counter);
end

always #1 clk = ~clk;

endmodule
