`timescale 1ns / 1ps

//calculeaza catul si restul impartirii sumei la numarul de senzori

module division(
	output reg [15:0] Q,   	//cat
	output reg [15:0] R, 	//rest
	input [15:0] N, 	//deimpartit
	input [15:0] D);	//impartitor

		integer i; 
		reg [1:0] code;
		always@(*) begin
			Q=0;          //initializare
			R=0;
			for( i=15; i>=0; i=i-1) begin      
				R=R<<1;			//R shiftat la stanga cu 1 bit
				R[0]=N[i];		//LSB(R) = N[i]
				if(R>=D) begin
					R=R-D;
					Q[i]=1;
				end
			end
		end
endmodule
