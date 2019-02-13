`timescale 10ps/10ps

module tb_state_WAIT_CHECKSUM_TO_WAIT_VERIFY_CHECKSUM();

reg clk,reset,start, tx_busy, rdy;
reg [7:0] rxdata;
reg [31:0] dataa, datab;

wire [7:0] txdata;
wire [31:0] result;
wire done, wr_en, rdy_clr;
wire [4:0] state;

maquina maquina(
	.clk(clk),
	.rdy(rdy),
	.reset(reset),
	.wr_en(wr_en),
	.tx_busy(tx_busy),
	.rdy_clr(rdy_clr),
	.dataa(dataa),
	.datab(datab),
	.result(result),
	.done(done),
	.rxdata(rxdata),
	.txdata(txdata),
	.state(state)
);

initial begin
	rxdata = 0;
	clk = 0;
	reset = 0;
	start = 0;
	dataa = 0;
	datab = 0;
	tx_busy = 1;
	rdy = 0;
end


always @(posedge clk) begin
	dataa <= 8'd97;
	#10 tx_busy = 0;
	#20 rdy = 1;
	#20 rxdata = 0;

	if(state == 4) begin
		#2 $display("State changed");
		$stop;
	end
end

always #1 clk = ~clk;

endmodule