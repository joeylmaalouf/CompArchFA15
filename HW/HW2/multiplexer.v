`define AND and #50
`define OR or #50
`define NOT not #50
`define XOR xor #50

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
  wire nA0, nA1;
  wire nA0andnA1, nA0andA1, A0andnA1, A0andA1;
  wire nA0andnA1andin0, nA0andA1andin1, A0andnA1andin2, A0andA1andin3;
  wire nai0, nai1, nai2, nai3;
  wire ai0andnai1, nai0andai1, ai2andnai3, nai2andai3;
  wire ai0xorai1, ai2xorai3;
  wire ai0xnorai1, ai2xnorai3;
  wire ai0xorai1andai0xnorai1, ai2xorai3andai2xnorai3;
  `NOT notgate0(nA0, address0);
  `NOT notgate1(nA1, address1);
  `AND andgate0(nA0andnA1, nA0, nA1);
  `AND andgate1(nA0andA1, nA0, address1);
  `AND andgate2(A0andnA1, address0, nA1);
  `AND andgate3(A0andA1, address0, address1);
  `AND andgate4(nA0andnA1andin0, nA0andnA1, in0);
  `AND andgate5(A0andnA1andin1, A0andnA1, in1);
  `AND andgate6(nA0andA1andin2, nA0andA1, in2);
  `AND andgate7(A0andA1andin3, A0andA1, in3);
  `XOR xorgate0(ai0xorai1, nA0andnA1andin0, nA0andA1andin2);
  `XOR xorgate1(ai2xorai3, A0andnA1andin1, A0andA1andin3);
  `XOR xorgate2(out, ai0xorai1, ai2xorai3);
  endmodule


module testMultiplexer;
  reg address0, address1;
  reg in0, in1, in2, in3;
  wire out;
  integer i;
  // behavioralMultiplexer multiplexer (out, address0, address1, in0, in1, in2, in3);
  structuralMultiplexer multiplexer (out, address0, address1, in0, in1, in2, in3);

  initial begin
    $dumpfile("multiplexer.vcd");
    $dumpvars(0, testMultiplexer);

    $display("Concise Table:");
    $display("A1 A0 | I0 I1 I2 I3 | O | Expected Output");
    address1 = 0; address0 = 0;
    $display(" %b  %b |  X  X  X  X | X | Input%d", address1, address0, 2 * address1 + 1 * address0);
    address1 = 0; address0 = 1;
    $display(" %b  %b |  X  X  X  X | X | Input%d", address1, address0, 2 * address1 + 1 * address0);
    address1 = 1; address0 = 0;
    $display(" %b  %b |  X  X  X  X | X | Input%d", address1, address0, 2 * address1 + 1 * address0);
    address1 = 1; address0 = 1;
    $display(" %b  %b |  X  X  X  X | X | Input%d", address1, address0, 2 * address1 + 1 * address0);
  	$display("Full Table:");
    $display("A1 A0 | I0 I1 I2 I3 | O | Expected Output");
    for (i = 0; i < 64; i = i + 1) begin
      // We have 6 bits to iterate through, so we can pull them from the numbers 0-63 (a total of 2^6 numbers)
      // Indexing an int takes the value from its bit representation (least significant bit first)! How cool is that?
      // I really just didn't want to have 64 of the same display line over and over.
      address1 = i[5];
      address0 = i[4];
      in0 = i[3];
      in1 = i[2];
      in2 = i[1];
      in3 = i[0];
      #1000
      $display(" %b  %b |  %b  %b  %b  %b | %b | Input%d", address1, address0, in0, in1, in2, in3, out, 2 * address1 + 1 * address0);
    end
  end
endmodule
