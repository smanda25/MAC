`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:28:11 04/27/2020 
// Design Name: 
// Module Name:    cla 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module cla(A, B, CIN, S, Cout);
	parameter N = 32;
	input [N-1:0] A, B;
	input CIN;
	output reg [N-1:0] S;
	output reg Cout;
	reg GGa, GPa;
	reg [N-1:0] G, P, C;
	integer i;
	
	always @ (*) begin
		for (i = 0; i<= N-1; i = i + 1) begin
			G[i] = A[i] & B[i];
			P[i] = A[i] | B[i];
		end
		GGa = G[0]; GPa = P[0];
		C[0] = CIN;
		for (i = 1; i <= N-1; i = i + 1) begin
			C[i] = GGa | (CIN & GPa);
			GGa = G[i] | (GGa & P[i]);
			GPa = P[i] & GPa;
		end
		S = A ^ B ^ C;
		Cout = GGa | (GPa & C[N-1]);
		end

endmodule

