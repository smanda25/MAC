`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:38:46 05/06/2020 
// Design Name: 
// Module Name:    multiply 
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
module multiply(clk, reset, LA, LB, s, DataA, DataB, P, Finish);
	parameter n = 32;
	input clk, reset, LA, LB, s;
	input [n-1:0] DataA, DataB;
	output [n+n-1:0] P;
	output Finish;
	wire z, Cout; 
	reg [n+n-1:0] A, DataP;
	wire [n+n-1:0] Sum;
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

shifterright ShiftingB(DataB, LB, EB, 0, clk, A);
	defparam ShiftingB.n = 8;
shifterleft ShiftingA({{n{1'b0}}, DataA}, LA, EA, 0, clk, A);
	defparam ShiftingA.n = 16;
	
assign z = (B==0);
cla carryadder(A, P, 0, Sum, Cout);

always@(Psel or Sum)
	for(i = 0; i < n+n; i = i+1)
		DataP[i] = Psel ? Sum[i] : 0;
regenable regp(DataP, clk, reset, EP, P);
	defparam regp.n = 16;
	
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
		Q <= {w,Q[n-1:1]};
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
