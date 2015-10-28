// Deliverable 8
`include "regfile.v"
//------------------------------------------------------------------------------
// Test harness validates hw4testbench by connecting it to various functional 
// or broken register files, and verifying that it correctly identifies each
//------------------------------------------------------------------------------

module hw4testbenchharness();
  wire[31:0] ReadData1;    // Data from first register read
  wire[31:0] ReadData2;	   // Data from second register read
  wire[31:0] WriteData;	   // Data to write to register
  wire[4:0] ReadRegister1; // Address of first register to read
  wire[4:0] ReadRegister2; // Address of second register to read
  wire[4:0] WriteRegister; // Address of register to write
  wire RegWrite;           // Enable writing of register when High
  wire Clk;                // Clock (Positive Edge Triggered)
  reg begintest;           // Set High to begin testing register file
  wire dutpassed;          // Indicates whether register file passed tests

  // Instantiate the register file being tested.  DUT = Device Under Test
  regfile DUT
  (
    .ReadData1(ReadData1),
    .ReadData2(ReadData2),
    .WriteData(WriteData),
    .ReadRegister1(ReadRegister1),
    .ReadRegister2(ReadRegister2),
    .WriteRegister(WriteRegister),
    .RegWrite(RegWrite),
    .Clk(Clk)
  );

  // Instantiate test bench to test the DUT
  hw4testbench tester
  (
    .begintest(begintest),
    .endtest(endtest), 
    .dutpassed(dutpassed),
    .ReadData1(ReadData1),
    .ReadData2(ReadData2),
    .WriteData(WriteData), 
    .ReadRegister1(ReadRegister1), 
    .ReadRegister2(ReadRegister2),
    .WriteRegister(WriteRegister),
    .RegWrite(RegWrite), 
    .Clk(Clk)
  );

  // Test harness asserts begintest for 1000 time steps, starting at time 10
  initial begin
    begintest = 0;
    #10;
    begintest = 1;
    #1000;
  end

  // Display test results (dutpassed signal) once endtest goes high
  always @(posedge endtest) begin
    $display("DUT passed?: %b", dutpassed);
  end
endmodule

module hw4testbench
(
  // Test bench driver signal connections
  input begintest,      // Triggers start of testing
  output reg endtest,   // Raise once test completes
  output reg dutpassed, // Signal test result
  // Register File DUT connections
  input[31:0] ReadData1,
  input[31:0] ReadData2,
  output reg[31:0] WriteData,
  output reg[4:0] ReadRegister1,
  output reg[4:0] ReadRegister2,
  output reg[4:0] WriteRegister,
  output reg RegWrite,
  output reg Clk
);

  // Initialize register driver signals
  initial begin
    WriteData = 32'd0;
    ReadRegister1 = 5'd0;
    ReadRegister2 = 5'd0;
    WriteRegister = 5'd0;
    RegWrite = 0;
    Clk = 0;
  end

  // Once begintest is asserted, start running test cases
  always @(posedge begintest) begin
    endtest = 0;
    dutpassed = 1;
    #10

    // Test Case 1 - check for the following case:
    // Write Enable is broken or ignored; register is always written to.
    // Translated: disabling the enable flag does nothing.
    RegWrite = 0;
    WriteData = 32'd42;
    WriteRegister = 5'd2;
    ReadRegister1 = 5'd2;
    #5 Clk = 1; #5 Clk = 0;
    if(ReadData1 == WriteData) begin
      dutpassed = 0;
      $display("Test Case 1 Failed");
    end

    // Test Case 2 - check for the following case:
    // Decoder is broken; all registers are written to.
    // Translated: A register other than the given one is written to.
    RegWrite = 1;
    WriteData = 32'd10;
    WriteRegister = 5'd31;
    ReadRegister1 = 5'd8;
    #5 Clk = 1; #5 Clk = 0;
    if((ReadRegister1 != WriteRegister) && (ReadData1 == WriteData)) begin
      dutpassed = 0;
      $display("Test Case 2 Failed");
    end

    // Test Case 3 - check for the following case:
    // Register zero is actually a register instead of the constant value zero.
    // Translated: Register zero is writable.
    RegWrite = 1;
    WriteData = 32'd404;
    WriteRegister = 5'd0;
    ReadRegister1 = 5'd0;
    #5 Clk = 1; #5 Clk = 0;
    if(ReadData1 != 0) begin
      dutpassed = 0;
      $display("Test Case 3 Failed");
    end

    // Test Case 4 - check for the following case:
    // Port 2 is broken and always reads register 17.
    // Translated: Port 2 fails to read the right register.
    RegWrite = 1;
    WriteData = 32'd713;
    WriteRegister = 5'd10;
    ReadRegister2 = 5'd10;
    #5 Clk = 1; #5 Clk = 0;
    if(ReadData2 != WriteData) begin
      dutpassed = 0;
      $display("Test Case 4 Failed");
    end

    // All done!  Wait a moment and signal test completion.
    #5
    endtest = 1;
  end
endmodule
