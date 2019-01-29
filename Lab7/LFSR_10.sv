module LFSR_10(Clock, Reset, Output);
	input logic Clock, Reset;
	logic [9:0] pattern;
	logic in;
	output logic [9:0] Output;
	
	assign Output[9:0] = pattern[9:0];
	xnor firstInput (in, pattern[9], pattern[6]);
	
	LFSR bit0 (.Clock(Clock), .Reset(Reset), .Input(in), .Q(pattern[0]));
	LFSR bit1 (.Clock(Clock), .Reset(Reset), .Input(pattern[0]), .Q(pattern[1]));
	LFSR bit2 (.Clock(Clock), .Reset(Reset), .Input(pattern[1]), .Q(pattern[2]));
	LFSR bit3 (.Clock(Clock), .Reset(Reset), .Input(pattern[2]), .Q(pattern[3]));
	LFSR bit4 (.Clock(Clock), .Reset(Reset), .Input(pattern[3]), .Q(pattern[4]));
	LFSR bit5 (.Clock(Clock), .Reset(Reset), .Input(pattern[4]), .Q(pattern[5]));
	LFSR bit6 (.Clock(Clock), .Reset(Reset), .Input(pattern[5]), .Q(pattern[6]));
	LFSR bit7 (.Clock(Clock), .Reset(Reset), .Input(pattern[6]), .Q(pattern[7]));
	LFSR bit8 (.Clock(Clock), .Reset(Reset), .Input(pattern[7]), .Q(pattern[8]));
	LFSR bit9 (.Clock(Clock), .Reset(Reset), .Input(pattern[8]), .Q(pattern[9]));
	
endmodule

module LFSR_10_testbench();
	logic Clock, Reset;
	logic [9:0] Output;

	
	LFSR_10 dut (.Clock, .Reset, .Output);

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