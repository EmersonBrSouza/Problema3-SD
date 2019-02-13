`timescale 10ps/10ps

module uart_rx_tb();

reg rx, rdy_clr, clk, clk_en;

wire rdy;
wire [7:0] data;
integer bitpos = 0;

uart_rx uart_rx(
	.rx(rx),
	.rdy_clr(rdy_clr),
	.clk(clk),
	.clk_en(clk_en),
	.rdy(rdy),
	.data(data)
);


initial begin
	rx = 0;
	rdy_clr = 0;
	clk = 0;
	clk_en = 0;
	bitpos = 0;
	
	$display("Initial value for rdy_clr: %b", rdy_clr);
	$display("Initial value for clk: %b", clk);
	$display("Initial value for clk_en: %b", clk_en);
	$display("Initial value for rx: %b", rx);
	
	$display("Starting Test");
end

always @(posedge clk) begin
	rx <= 1;
end

always @(posedge rdy) begin
	#20 $display("Data: %b", data);
	$stop;
end

always #1 clk = ~clk;
always #1 clk_en = ~clk_en;

endmodule
