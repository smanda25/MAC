`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:05:43 04/26/2020 
// Design Name: 
// Module Name:    adder 
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
module adder(input A, input B, input Cin, output Sum, output Cout 
    );
wire p,r,s;
xor (p,A,B);
xor (Sum,p,Cin);
and(r,p,Cin);
and(s,A,B);
or(Cout,r,s);

endmodule
