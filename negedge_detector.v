module negedge_detector ( input signal,
                      input clk,
                      output edge_n);
reg signal_delay;                          

always @ (posedge clk) begin
 signal_delay <= signal;
end

assign edge_n = ~signal & ~signal_delay;
           
endmodule