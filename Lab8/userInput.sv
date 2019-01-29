module userInput(Reset, Clock, Input, out);
	input logic Reset;
	input logic Clock;
	input logic Input;
	logic Input1, Input2;
	logic ns;
	output logic out;
	
	always_ff @(posedge Clock)
		Input1 <= Input;
	always_ff @(posedge Clock)
		Input2 <= Input1;
	
	always_comb
		ns <= Input2;

	
	always_ff @(posedge Clock)
		if (Reset)

				out <= 1'b0;
			

		else

				out <= ns;

		

endmodule

module userInput_testbench();
	logic Reset, Clock, Input;
	logic out;
	
	
	userInput dut (Reset, Clock, Input, out);

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		Clock <= 0;
		forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
																@(posedge Clock);
		Reset <= 1;											@(posedge Clock);
		Reset <= 0; Input <= 0;							@(posedge Clock);
																@(posedge Clock);
																@(posedge Clock);
																@(posedge Clock);
																@(posedge Clock);
																@(posedge Clock);
						Input <= 1 ;						@(posedge Clock);
																@(posedge Clock);
																@(posedge Clock);
																@(posedge Clock);
																@(posedge Clock);
																@(posedge Clock);


		$stop; // End the simulation.
	end
endmodule 