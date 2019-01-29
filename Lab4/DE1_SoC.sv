// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR, SW);

	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [9:0] SW;
	
	// Combine different UPC code with corresponding HEX;
	always_comb
		case(SW[9:7])
			3'b000: HEX5 = 7'b1001111; // I
			3'b001: HEX5 = 7'b0001100; // P
			3'b011: HEX5 = 7'b1000110; // C
			3'b100: HEX5 = 7'b0110000; // 3
			3'b101: HEX5 = 7'b0001100; // P
			3'b110: HEX5 = 7'b0001000; // A
			default: HEX5 = 7'bX;
		endcase
	always_comb
		case(SW[9:7])
			3'b000: HEX4 = 7'b0001100; // P
			3'b001: HEX4 = 7'b0000110; // E
			3'b011: HEX4 = 7'b0001000; // A
			3'b100: HEX4 = 7'b0100001; // d
			3'b101: HEX4 = 7'b0010010; // S
			3'b110: HEX4 = 7'b0001100; // P
			default: HEX4 = 7'bX;
		endcase
	always_comb
		case(SW[9:7])
			3'b000: HEX3 = 7'b0001011; // h
			3'b001: HEX3 = 7'b0101011; // n
			3'b011: HEX3 = 7'b0101011; // n
			3'b100: HEX3 = 7'b0010010; // S
			3'b101: HEX3 = 7'b0001100; // P
			3'b110: HEX3 = 7'b0001100; // P
			default: HEX3 = 7'bX;
		endcase
	always_comb
		case(SW[9:7])
			3'b000: HEX2 = 7'b0100011; // o
			3'b001: HEX2 = 7'b1111111; 
			3'b011: HEX2 = 7'b0100001; // d
			3'b100: HEX2 = 7'b1111111;
			3'b101: HEX2 = 7'b1111111;
			3'b110: HEX2 = 7'b1000111; // L
			default: HEX2 = 7'bX;
		endcase
	always_comb
		case(SW[9:7])
			3'b000: HEX1 = 7'b0101011; // n
			3'b001: HEX1 = 7'b1111111;
			3'b011: HEX1 = 7'b0010001; // y
			3'b100: HEX1 = 7'b1111111;
			3'b101: HEX1 = 7'b1111111;
			3'b110: HEX1 = 7'b0000110; // E
			default: HEX1 = 7'bX;
		endcase
	always_comb
		case(SW[9:7])
			3'b000: HEX0 = 7'b0000110; // E
			3'b001: HEX0 = 7'b1111111;
			3'b011: HEX0 = 7'b1111111;
			3'b100: HEX0 = 7'b1111111;
			3'b101: HEX0 = 7'b1111111;
			3'b110: HEX0 = 7'b1111111;			
			default: HEX0 = 7'bX;
		endcase
		
	// Logic to check if item is discounted or not,
	assign LEDR[0] = SW[8] | SW[7] & SW[9];
	// Logic to check if item is stolen or not.
	assign LEDR[1] = ~(SW[0] | SW[8] | (SW[7] & ~SW[9]));
	
endmodule

	module DE1_SoC_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [9:0] SW;
	DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .LEDR, .SW);
	// Try all combinations of inputs.
	integer i;
	initial begin
	SW[6:1] = 1'b0;
		for(i = 0; i < 16; i++) begin
			{SW[0], SW[9:7]} = i; #2; 
		
		end
	end
endmodule