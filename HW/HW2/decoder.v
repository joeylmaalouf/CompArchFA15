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
  // Your decoder code here
endmodule

module testDecoder; 
  reg addr0, addr1;
  reg enable;
  wire out0, out1, out2, out3;
  behavioralDecoder decoder (out0, out1, out2, out3, addr0, addr1, enable);
  // structuralDecoder decoder (out0, out1, out2, out3, addr0, addr1, enable); // Swap after testing

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
