`define AND and #50
`define OR or #50
`define NOT not #50
`define XOR xor #50

module behavioralDecoder(out0, out1, out2, out3, address0, address1, enable);
  output out0, out1, out2, out3;
  input address0, address1;
  input enable;
  assign {out3, out2, out1, out0} = enable << {address1, address0};
endmodule

module structuralDecoder(out0, out1, out2, out3, address0, address1, enable);
  output out0, out1, out2, out3;
  input address0, address1;
  input enable;
  wire nA0, nA1;
  wire nA0andnA1, nA0andA1, A0andnA1, A0andA1;
  `NOT notgate0(nA0, address0);
  `NOT notgate1(nA1, address1);
  `AND andgate0(nA0andnA1, nA0, nA1);
  `AND andgate1(nA0andA1, address0, nA1);
  `AND andgate2(A0andnA1, nA0, address1);
  `AND andgate3(A0andA1, address0, address1);
  `AND andgate4(out0, enable, nA0andnA1);
  `AND andgate5(out1, enable, nA0andA1);
  `AND andgate6(out2, enable, A0andnA1);
  `AND andgate7(out3, enable, A0andA1);
endmodule

module testDecoder; 
  reg addr0, addr1;
  reg enable;
  wire out0, out1, out2, out3;
  // behavioralDecoder decoder (out0, out1, out2, out3, addr0, addr1, enable);
  structuralDecoder decoder (out0, out1, out2, out3, addr0, addr1, enable);

  initial begin
    $display("En A0 A1 | O0 O1 O2 O3 | Expected Output");
    enable = 0; addr0 = 0; addr1 = 0; #1000
    $display(" %b  %b  %b |  %b  %b  %b  %b | All False", enable, addr0, addr1, out0, out1, out2, out3);
    enable = 0; addr0 = 1; addr1 = 0; #1000
    $display(" %b  %b  %b |  %b  %b  %b  %b | All False", enable, addr0, addr1, out0, out1, out2, out3);
    enable = 0; addr0 = 0; addr1 = 1; #1000
    $display(" %b  %b  %b |  %b  %b  %b  %b | All False", enable, addr0, addr1, out0, out1, out2, out3);
    enable = 0; addr0 = 1; addr1 = 1; #1000
    $display(" %b  %b  %b |  %b  %b  %b  %b | All False", enable, addr0, addr1, out0, out1, out2, out3);
    enable = 1; addr0 = 0; addr1 = 0; #1000
    $display(" %b  %b  %b |  %b  %b  %b  %b | O0 True", enable, addr0, addr1, out0, out1, out2, out3);
    enable = 1; addr0 = 1; addr1 = 0; #1000
    $display(" %b  %b  %b |  %b  %b  %b  %b | O1 True", enable, addr0, addr1, out0, out1, out2, out3);
    enable = 1; addr0 = 0; addr1 = 1; #1000
    $display(" %b  %b  %b |  %b  %b  %b  %b | O2 True", enable, addr0, addr1, out0, out1, out2, out3);
    enable = 1; addr0 = 1; addr1 = 1; #1000
    $display(" %b  %b  %b |  %b  %b  %b  %b | O3 True", enable, addr0, addr1, out0, out1, out2, out3);
  end
endmodule
