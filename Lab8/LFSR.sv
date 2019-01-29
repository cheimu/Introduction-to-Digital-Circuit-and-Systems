module LFSR(Clock, Reset, Input, Q);
	input logic Clock, Reset, Input;
	logic ps;
	output logic Q;
	
	assign Q = ps;
	
	always_ff @(posedge Clock)
		if (Reset)
			ps <= 1'b0;
		else 
			ps <= Input;
		
endmodule			


module LFSR_testbench();
	logic Clock, Reset, Input;
	logic Q;
	
	LFSR dut (.Clock, .Reset, .Input, .Q);

	// Set up the Clock

	parameter Clock_PERIOD=100;
	initial begin
		Clock <= 0;
		forever #(Clock_PERIOD/2) Clock <= ~Clock;
	end

	// Set up the inputs to the design. Each line is a Clock cycle.

	initial begin	
														@(posedge Clock);
				Reset <= 1;							@(posedge Clock);
				Reset <= 0;	Input <= 0;			@(posedge Clock);
														@(posedge Clock);
														@(posedge Clock);
														@(posedge Clock);
														@(posedge Clock);
														@(posedge Clock);
								Input <= 1;			@(posedge Clock);
														@(posedge Clock);
														@(posedge Clock);
														@(posedge Clock);
														@(posedge Clock);
								Input <= 0;			@(posedge Clock);
														@(posedge Clock);
														@(posedge Clock);
														@(posedge Clock);
														@(posedge Clock);
														@(posedge Clock);
								Input <= 1;			@(posedge Clock);
														@(posedge Clock);
														@(posedge Clock);	
														@(posedge Clock);
														@(posedge Clock);
								Input <= 0;			@(posedge Clock);
														@(posedge Clock);	
														@(posedge Clock);
														@(posedge Clock);
														@(posedge Clock);
								Input <= 1;			@(posedge Clock);
														@(posedge Clock);
														@(posedge Clock);
														@(posedge Clock);
														@(posedge Clock);
														@(posedge Clock);
														@(posedge Clock);
														@(posedge Clock);
					

		$stop;

	end

endmodule 