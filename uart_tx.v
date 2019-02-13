module uart_tx(
	input wire [7:0] data_input,
	input wire wr_en,
	input wire clk,
	input wire clk_en,
	output reg tx,
	output reg tx_busy
);

initial begin
	 tx = 1'b1;
end

parameter STATE_IDLE	= 2'b00;
parameter STATE_START	= 2'b01;
parameter STATE_DATA	= 2'b10;
parameter STATE_STOP	= 2'b11;

reg [7:0] data = 8'h00;
reg [2:0] bitpos = 3'h0;
reg [1:0] state = STATE_IDLE;

always @(posedge clk) begin
	case (state)
		STATE_IDLE: begin
			if (wr_en) begin
				state <= STATE_START;
				data <= data_input;
				bitpos <= 3'h0;
			end
		end
		STATE_START: begin
			if (clk_en) begin
				tx <= 1'b0;
				state <= STATE_DATA;
			end
		end
		STATE_DATA: begin
			if (clk_en) begin
				if (bitpos == 3'h7) begin
					state <= STATE_STOP;
				end
				else begin
					bitpos <= bitpos + 3'h1;
				end
				tx <= data[bitpos];
			end
		end
		STATE_STOP: begin
			if (clk_en) begin
				tx <= 1'b1;
				state <= STATE_IDLE;
			end
		end
		default: begin
			tx <= 1'b1;
			state <= STATE_IDLE;
		end
	endcase
end

always @(posedge clk) begin
	case (state)
		STATE_IDLE: begin
			tx_busy <= 0;
		end
		default: begin
			tx_busy <= 1;
		end
	endcase
end

// assign tx_busy = (state != STATE_IDLE);

endmodule
