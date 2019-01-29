module simple (clk, reset, w0, w1, out);
	input logic clk, reset, w0, w1;
	logic w2, w3, w4, w5;
	output logic [2:0] out;
	// State variables.
	logic [2:0] ns, ps;
	
	
	always_ff @(posedge clk)
		w2 <= w0;
	always_ff @(posedge clk)
		w3 <= w2;	
	always_ff @(posedge clk)
		w4 <= w1;
	always_ff @(posedge clk)
		w5 <= w4;		
		

	// Next State logic
	always_comb
	 case (ps)
		 3'b101: if (~w5 && ~w3) ns = 3'b010;
			 else if (~w5 && w3) ns = 3'b001;
			 else ns = 3'b100;
		 3'b010: if (~w5 && ~w3) ns = 3'b101;
			 else if(~w5 && w3) ns = 3'b100;
			 else ns = 3'b001;
		 3'b100: if (~w5 && ~w3) ns = 3'b101;
			 else if (~w5 && w3) ns = 3'b001;
			 else ns = 3'b010;
		 3'b001: if (~w5 && ~w3) ns = 3'b101;
			 else if (~w5 && w3) ns = 3'b010;
			 else ns = 3'b100;
		
	 endcase
	 
	 assign out = ns;


	// DFFs
	always_ff @(posedge clk)
	 if (reset)
		ps <= 3'b101;
	 else
		ps <= ns;

endmodule

 
module simple_testbench();
	logic clk, reset, w0, w1;
	logic [2:0] out;

	simple dut (clk, reset, w0, w1, out);

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
														@(posedge clk);
		reset <= 1;									@(posedge clk);
		reset <= 0; w0 <= 0; w1 <= 0;			@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
						w0 <= 1;					   @(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
						w0 <= 0; w1 <= 1;		   @(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
														@(posedge clk);
		$stop; // End the simulation.
	end
endmodule 