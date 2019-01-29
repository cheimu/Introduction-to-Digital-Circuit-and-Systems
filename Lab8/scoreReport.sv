module scoreReport(Clock, Reset, gameStart, beginning, increment, display, addOne);

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
	parameter NINE = 7'b0010000; // 9
	
	always_comb
		if (increment)
			case(ps)
				ZERO: ns = ONE;
				ONE: ns = TWO;
				TWO: ns = THREE;
				THREE: ns = FOUR;
				FOUR: ns = FIVE;
				FIVE: ns = SIX;
				SIX: ns = SEVEN;
				SEVEN: ns = EIGHT;
				EIGHT: ns = NINE;
				NINE: ns = ZERO;
				default ns = ONE;
			endcase
		else
			ns = ps;
			
	assign display[6:0] = ps[6:0];		
	assign addOne = (ps[6:0] == NINE) & increment;
	
	always_ff @(posedge Clock)
		if(Reset | !gameStart)
			ps <= beginning;
		else
			ps <= ns;
			
endmodule

module scoreReport_testbench();

	logic  Clock, Reset, gameStart, increment;

	logic [6:0] beginning;

	logic [6:0] display;

	logic addOne;



	scoreReport dut(Clock, Reset, gameStart, beginning, increment, display, addOne);

	

	// Set up the clock.

	parameter CLOCK_PERIOD=100;

	initial Clock=1;

	always begin

		#(CLOCK_PERIOD/2);

		Clock = ~Clock;

	end

	

	initial begin

		

		Reset <= 1;	gameStart <= 0;	

				beginning <= 7'b1111111;	increment <= 1;	@(posedge Clock);

				beginning <= 7'b0000000;					@(posedge Clock);

		Reset <= 0;									@(posedge Clock);

						gameStart <= 1;				@(posedge Clock);

										increment <= 0;	@(posedge Clock);

										increment <= 1;	@(posedge Clock);

														@(posedge Clock);

														@(posedge Clock);

														@(posedge Clock);

														@(posedge Clock);

														@(posedge Clock);

														@(posedge Clock);

														@(posedge Clock);

										increment <= 0;	@(posedge Clock);

										increment <= 1;	@(posedge Clock);

														@(posedge Clock);

		$stop;

	end

endmodule
