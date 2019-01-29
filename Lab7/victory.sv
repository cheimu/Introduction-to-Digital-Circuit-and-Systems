module victory (Clock, Reset, ResetPlayfield, L, R, MostLeft, MostRight, displayHuman, displayCyber);
	input logic Clock, Reset;
	// L is true when left key is pressed, R is true when the right key
	// is pressed, NL is true when the light on the left is on, and NR
	// is true when the light on the right is on.
	input logic L, R, MostLeft, MostRight;
	// when lightOn is true, the center light should be on.
	logic [2:0] ps, ns, psCyber, nsCyber;
	output logic[6:0] displayHuman, displayCyber;
	output logic ResetPlayfield;
	// Your code goes here!!
	always_comb
			if (ps != 3'b111 & (MostRight & ~L & R)) 
				begin
					ResetPlayfield = 1'b1;
					ns = ps + 3'b001;
					nsCyber = psCyber;
				end
		   else if (psCyber != 3'b111 & (MostLeft & L & ~R))
				begin
					ResetPlayfield = 1'b1;
					ns = ps;
					nsCyber = psCyber + 3'b001;
				end
			else
				begin
					if (ps == 3'b111 | psCyber == 3'b111)
						ResetPlayfield = 1'b1;
					else ResetPlayfield = 1'b0;
					ns = ps;
					nsCyber = psCyber;
				end
	seg7 human(.ps(ps), .display(displayHuman));
	seg7 cyber(.ps(psCyber), .display(displayCyber));
		
	always_ff @(posedge Clock)
		if (Reset)
			begin
				ps <= 3'b000;
				psCyber <= 3'b000;
			end
		else
			begin
				ps <= ns;
				psCyber <= nsCyber;
			end
endmodule

module seg7 (ps, display);
	logic Clock, Reset;
	input logic [2:0] ps;
	output logic [6:0] display;
	
	always_comb
		case (ps)
			// 			Light: 6543210
			3'b000: display = 7'b1000000; // 0
			3'b001: display = 7'b1111001; // 1
			3'b010: display = 7'b0100100; // 2
			3'b011: display = 7'b0110000; // 3
			3'b100: display = 7'b0011001; // 4
			3'b101: display = 7'b0010010; // 5
			3'b110: display = 7'b0000010; // 6
			3'b111: display = 7'b1111000; // 7
			default: display = 7'bX;
		endcase

endmodule


module victory_testbench();
	logic Clock, Reset, L, R, MostLeft, MostRight;
   logic[6:0] displayHuman, displayCyber;
	logic ResetPlayfield;
	victory dut (.Clock, .Reset, .ResetPlayfield, .L, .R, .MostLeft, .MostRight, .displayHuman, .displayCyber);

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