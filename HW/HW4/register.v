// single-bit D Flip-Flop with enable, positive clock edge triggered
module register
(
  output reg q,
  input d,
  input wrenable,
  input clk
);
  always @(posedge clk) begin
    if(wrenable) begin
      q = d;
    end
  end
endmodule
