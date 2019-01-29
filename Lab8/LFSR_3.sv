module LFSR_3(Clock, Reset, Output);
	input logic Clock, Reset;
	logic [2:0] pattern;
	logic in;
	output logic [2:0] Output;
	
	assign Output[2:0] = pattern[2:0];
	xnor firstInput (in, pattern[2], pattern[1]);
	
	LFSR bit0 (.Clock(Clock), .Reset(Reset), .Input(in), .Q(pattern[0]));
	LFSR bit1 (.Clock(Clock), .Reset(Reset), .Input(pattern[0]), .Q(pattern[1]));
	LFSR bit2 (.Clock(Clock), .Reset(Reset), .Input(pattern[1]), .Q(pattern[2]));
	
	
endmodule

module LFSR_3_testbench();
	logic Clock, Reset;
	logic [2:0] Output;

	
	LFSR_3 dut (.Clock, .Reset, .Output);

	// Set up the Clock

	parameter Clock_PERIOD=100;
	initial begin
		Clock <= 0;
		forever #(Clock_PERIOD/2) Clock <= ~Clock;
	end

	// Set up the inputs to the design. Each line is a Clock cycle.

	initial begin	
									      @(posedge Clock);
				Reset <= 1;				@(posedge Clock);
				Reset <= 0;				@(posedge Clock);
											@(posedge Clock);
											@(posedge Clock);
		                           @(posedge Clock);
											@(posedge Clock);
											@(posedge Clock);
											@(posedge Clock);
											@(posedge Clock);
											@(posedge Clock);
											@(posedge Clock);
											@(posedge Clock);
											@(posedge Clock);
											@(posedge Clock);
											@(posedge Clock);
											@(posedge Clock);
											@(posedge Clock);
											@(posedge Clock);
											@(posedge Clock);
											@(posedge Clock);
											@(posedge Clock);	
											@(posedge Clock);
											@(posedge Clock);
											@(posedge Clock);
											@(posedge Clock);	
											@(posedge Clock);
										   @(posedge Clock);
											@(posedge Clock);
											@(posedge Clock);
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