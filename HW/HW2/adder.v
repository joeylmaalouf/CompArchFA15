`define AND and #50
`define OR or #50
`define NOT not #50

module behavioralFullAdder(sum, carryout, a, b, carryin);
  output sum, carryout;
  input a, b, carryin;
  assign {carryout, sum} = a + b + carryin;
endmodule

module structuralFullAdder(out, carryout, a, b, carryin);
  output out, carryout;
  input a, b, carryin;
  wire nA, nB;
  wire AandnB, nAandB;
  wire AxorB;
  wire XandnC, nXandC;
  wire AandB, XandC;
  not notgate0(nA, a);
  not notgate1(nB, b);
  and andgate0(AandnB, a, nB);
  and andgate1(nAandB, nA, b);
  or orgate0(AxorB, AandnB, nAandB);
  not notgate2(nX, AxorB);
  not notgate3(nC, carryin);
  and andgate2(XandnC, AxorB, nC);
  and andgate3(nXandC, nX, carryin);
  or orgate1(out, XandnC, nXandC);
  and andgate4(AandB, a, b);
  and andgate5(XandC, AxorB, carryin);
  or orgate2(carryout, AandB, XandC);
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
