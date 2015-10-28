// Deliverable 3
module register32zero
(
  output reg[31:0] q,
  input[31:0] d,
  input wrenable,
  input clk
);

  initial begin
    q = 32'b00000000000000000000000000000000;
    $display("%b", q);
  end

endmodule
