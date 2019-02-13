`timescale 1ps/1ps

module uart_tb();

reg [7:0] data = 0;
reg clk = 0;
reg enable = 0;

wire tx_busy;
wire rdy;
wire [7:0] rxdata;

wire loopback;
reg rdy_clr = 0;

uart test_uart(.data_send(data),
	       .wr_en(enable),
	       .clk(clk),
	       .tx(loopback),
	       .tx_busy(tx_busy),
	       .rx(loopback),
	       .rdy(rdy),
	       .rdy_clr(rdy_clr),
	       .received_data(rxdata));

initial begin
	enable <= 1'b1;
	#2 enable <= 1'b0;
end

always begin
	#1 clk = ~clk;
end

always @(posedge rdy) begin
	#2 rdy_clr <= 1;
	#2 rdy_clr <= 0;
	if (rxdata != data) begin
		$display("FAIL: rx data %x does not match tx %x", rxdata, data);
		$stop;
	end else begin
		if (rxdata == 8'hff) begin
			$display("SUCCESS: all bytes verified");
			$stop;
		end
		data <= data + 1'b1;
		enable <= 1'b1;
		#2 enable <= 1'b0;
	end
end

endmodule
