module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR,
SW);
	 input logic CLOCK_50; // 50MHz CLOCK_50.
	 output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 output logic [9:0] LEDR;
	 input logic [3:0] KEY; // True when not pressed, False when pressed
	 input logic [9:0] SW;
	 logic L, R;
	 logic w;
	 logic cyberResult;
	 // Hook up FSM inputs and outputs.
	 logic reset, resetPlayfield, resetLight;
	 logic [9:0] num, randomNum;
	 
	 // Generate clk off of CLOCK_50, whichClock picks rate.
	 logic [31:0] clk;
	 parameter whichClock = 15;
	 clock_divider cdiv(CLOCK_50, clk);
	 
	 always_ff @(posedge clk[whichClock])
		w <= SW[9];
    always_ff @(posedge clk[whichClock])
	   reset <= w; // Reset when SW[9] is pressed.

	 assign resetLight = reset | resetPlayfield;
	 
	 assign num[9] = 1'b0;
	 assign num[8:0] = SW[8:0];
	 LFSR_10 random(.Clock(clk[whichClock]), .Reset(reset), .Output(randomNum));
	 comparator cyber(.numA(num), .numB(randomNum), .result(cyberResult));
	 
	 
	 assign HEX2 = 7'b1111111;
	 assign HEX3 = 7'b1111111;
	 assign HEX4 = 7'b1111111;
	 assign HEX5 = 7'b1111111;
	 
	 
	
	 userInput leftButton(.Reset(reset), .Clock(clk[whichClock]), .Input(cyberResult), .out(L));
	 userInput rightButton(.Reset(reset), .Clock(clk[whichClock]), .Input(~KEY[0]), .out(R));
	 
	 normalLight LEDR1(.Clock(clk[whichClock]), .Reset(resetLight), .L, .R, .NL(LEDR[2]), .NR(1'b0), .lightOn(LEDR[1]));
	 normalLight LEDR2(.Clock(clk[whichClock]), .Reset(resetLight), .L, .R, .NL(LEDR[3]), .NR(LEDR[1]), .lightOn(LEDR[2]));
	 normalLight LEDR3(.Clock(clk[whichClock]), .Reset(resetLight), .L, .R, .NL(LEDR[4]), .NR(LEDR[2]), .lightOn(LEDR[3]));
	 normalLight LEDR4(.Clock(clk[whichClock]), .Reset(resetLight), .L, .R, .NL(LEDR[5]), .NR(LEDR[3]), .lightOn(LEDR[4]));
	 centerLight LEDR5(.Clock(clk[whichClock]), .Reset(resetLight), .L, .R, .NL(LEDR[6]), .NR(LEDR[4]), .lightOn(LEDR[5]));
	 normalLight LEDR6(.Clock(clk[whichClock]), .Reset(resetLight), .L, .R, .NL(LEDR[7]), .NR(LEDR[5]), .lightOn(LEDR[6]));
	 normalLight LEDR7(.Clock(clk[whichClock]), .Reset(resetLight), .L, .R, .NL(LEDR[8]), .NR(LEDR[6]), .lightOn(LEDR[7]));
	 normalLight LEDR8(.Clock(clk[whichClock]), .Reset(resetLight), .L, .R, .NL(LEDR[9]), .NR(LEDR[7]), .lightOn(LEDR[8]));
	 normalLight LEDR9(.Clock(clk[whichClock]), .Reset(resetLight), .L, .R, .NL(1'b0), .NR(LEDR[8]), .lightOn(LEDR[9]));
	 victory winner(.Clock(clk[whichClock]), .Reset(reset), .ResetPlayfield(resetPlayfield), .L, .R, .MostLeft(LEDR[9]), .MostRight(LEDR[1]), .displayHuman(HEX0), .displayCyber(HEX1));
	 
endmodule

	// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz,
	// [25] = 0.75Hz, ... 
module clock_divider (clock, divided_clocks);
	input logic clock;
	output logic [31:0] divided_clocks;

	initial
		divided_clocks <= 0;

	always_ff @(posedge clock)
		divided_clocks <= divided_clocks + 1;
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
		SW[9]  <= 1; 													@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
		SW[9]  <= 0; SW[8:0] <= 9'b001001000;					@(posedge CLOCK_50);
		KEY[0] <= 1;													@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
		KEY[0] <= 0;  				  									@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
						KEY[0] <= 0;   								@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
						KEY[0] <= 1;   								@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
						KEY[0] <= 0;  									@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
						KEY[0] <= 1;   								@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
						KEY[0] <= 0;									@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
						KEY[0] <= 1;  									@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
						KEY[0] <= 0;									@(posedge CLOCK_50);
																			@(posedge CLOCK_50);	
						KEY[0] <= 1;  									@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
						KEY[0] <= 0;									@(posedge CLOCK_50);
																			@(posedge CLOCK_50);	
						KEY[0] <= 1;  									@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
						KEY[0] <= 0;									@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
						KEY[0] <= 1;									@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
						KEY[0] <= 0;									@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
						KEY[0] <= 1;									@(posedge CLOCK_50);
					KEY[0] <= 0;										@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
	   SW[9]  <= 1; 													@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																		   @(posedge CLOCK_50);	
																			@(posedge CLOCK_50);
		SW[9]  <= 0; 	SW[8:0] = 9'b000000100;					@(posedge CLOCK_50);
		KEY[0] <= 0;													@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
		KEY[0] <= 0;													@(posedge CLOCK_50);
		KEY[0] <= 1;              									@(posedge CLOCK_50);
		KEY[0] <= 0;													@(posedge CLOCK_50);
		KEY[0] <= 1;              									@(posedge CLOCK_50);
		KEY[0] <= 0;													@(posedge CLOCK_50);
		KEY[0] <= 1;              									@(posedge CLOCK_50);
		KEY[0] <= 0;													@(posedge CLOCK_50);
		KEY[0] <= 1;              									@(posedge CLOCK_50);
		KEY[0] <= 0;													@(posedge CLOCK_50);
		KEY[0] <= 1;              									@(posedge CLOCK_50);
		KEY[0] <= 0;													@(posedge CLOCK_50);
		KEY[0] <= 1;              									@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			@(posedge CLOCK_50);
																			

		$stop;

	end

endmodule 
