module centerLight (Clock, Reset, L, R, NL, NR, lightOn);
	input logic Clock, Reset;
	// L is true when left key is pressed, R is true when the right key
	// is pressed, NL is true when the light on the left is on, and NR
	// is true when the light on the right is on.
	input logic L, R, NL, NR;
	// when lightOn is true, the center light should be on.
	logic ns;
	output logic lightOn;
	// Your code goes here!!
	always_comb
		case(lightOn)
			1'b1: if (R & L| ~R & ~L) ns = 1'b1;
					else ns = 1'b0;
					
			1'b0: if (NL & R & ~L | NR & ~R & L) ns = 1'b1;
					else ns = 1'b0;
		endcase	
		
	always_ff @(posedge Clock)
		if (Reset)
			lightOn <= 1'b1;
		else
			lightOn <= ns;
			

endmodule

module normalLight (Clock, Reset, L, R, NL, NR, lightOn);
	input logic Clock, Reset;
	// L is true when left key is pressed, R is true when the right key
	// is pressed, NL is true when the light on the left is on, and NR
	// is true when the light on the right is on.
	input logic L, R, NL, NR;
	// when lightOn is true, the center light should be on.
	logic ns;
	output logic lightOn;
	// Your code goes here!!
	always_comb
		case(lightOn)
			1'b1: if (R & L | ~R & ~L) ns = 1'b1;
					else ns = 1'b0;
					
			1'b0: if (NL & R & ~L | NR & ~R & L) ns = 1'b1;
					else ns = 1'b0;
		endcase	
		
	always_ff @(posedge Clock)
		if (Reset)
			lightOn <= 1'b0;
		else
			lightOn <= ns;
			
		
endmodule

module centerLight_testbench();
	logic Clock, Reset, L, R, NL, NR;
	logic lightOn;

	centerLight dut (Clock, Reset, L, R, NL, NR, lightOn);

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		Clock <= 0;
		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
																				@(posedge Clock);
		Reset <= 1;															@(posedge Clock);
		Reset <= 0; L <= 0; R <= 0; NL <= 0; NR <= 0;			@(posedge Clock);
																				@(posedge Clock);
																				@(posedge Clock);
																				@(posedge Clock);
														 NR <= 1;			@(posedge Clock);
																				@(posedge Clock);
																				@(posedge Clock);
																				@(posedge Clock);
										    NL <= 1; NR <= 0;			@(posedge Clock);
																				@(posedge Clock);
																				@(posedge Clock);
																				@(posedge Clock);
								  R <= 1; NL <= 0; NR <= 0;			@(posedge Clock);
																				@(posedge Clock);	
																				@(posedge Clock);
																				@(posedge Clock);
														 NR <= 1;			@(posedge Clock);
																				@(posedge Clock);
																				@(posedge Clock);
																				@(posedge Clock);
											 NL <= 1; NR <= 0;		   @(posedge Clock);
																				@(posedge Clock);
																				@(posedge Clock);
																				@(posedge Clock);
		            L <= 1; R <= 0; NL <= 0; NR <= 0;		   @(posedge Clock);
																				@(posedge Clock);
																				@(posedge Clock);
																				@(posedge Clock);
														 NR <= 1;			@(posedge Clock);
																				@(posedge Clock);
																				@(posedge Clock);
																				@(posedge Clock);
										    NL <= 1; NR <= 0;			@(posedge Clock);
																				@(posedge Clock);
																				@(posedge Clock);
																				@(posedge Clock);
								  R <= 1; NL <= 0; NR <= 0;			@(posedge Clock);
																				@(posedge Clock);	
																				@(posedge Clock);
																				@(posedge Clock);
														 NR <= 1;			@(posedge Clock);
																				@(posedge Clock);
																				@(posedge Clock);
																				@(posedge Clock);
											 NL <= 1; NR <= 0;		   @(posedge Clock);
																				@(posedge Clock);
																				@(posedge Clock);
																				@(posedge Clock);

		$stop; // End the simulation.
	end
endmodule 