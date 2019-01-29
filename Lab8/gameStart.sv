module gameStart(Clock, Reset, Input, start);
	input logic Clock, Reset, Input;
	logic ps, ns;
	output logic start;
	
	always_comb
		ns = ps | Input;
		
	always_ff @(posedge Clock)
		if (Reset)
			ps <= 1'b0;
		else 
			ps <= ns;
			
	assign start = ps;
endmodule
	
module gameStart_testbench();

	logic	Clock, Reset, Input;

	logic start;


	

	gameStart dut (Clock, Reset, Input, start);

	

	// Set up the clock.

	parameter CLOCK_PERIOD=100;

	initial Clock=1;

	always begin

		#(CLOCK_PERIOD/2);

		Clock = ~Clock;

	end

	

	initial begin

		Reset <= 0;	Input <= 1;	@(posedge Clock);

						Input <= 0;	@(posedge Clock);

		Reset <= 1;						@(posedge Clock);

						Input <= 1;	@(posedge Clock);

											@(posedge Clock);

						Input <= 0;	@(posedge Clock);

		Reset <= 0;  Input <= 1;        @(posedge Clock);

						Input <= 0;	 @(posedge Clock);

											@(posedge Clock);

							Input <= 1;				@(posedge Clock);

											@(posedge Clock);

						Input <= 0;					@(posedge Clock);

											@(posedge Clock);



		$stop;

	end

endmodule 