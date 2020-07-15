`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:21:33 04/26/2020 
// Design Name: 
// Module Name:    rca 
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
module rca(A, B, Cin, Sum, Cout);
input [31:0] A, B;
input Cin;
output [31:0] Sum;
output Cout;
wire c1;
rca16bit R1(A[15:0], B[15:0], Cin, Sum[15:0], c1);
rca16bit R2(A[31:16], B[31:16], c1, Sum[31:16], Cout);
endmodule

module rca4bit(A, B, Cin, Sum, Cout);
input [3:0] A, B;
input Cin;
output [3:0] Sum;
output Cout;
wire c1, c2, c3;
adder A1(A[0], B[0], Cin, Sum[0], c1);
adder A2(A[1], B[1], c1, Sum[1], c2);
adder A3(A[2], B[2], c2, Sum[2], c3);
adder A4(A[3], B[3], c3, Sum[3], Cout);
endmodule

module rca16bit(A, B, Cin, Sum, Cout);
input [15:0] A, B;
input Cin;
output [15:0] Sum;
output Cout;
wire c1, c2, c3;
rca4bit A5(A[3:0], B[3:0], Cin, Sum[3:0], c1);
rca4bit A6(A[7:4], B[7:4], c1, Sum[7:4], c2);
rca4bit A7(A[11:8], B[11:8], c2, Sum[11:8], c3);
rca4bit A8(A[15:12], B[15:12], c3, Sum[15:12], Cout);
endmodule
