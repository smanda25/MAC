`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:42:46 05/07/2020
// Design Name:   multiply
// Module Name:   C:/Users/saidh/ECE_465/Project/testbench.v
// Project Name:  Project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: multiply
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testbench;

	// Inputs
	reg clk;
	reg reset;
	reg LA;
	reg LB;
	reg s;
	reg [31:0] DataA;
	reg [31:0] DataB;

	// Outputs
	wire [63:0] P;
	wire Finish;

	// Instantiate the Unit Under Test (UUT)
	multiply uut (
		.clk(clk), 
		.reset(reset), 
		.LA(LA), 
		.LB(LB), 
		.s(s), 
		.DataA(DataA), 
		.DataB(DataB), 
		.P(P), 
		.Finish(Finish)
	);
	always
	begin
		clk = 0; #5;
		clk = 1; #5;
	end
	initial begin
		// Initialize Inputs
		reset = 0;
		LA = 0;
		LB = 0;
		s = 0;
		DataA = 0;
		DataB = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		DataA = 123; DataB = 156;
		#30;
		LA = 1; LB = 1;
		#10;
		DataA = 0; DataB = 0;
		#5;
		s = 1;
		#50;
		s = 0;
		#10;
		
		
	end
      
endmodule

