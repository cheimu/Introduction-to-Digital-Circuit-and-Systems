module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR,
SW);
	 input logic CLOCK_50; // 50MHz CLOCK_50.
	 output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 output logic [9:0] LEDR;
	 input logic [3:0] KEY; // True when not pressed, False when pressed
	 input logic [9:0] SW;
	 logic L, R;

	 // Hook up FSM inputs and outputs.
	 logic reset;

	 assign reset = SW[9]; // Reset when SW[9] is pressed.

	 assign HEX1 = 7'b1111111;
	 assign HEX2 = 7'b1111111;
	 assign HEX3 = 7'b1111111;
	 assign HEX4 = 7'b1111111;
	 assign HEX5 = 7'b1111111;
	 
	 

	 
	
	 userInput leftButton(.Reset(reset), .Clock(CLOCK_50), .Input(KEY[3]), .out(L));
	 userInput rightButton(.Reset(reset), .Clock(CLOCK_50), .Input(KEY[0]), .out(R));
	 normalLight LEDR1(.Clock(CLOCK_50), .Reset(reset), .L, .R, .NL(LEDR[2]), .NR(1'b0), .lightOn(LEDR[1]));
	 normalLight LEDR2(.Clock(CLOCK_50), .Reset(reset), .L, .R, .NL(LEDR[3]), .NR(LEDR[1]), .lightOn(LEDR[2]));
	 normalLight LEDR3(.Clock(CLOCK_50), .Reset(reset), .L, .R, .NL(LEDR[4]), .NR(LEDR[2]), .lightOn(LEDR[3]));
	 normalLight LEDR4(.Clock(CLOCK_50), .Reset(reset), .L, .R, .NL(LEDR[5]), .NR(LEDR[3]), .lightOn(LEDR[4]));
	 centerLight LEDR5(.Clock(CLOCK_50), .Reset(reset), .L, .R, .NL(LEDR[6]), .NR(LEDR[4]), .lightOn(LEDR[5]));
	 normalLight LEDR6(.Clock(CLOCK_50), .Reset(reset), .L, .R, .NL(LEDR[7]), .NR(LEDR[5]), .lightOn(LEDR[6]));
	 normalLight LEDR7(.Clock(CLOCK_50), .Reset(reset), .L, .R, .NL(LEDR[8]), .NR(LEDR[6]), .lightOn(LEDR[7]));
	 normalLight LEDR8(.Clock(CLOCK_50), .Reset(reset), .L, .R, .NL(LEDR[9]), .NR(LEDR[7]), .lightOn(LEDR[8]));
	 normalLight LEDR9(.Clock(CLOCK_50), .Reset(reset), .L, .R, .NL(1'b0), .NR(LEDR[8]), .lightOn(LEDR[9]));
	 victory winner(.Clock(CLOCK_50), .Reset(reset), .L, .R, .MostLeft(LEDR[9]), .MostRight(LEDR[1]), .display(HEX0));
	 
endmodule

module DE1_SoC_testbench();

	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	logic CLOCK_50;
	
	DE1_SoC dut (.CLOCK_50, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);

	// Set up the CLOCK_50

	parameter CLOCK_50_PERIOD=100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_50_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end

	// Set up the inputs to the design. Each line is a CLOCK_50 cycle.

	initial begin	
									      @(posedge CLOCK_50);
											@(posedge CLOCK_50);
		SW[9]  <= 1; 					@(posedge CLOCK_50);
		SW[9]  <= 0; 					@(posedge CLOCK_50);
		KEY[3] <= 1; 	KEY[0] <= 1;@(posedge CLOCK_50);
		                           @(posedge CLOCK_50);
		KEY[3] <= 0;KEY[0] <= 0;   @(posedge CLOCK_50);
											@(posedge CLOCK_50);
						KEY[0] <= 0;   @(posedge CLOCK_50);
											@(posedge CLOCK_50);
						KEY[0] <= 1;   @(posedge CLOCK_50);
											@(posedge CLOCK_50);
						KEY[0] <= 0;   @(posedge CLOCK_50);
											@(posedge CLOCK_50);
						KEY[0] <= 1;   @(posedge CLOCK_50);
											@(posedge CLOCK_50);
						KEY[0] <= 0;	@(posedge CLOCK_50);
											@(posedge CLOCK_50);
						KEY[0] <= 1;  	@(posedge CLOCK_50);
											@(posedge CLOCK_50);
						KEY[0] <= 0;	@(posedge CLOCK_50);
											@(posedge CLOCK_50);	
						KEY[0] <= 1;  	@(posedge CLOCK_50);
											@(posedge CLOCK_50);
						KEY[0] <= 0;	@(posedge CLOCK_50);
											@(posedge CLOCK_50);	
						KEY[0] <= 1;  	@(posedge CLOCK_50);
										   @(posedge CLOCK_50);
						KEY[0] <= 0;	@(posedge CLOCK_50);
											@(posedge CLOCK_50);
						KEY[0] <= 1;	@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
						KEY[0] <= 0;	@(posedge CLOCK_50);
											@(posedge CLOCK_50);
						KEY[0] <= 1;	@(posedge CLOCK_50);
					KEY[0] <= 0;			@(posedge CLOCK_50);
											@(posedge CLOCK_50);
	   SW[9]  <= 1; 					@(posedge CLOCK_50);
		SW[9]  <= 0; 					@(posedge CLOCK_50);
		KEY[3] <= 1;	KEY[0] <= 0;@(posedge CLOCK_50);
											@(posedge CLOCK_50);
		KEY[3] <= 0;					@(posedge CLOCK_50);
		KEY[3] <= 1;              	@(posedge CLOCK_50);
		KEY[3] <= 0;					@(posedge CLOCK_50);
		KEY[3] <= 1;              	@(posedge CLOCK_50);
		KEY[3] <= 0;					@(posedge CLOCK_50);
		KEY[3] <= 1;              	@(posedge CLOCK_50);
		KEY[3] <= 0;					@(posedge CLOCK_50);
		KEY[3] <= 1;              	@(posedge CLOCK_50);
		KEY[3] <= 0;					@(posedge CLOCK_50);
		KEY[3] <= 1;              	@(posedge CLOCK_50);
		KEY[3] <= 0;					@(posedge CLOCK_50);
		KEY[3] <= 1;              	@(posedge CLOCK_50);
											@(posedge CLOCK_50);

		$stop;

	end

endmodule 
