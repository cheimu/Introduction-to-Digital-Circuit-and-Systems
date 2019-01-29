module seg7 (SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	input logic [9:0] SW;
	
	always_comb
		case (SW[3:0])
			// 			Light: 6543210
			4'b0000: HEX0 = 7'b1000000; // 0
			4'b0001: HEX0 = 7'b1111001; // 1
			4'b0010: HEX0 = 7'b0100100; // 2
			4'b0011: HEX0 = 7'b0110000; // 3
			4'b0100: HEX0 = 7'b0011001; // 4
			4'b0101: HEX0 = 7'b0010010; // 5
			4'b0110: HEX0 = 7'b0000010; // 6
			4'b0111: HEX0 = 7'b1111000; // 7
			4'b1000: HEX0 = 7'b0000000; // 8
			4'b1001: HEX0 = 7'b0010000; // 9
			default: HEX0 = 7'bX;
		endcase
	always_comb
		case (SW[7:4])
			//			   Light: 6543210
			4'b0000: HEX1 = 7'b1000000; // 0
			4'b0001: HEX1 = 7'b1111001; // 1
			4'b0010: HEX1 = 7'b0100100; // 2
			4'b0011: HEX1 = 7'b0110000; // 3
			4'b0100: HEX1 = 7'b0011001; // 4
			4'b0101: HEX1 = 7'b0010010; // 5
			4'b0110: HEX1 = 7'b0000010; // 6
			4'b0111: HEX1 = 7'b1111000; // 7
			4'b1000: HEX1 = 7'b0000000; // 8
			4'b1001: HEX1 = 7'b0010000; // 9
			default: HEX1 = 7'bX;
		endcase
endmodule
module seg7_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] SW;
	
	seg7 dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .SW);
	// Try all combinations of inputs.
	integer i;
	initial begin
	SW[9:8] = 1'b0;
		for(i = 0; i < 16; i++) begin
			SW[3:0] = i; #2; 
			SW[7:4] = i; #2;
		end
	end
endmodule