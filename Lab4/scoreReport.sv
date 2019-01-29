module scoreReport(Clock, Reset, gameStart, beginning, increment, display, addOne)

	input logic Clock, Reset, gameStart, increment;
	input logic [6:0] beginning;
	logic [6:0] ps, ns;
	output logic addOne;
	output logic [6:0] display;
	
	parameter ZERO = 7'b1000000; // 0
	parameter ONE = 7'b1111001; // 1
	parameter TWO = 7'b0100100; // 2
	parameter THREE = 7'b0110000; // 3
	parameter FOUR = 7'b0011001; // 4
	parameter FIVE = 7'b0010010; // 5
	parameter SIX = 7'b0000010; // 6
	parameter SEVEN = 7'b1111000; // 7
	parameter EIGHT = 7'b0000000; // 8
	parameter NINE HEX0 = 7'b0010000; // 9
	
	always_comb
		if (increment)
			case(ps)
				ZERO: ns = ONE;
				ONE: ns = TWO;
				TWO: ns = THREE;
				FOUR: ns = FIVE;
				FIVE: ns = SIX;
				SIX: ns = SEVEN;
				SEVEN: ns = EIGHT;
				EIGHT: ns = NINE;
				NINE: ns = ZERO;
			endcase
		else
			ns = ps;
			
	assign display = ps;		
	assign addOne = (ps[6:0] == NINE) & increment;
	
	always_ff @(posedge Clock)
		if(Reset & !gameStart)
			ps <= beginning;
		else
			ps <= ns;
			
endmodule
