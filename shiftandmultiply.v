`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:05:28 05/07/2020 
// Design Name: 
// Module Name:    shiftandmultiply 
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
module shiftandmultiply(clk, reset, LA, LB, s, DataA, DataB, P, Finish);
	parameter n = 32;
	input clk, reset, LA, LB, s;
	input [n-1:0] DataA, DataB;
	output [n+n-1:0] P;
	output Finish;
	wire z, Cout; 
	reg [n+n-1:0] DataP;
	wire [n+n-1:0] A, Sum;
	reg [1:0] state, nextstate;
	wire [n-1:0] B;
	reg Finish, EA, EB, EP, Psel;
	integer i;
	
	parameter S1 = 2'b00; 
	parameter S2 = 2'b01;
	parameter S3 = 2'b10;
	
	always@(s or state or z)
	begin: states
		case(state)
			S1: if(s) nextstate = S2;
				 else nextstate = S1;
			S2: if(z) nextstate = S3;
				 else nextstate = S2;
			S3: if(s) nextstate = S3;
				 else nextstate = S1;
			default: nextstate = 2'bxx;
		endcase
	end
	
	always@(posedge clk or posedge reset)
	begin: FF_state
		if(reset)
			state <= S1;
		else
			state <= nextstate;
	end
	
	always@(s or state or B[0])
	begin: FSM
	EA = 0; EB = 0; EP = 0; Finish = 0; Psel = 0;
	case(state)
		S1: EP = 1;
		S2: begin
				EA = 1; EB = 1; Psel = 1;
				if(B[0]) EP = 1;
				else EP = 0;
			end
		S3: Finish = 1;
	endcase
end

shifterright ShiftingB(DataB, LB, EB, 1'b0, clk, B);
	defparam ShiftingB.n = 32;
shifterleft ShiftingA({{n{1'b0}}, DataA}, LA, EA, 1'b0, clk, A);
	defparam ShiftingA.n = 64;
	
assign z = (B==32'b0);
cla #(64) carryadder(A, P, 1'b0, Sum, Cout);

always@(Psel or Sum)
	for(i = 0; i < n+n; i = i+1)
		DataP[i] = Psel ? Sum[i] : 1'b0;
regen regp(DataP, clk, reset, EP, P);
	defparam regp.n = 64;
	
endmodule
 module shifterleft(R, L, E, w, clk, Q);
	parameter n = 4;
	input [n-1:0] R;
	input L, E, w, clk;
	output [n-1:0] Q;
	reg [n-1:0] Q;
	integer i;
	
	always@(posedge clk)
	begin
		if(L)
			Q <= R;
		else if(E)
		begin
			Q[0] <= w;
			for(i = 1; i < n; i = i+1)
				Q[i] <= Q[i-1];
		end
	end
endmodule

module shifterright(R, L, E, w, clk, Q);
parameter n = 4;
	input [n-1:0] R;
	input L, E, w, clk;
	output [n-1:0] Q;
	reg [n-1:0] Q;
	integer i;
	
	always@(posedge clk)
	begin
		if(L)
			Q <= R;
		else if(E)
		begin
		{Q[n-1], Q[n-2:0]} <= {w, Q[n-1:1]};
		end
	end
endmodule

module regen(R, clk, reset, E, Q);
parameter n = 8;
input [n-1:0] R;
input clk, reset, E;
output [n-1:0] Q;
reg [n-1:0] Q;

always@(posedge clk or posedge reset)
	if(reset)
		Q <= 0;
	else if(E)
		Q <= R;
endmodule



