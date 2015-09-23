`define AND and #50
`define OR or #50
`define NOT not #50
`define XOR xor #50

module behavioralFullAdder(sum, carryout, a, b, carryin);
  output sum, carryout;
  input a, b, carryin;
  assign {carryout, sum} = a + b + carryin;
endmodule

module structuralFullAdder(out, carryout, a, b, carryin);
  output out, carryout;
  input a, b, carryin;
  wire AxorB, AandB, XandC;
  `XOR xorgate0(AxorB, a, b);
  `XOR xorgate1(out, AxorB, carryin);
  `AND andgate0(AandB, a, b);
  `AND andgate1(XandC, AxorB, carryin);
  `OR orgate0(carryout, AandB, XandC);
endmodule

module testFullAdder;
  reg a, b, carryin;
  wire sum, carryout;
  // behavioralFullAdder adder (sum, carryout, a, b, carryin);
  structuralFullAdder adder (sum, carryout, a, b, carryin);

  initial begin
    $display("A B Ci | Co S | Expected Output");
    a = 0; b = 0; carryin = 0; #1000
    $display("%b %b  %b |  %b %b | Both False", a, b, carryin, carryout, sum);
    a = 0; b = 1; carryin = 0; #1000
    $display("%b %b  %b |  %b %b | Sum True", a, b, carryin, carryout, sum);
    a = 1; b = 0; carryin = 0; #1000
    $display("%b %b  %b |  %b %b | Sum True", a, b, carryin, carryout, sum);
    a = 1; b = 1; carryin = 0; #1000
    $display("%b %b  %b |  %b %b | CarryOut True", a, b, carryin, carryout, sum);
    a = 0; b = 0; carryin = 1; #1000
    $display("%b %b  %b |  %b %b | Sum True", a, b, carryin, carryout, sum);
    a = 0; b = 1; carryin = 1; #1000
    $display("%b %b  %b |  %b %b | CarryOut True", a, b, carryin, carryout, sum);
    a = 1; b = 0; carryin = 1; #1000
    $display("%b %b  %b |  %b %b | CarryOut True", a, b, carryin, carryout, sum);
    a = 1; b = 1; carryin = 1; #1000
    $display("%b %b  %b |  %b %b | Both True", a, b, carryin, carryout, sum);
  end
endmodule
