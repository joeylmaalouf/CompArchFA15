module hw1test;

reg A, B; // A, B
wire nA, nB; // ~A, ~B

wire AandB; // A * B
wire AorB; // A + B

wire NAandB; // ~(A * B)
wire nAornB; // ~A + ~B
wire NAorB; // ~(A + B)
wire nAandnB; // ~A * ~B


not notgate0(nA, A); // inverter 0 produces signal nA and takes signal A
not notgate1(nB, B); // inverter 1 produces signal nB and takes signal B

and andgate0(AandB, A, B);
or orgate0(AorB, A, B);

not notgate2(NAandB, AandB);
or orgate1(nAornB, nA, nB);
not notgate3(NAorB, AorB);
and andgate1(nAandnB, nA, nB);


initial begin
	$display("A | B | ~A | ~B | A * B | A + B || ~(A * B) | ~A + ~B | ~(A + B) | ~A * ~B"); // Prints header for truth table

	A = 0; B = 0; #1 // set A, set B, wait for update
	$display("%b | %b |  %b |  %b |   %b   |   %b   ||     %b    |    %b    |     %b    |    %b   ", A,B, nA, nB, AandB, AorB, NAandB, nAornB, NAorB, nAandnB);
	A = 0; B = 1; #1
	$display("%b | %b |  %b |  %b |   %b   |   %b   ||     %b    |    %b    |     %b    |    %b   ", A,B, nA, nB, AandB, AorB, NAandB, nAornB, NAorB, nAandnB);
	A = 1; B = 0; #1
	$display("%b | %b |  %b |  %b |   %b   |   %b   ||     %b    |    %b    |     %b    |    %b   ", A,B, nA, nB, AandB, AorB, NAandB, nAornB, NAorB, nAandnB);
	A = 1; B = 1; #1
	$display("%b | %b |  %b |  %b |   %b   |   %b   ||     %b    |    %b    |     %b    |    %b   ", A,B, nA, nB, AandB, AorB, NAandB, nAornB, NAorB, nAandnB);
end

endmodule
