// Deliverable 4
module mux32to1by1
(
  output reg out,
  input[4:0] address,
  input[31:0] inputs
);
  always @(address or inputs) begin
    assign out = inputs[address];
  end
endmodule
