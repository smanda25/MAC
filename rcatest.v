`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:17:41 05/07/2020
// Design Name:   rca
// Module Name:   C:/Users/saidh/ECE_465/Project/rcatest.v
// Project Name:  Project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: rca
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module rcatest;

	// Inputs
	reg [31:0] A;
	reg [31:0] B;
	reg Cin;

	// Outputs
	wire [31:0] Sum;
	wire Cout;

	// Instantiate the Unit Under Test (UUT)
	rca uut (
		.A(A), 
		.B(B), 
		.Cin(Cin), 
		.Sum(Sum), 
		.Cout(Cout)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		Cin = 0;

		// Wait 100 ns for global reset to finish
		#100;
      A = 2134352;
		#10;
		B = 1245465;
		#10;
		Cin = 1;
		#10;
		Cin = 0;
		// Add stimulus here

	end
      
endmodule

