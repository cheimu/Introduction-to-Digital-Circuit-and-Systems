module victory (Clock, Reset, L, R, MostLeft, MostRight, display);
	input logic Clock, Reset;
	// L is true when left key is pressed, R is true when the right key
	// is pressed, NL is true when the light on the left is on, and NR
	// is true when the light on the right is on.
	input logic L, R, MostLeft, MostRight;
	// when lightOn is true, the center light should be on.
	logic [6:0] ns;
	output logic[6:0] display;
	// Your code goes here!!
	always_comb
		case(display)
			7'b1111111: if (MostLeft & L & ~R) ns = 7'b1111001;
					else if (MostRight & ~L & R) ns = 7'b0100100;
					else ns = 7'b1111111;
			7'b1111001: ns = 7'b1111001;
			7'b0100100: ns = 7'b0100100;
			default: ns = 7'b1111111;
		endcase	
	
		
	always_ff @(posedge Clock)
		if (Reset)
			display <= 7'b1111111;
		else
			display <= ns;
endmodule


module victory_testbench();
	logic Clock, Reset, L, R, MostLeft, MostRight;
	logic[6:0] display;

	victory dut (Clock, Reset, L, R, MostLeft, MostRight, display);

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		Clock <= 0;
		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
																								@(posedge Clock);
		Reset <= 1;																			@(posedge Clock);
		Reset <= 0; L <= 0; R <= 0; MostLeft <= 0; MostRight <= 0;			@(posedge Clock);
																								@(posedge Clock);
																								@(posedge Clock);
																								@(posedge Clock);
														 MostRight <= 1;					@(posedge Clock);
																								@(posedge Clock);
																								@(posedge Clock);
																								@(posedge Clock);
										    MostLeft <= 1; MostRight <= 0;			@(posedge Clock);
																								@(posedge Clock);
																								@(posedge Clock);
																								@(posedge Clock);
								  R <= 1; MostLeft <= 0; MostRight <= 0;			@(posedge Clock);
																								@(posedge Clock);				
																								@(posedge Clock);
																								@(posedge Clock);
														 MostRight <= 1;					@(posedge Clock);
																								@(posedge Clock);
																								@(posedge Clock);
																								@(posedge Clock);
											 MostLeft <= 1; MostRight <= 0;		   @(posedge Clock);
																								@(posedge Clock);
																								@(posedge Clock);
																								@(posedge Clock);
		            L <= 1; R <= 0; MostLeft <= 0; MostRight <= 0;		   @(posedge Clock);
																								@(posedge Clock);
																								@(posedge Clock);
																								@(posedge Clock);
																 MostRight <= 1;			@(posedge Clock);
																								@(posedge Clock);
																								@(posedge Clock);
																								@(posedge Clock);
										    MostLeft <= 1; MostRight <= 0;			@(posedge Clock);
																								@(posedge Clock);
																								@(posedge Clock);
																								@(posedge Clock);
								  R <= 1; MostLeft <= 0; MostRight <= 0;			@(posedge Clock);
																								@(posedge Clock);	
																								@(posedge Clock);
																								@(posedge Clock);
														       MostRight <= 1;			@(posedge Clock);
																								@(posedge Clock);
																								@(posedge Clock);
																								@(posedge Clock);
											 MostLeft <= 1; MostRight <= 0;		   @(posedge Clock);
																								@(posedge Clock);
																								@(posedge Clock);
																								@(posedge Clock);

		$stop; // End the simulation.
	end
endmodule 