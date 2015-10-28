// Deliverable 8
`include "register32.v"
`include "mux32to1by32.v"
`include "decoders.v"
//------------------------------------------------------------------------------
// MIPS register file
//   width: 32 bits
//   depth: 32 words (reg[0] is static zero register)
//   2 asynchronous read ports
//   1 synchronous, positive edge triggered write port
//------------------------------------------------------------------------------
module regfile
(
  output[31:0] ReadData1,   // Contents of first register read
  output[31:0] ReadData2,   // Contents of second register read
  input[31:0] WriteData,    // Contents to write to register
  input[4:0] ReadRegister1, // Address of first register to read
  input[4:0] ReadRegister2, // Address of second register to read
  input[4:0] WriteRegister, // Address of register to write
  input RegWrite,           // Enable writing of register when High
  input Clk                 // Clock (Positive Edge Triggered)
);
  wire[31:0] registers[31:0];
  wire[31:0] flags;
  decoder1to32 decoder(flags, RegWrite, WriteRegister);
  genvar i;
  generate
    for (i = 0; i < 32; i = i + 1) begin: reg_loop
      register32 r(registers[i], WriteData, flags[i], Clk);
    end
  endgenerate
  mux32to1by32 read1(ReadData1, ReadRegister1, registers[0], registers[1], registers[2], registers[3], registers[4], registers[5], registers[6], registers[7], registers[8], registers[9], registers[10], registers[11], registers[12], registers[13], registers[14], registers[15], registers[16], registers[17], registers[18], registers[19], registers[20], registers[21], registers[22], registers[23], registers[24], registers[25], registers[26], registers[27], registers[28], registers[29], registers[30], registers[31]);
  mux32to1by32 read2(ReadData2, ReadRegister2, registers[0], registers[1], registers[2], registers[3], registers[4], registers[5], registers[6], registers[7], registers[8], registers[9], registers[10], registers[11], registers[12], registers[13], registers[14], registers[15], registers[16], registers[17], registers[18], registers[19], registers[20], registers[21], registers[22], registers[23], registers[24], registers[25], registers[26], registers[27], registers[28], registers[29], registers[30], registers[31]);
endmodule
