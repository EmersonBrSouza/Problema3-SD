module maquina (
	input clk,
	input rdy,
	input reset,
	input tx_busy,
	input [7:0] rxdata,
	input [31:0] dataa,
	input [31:0] datab,
	output reg done,
	output reg wr_en,
	output reg rdy_clr,
	output reg [7:0] txdata,
	output reg [31:0] result,
	output reg [4:0] state
);

parameter IDLE = 0, SEND_REQUEST = 1, WAIT_DATA = 2, CLEAR_READY_DATA = 3, WAIT_CHECKSUM = 4, CLEAR_READY_CHECKSUM = 5, VERIFY_CHECKSUM = 6, SEND_RESULT = 7, ALARM = 8, DISABLE_ALARM = 9, CLEAR_REGS = 10;
//reg [4:0] state;

reg [7:0] received_byte;
reg [7:0] received_checksum;
reg [7:0] byte_alarm;
reg [7:0] xorResult;

initial begin
	state = IDLE;
	byte_alarm = 8'h0;
	xorResult = 8'h0;
	received_byte = 8'h0;
	received_checksum = 8'h0;
end

always @(posedge clk) begin
	if (reset) begin
		state <= IDLE;
	end
	else begin
		case(state)
			IDLE: begin
				if (dataa) begin
					state <= SEND_REQUEST;
				end
			end
			SEND_REQUEST: begin
				if (tx_busy == 0) begin
					state <= WAIT_DATA;
				end
			end
			WAIT_DATA: begin
				if (rdy) begin
					state <= CLEAR_READY_DATA;
				end
			end
			CLEAR_READY_DATA: begin
				state <= WAIT_CHECKSUM;
			end
			WAIT_CHECKSUM: begin
				if (rdy) begin
					state <= CLEAR_READY_CHECKSUM;
				end
			end
			CLEAR_READY_CHECKSUM: begin
				state <= VERIFY_CHECKSUM;
			end
			VERIFY_CHECKSUM: begin
				
				xorResult <= received_checksum ^ 00110111;
				
				if (xorResult == received_byte) begin
					state <= SEND_RESULT;
				end
				else if (xorResult == byte_alarm) begin
					state <= ALARM;
				end
				else begin
					state <= WAIT_DATA;
				end
			end
			SEND_RESULT: begin
				state <= CLEAR_REGS;
			end
			ALARM: begin
				if (dataa !== byte_alarm) begin
					state <= ALARM;
				end
			end
			DISABLE_ALARM: begin
				if(!tx_busy) begin
					state <= CLEAR_REGS;
				end
			end
			CLEAR_REGS: begin
//				byte_alarm <= 8'h0;
//				xorResult <= 8'h0;
//				received_byte <= 8'h0;
//				received_checksum <= 8'h0;
				state <= IDLE;
			end
		endcase
	end
end


always @(state) begin
	case(state)
		IDLE: begin
			if (dataa) begin
				wr_en <= 0;
				rdy_clr <= 0;
			end
			else begin
				wr_en <= 0;
				rdy_clr <= 1;
			end
		end
		SEND_REQUEST: begin
			if (dataa) begin
				wr_en <= 1;
				rdy_clr <= 1;
				txdata <= dataa[7:0];
			end
			else begin
				wr_en <= 1;
				rdy_clr <= 1;
			end
		end
		WAIT_DATA: begin
			wr_en <= 0;
			rdy_clr <= 0;
		end
		CLEAR_READY_DATA: begin
			wr_en <= 0;
			rdy_clr <= 1;
		end
		WAIT_CHECKSUM: begin
			wr_en <= 0;
			rdy_clr <= 0;
		end
		CLEAR_READY_CHECKSUM: begin
			wr_en <= 0;
			rdy_clr <= 1;
		end
		VERIFY_CHECKSUM: begin
			wr_en <= 0;
			rdy_clr <= 1;
		end
		SEND_RESULT: begin
			wr_en <= 0;
			rdy_clr <= 1;
			result <= received_byte;
			done <= 1'b1;
		end
		ALARM: begin
			wr_en <= 0;
			rdy_clr <= 1;
			result <= 32'b11111111111111111111111111111111;
			done <= 1'b1;
		end
		DISABLE_ALARM: begin
			wr_en <= 0;
			rdy_clr <= 1;
		end
		CLEAR_REGS: begin
			wr_en <= 0;
			rdy_clr <= 1;
		end
	endcase
end
endmodule
