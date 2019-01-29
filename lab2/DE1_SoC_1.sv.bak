// Top-level module that defines the I/Os for the DE-1 SoC board

module DE1_SoC_1 (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);

	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	
	// Default values, turns off the HEX displays
	assign HEX0 = 7'b1111111;
	assign HEX1 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
	assign HEX5 = 7'b1111111;
	
	// Logic to check if SW[3]..SW[0] match your bottom digit,
	assign BottomDigit = (SW[1] & SW[2]) & (~SW[0] & ~SW[3]) ;
	// and SW[7]..SW[4] match the next.
	assign NextDigit = SW[1] & (~SW[0] & ~SW[2] & ~SW[3]);
	// Result should drive LEDR[0].
	assign LEDR[0] = BottomDigit & NextDigit;
	
endmodule