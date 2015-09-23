`define AND and #50
`define OR or #50
`define NOT not #50

module behavioralMultiplexer(out, address0, address1, in0, in1, in2, in3);
  output out;
  input address0, address1;
  input in0, in1, in2, in3;
  wire[3:0] inputs = {in3, in2, in1, in0};
  wire[1:0] address = {address1, address0};
  assign out = inputs[address];
endmodule

module structuralMultiplexer(out, address0, address1, in0, in1, in2, in3);
  output out;
  input address0, address1;
  input in0, in1, in2, in3;
  // Your multiplexer code here
endmodule


module testMultiplexer;
  reg address0, address1;
  reg in0, in1, in2, in3;
  wire out;
  integer i;
  behavioralMultiplexer multiplexer (out, address0, address1, in0, in1, in2, in3);
  // structuralMultiplexer multiplexer (out, address0, address1, in0, in1, in2, in3);

  initial begin
    $display("A1 A0 | I0 I1 I2 I3 | O | Expected Output");
    for (i = 0; i < 64; i = i + 1) begin
      address1 = i[5];
      address0 = i[4];
      in0 = i[3];
      in1 = i[2];
      in2 = i[1];
      in3 = i[0];
      #1000
      $display(" %b  %b |  %b  %b  %b  %b | %b | Input%d", address1, address0, in0, in1, in2, in3, out, 2 * i[5] + 1 * i[4]);
    end
  end
endmodule
