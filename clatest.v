`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:23:05 05/07/2020
// Design Name:   cla
// Module Name:   C:/Users/saidh/ECE_465/Project/clatest.v
// Project Name:  Project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: cla
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module clatest;

	// Inputs
	reg [31:0] A;
	reg [31:0] B;
	reg CIN;

	// Outputs
	wire [31:0] S;
	wire Cout;

	// Instantiate the Unit Under Test (UUT)
	cla uut (
		.A(A), 
		.B(B), 
		.CIN(CIN), 
		.S(S), 
		.Cout(Cout)
	);

	initial begin
		// Initialize Inputs
		A = 0;
		B = 0;
		CIN = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		A = 1232;
		B = 1456;
		#30;
		A = 1298;
		B = 32'hffffffff;
	end
      
endmodule

