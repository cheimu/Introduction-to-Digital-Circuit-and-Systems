module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, GPIO_0);
	 input logic CLOCK_50; // 50MHz CLOCK_50.
	 output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 output logic [9:0] LEDR;
	 input logic [3:0] KEY; // True when not pressed, False when pressed
	 input logic [9:0] SW;
	 output logic [35:0] GPIO_0;
	 logic w;
	 logic start;
	 logic over;
	 logic player;
	 logic [7:0][7:0] red_array, green_array;
	 // Hook up FSM inputs and outputs.
	 logic reset;
	 logic [2:0]  randomNum;
	 
	 // Generate clk off of CLOCK_50, whichClock picks rate.
	 logic [31:0] clk;
	 parameter whichClock = 16;
	 clock_divider cdiv(CLOCK_50, clk);
	 
	 always_ff @(posedge clk[whichClock])
		w <= SW[9];
    always_ff @(posedge clk[whichClock])
	   reset <= w; // Reset when SW[9] is pressed.

	
	 assign HEX3 = 7'b1111111;
	 assign HEX4 = 7'b1111111;
	 assign HEX5 = 7'b1111111;
	 

	 
	
	 userInput  user(.Reset(reset), .Clock(clk[whichClock]), .Input(~KEY[0]), .out(player));
	 gameStart gameActivate(.Clock(clk[whichClock]), .Reset(reset), .Input(player), .start(start));
	 
	 CC l0 (.Clock(clk[whichClock]), .Reset(reset), .Input(player), .gameOver(over), .gameStart(start), .beginningPosition(1'b0), .nu(1'b0), .nd(red_array[0][6]), .light(red_array[0][7]), .limit(1'b1));
	 CC l1 (.Clock(clk[whichClock]), .Reset(reset), .Input(player), .gameOver(over), .gameStart(start), .beginningPosition(1'b0), .nu(red_array[0][7]), .nd(red_array[0][5]), .light(red_array[0][6]), .limit(1'b0));
	 CC l2 (.Clock(clk[whichClock]), .Reset(reset), .Input(player), .gameOver(over), .gameStart(start), .beginningPosition(1'b0), .nu(red_array[0][6]), .nd(red_array[0][4]), .light(red_array[0][5]), .limit(1'b0));
	 CC l3 (.Clock(clk[whichClock]), .Reset(reset), .Input(player), .gameOver(over), .gameStart(start), .beginningPosition(1'b0), .nu(red_array[0][5]), .nd(red_array[0][3]), .light(red_array[0][4]), .limit(1'b0));
	 CC l4 (.Clock(clk[whichClock]), .Reset(reset), .Input(player), .gameOver(over), .gameStart(start), .beginningPosition(1'b1), .nu(red_array[0][4]), .nd(red_array[0][2]), .light(red_array[0][3]), .limit(1'b0));
	 CC l5 (.Clock(clk[whichClock]), .Reset(reset), .Input(player), .gameOver(over), .gameStart(start), .beginningPosition(1'b0), .nu(red_array[0][3]), .nd(red_array[0][1]), .light(red_array[0][2]), .limit(1'b0));
	 CC l6 (.Clock(clk[whichClock]), .Reset(reset), .Input(player), .gameOver(over), .gameStart(start), .beginningPosition(1'b0), .nu(red_array[0][2]), .nd(red_array[0][0]), .light(red_array[0][1]), .limit(1'b0));
	 CC l7 (.Clock(clk[whichClock]), .Reset(reset), .Input(player), .gameOver(over), .gameStart(start), .beginningPosition(1'b0), .nu(red_array[0][1]), .nd(1'b0), .light(red_array[0][0]), .limit(1'b0));
	
    assign red_array[7][7:0] = 8'b00000000;
	 assign red_array[6][7:0] = 8'b00000000;	
	 assign red_array[5][7:0] = 8'b00000000;	
	 assign red_array[4][7:0] = 8'b00000000;	
	 assign red_array[3][7:0] = 8'b00000000;	
	 assign red_array[2][7:0] = 8'b00000000;	
	 assign red_array[1][7:0] = 8'b00000000;	
	 
	 LFSR_3 random(.Clock(clk[whichClock]), .Reset(reset), .Output(randomNum));
	 pipeGenerator pipe0(.Clock(clk[whichClock]), .Reset(reset), .gameStart(start), .gameOver(over), .num(randomNum), .pipe(green_array[7][7:0]));
	 pipeShifter pipe1(.Clock(clk[whichClock]), .Reset(reset), .rightPipe(green_array[7][7:0]), .gameStart(start), .gameOver(over), .pipe(green_array[6][7:0]));
	 pipeShifter pipe2(.Clock(clk[whichClock]), .Reset(reset), .rightPipe(green_array[6][7:0]), .gameStart(start), .gameOver(over), .pipe(green_array[5][7:0]));
	 pipeShifter pipe3(.Clock(clk[whichClock]), .Reset(reset), .rightPipe(green_array[5][7:0]), .gameStart(start), .gameOver(over), .pipe(green_array[4][7:0]));
	 pipeShifter pipe4(.Clock(clk[whichClock]), .Reset(reset), .rightPipe(green_array[4][7:0]), .gameStart(start), .gameOver(over), .pipe(green_array[3][7:0]));
	 pipeShifter pipe5(.Clock(clk[whichClock]), .Reset(reset), .rightPipe(green_array[3][7:0]), .gameStart(start), .gameOver(over), .pipe(green_array[2][7:0]));
	 pipeShifter pipe6(.Clock(clk[whichClock]), .Reset(reset), .rightPipe(green_array[2][7:0]), .gameStart(start), .gameOver(over), .pipe(green_array[1][7:0]));
	 pipeShifter pipe7(.Clock(clk[whichClock]), .Reset(reset), .rightPipe(green_array[1][7:0]), .gameStart(start), .gameOver(over), .pipe(green_array[0][7:0]));
	 
	 logic [7:0] rowsink, redDriver, greenDriver;
	 assign GPIO_0 [35:28] = redDriver;
	 assign GPIO_0 [27:20] = greenDriver;
	 assign GPIO_0 [19:12] = rowsink;
	 led_matrix_driver led_array(.clock(clk[whichClock]), .red_array, .green_array, .red_driver(redDriver), .green_driver(greenDriver), .row_sink(rowsink));
	 logic point;
	 gameOver isOver(.Clock(clk[whichClock]), .Reset(reset), .cc(red_array[0]), .pipe(green_array[0]), .gameStart(start), .point(point), .over(over));
	 
	 logic add0, add1, add2;
	 scoreReport display0(.Clock(clk[whichClock]), .Reset(reset), .gameStart(start), .beginning(7'b1000000), .increment(point), .display(HEX0[6:0]), .addOne(add0));
	 scoreReport display1(.Clock(clk[whichClock]), .Reset(reset), .gameStart(start), .beginning(7'b1000000), .increment(add0), .display(HEX1[6:0]), .addOne(add1));
	 scoreReport display2(.Clock(clk[whichClock]), .Reset(reset), .gameStart(start), .beginning(7'b1000000), .increment(add1), .display(HEX2[6:0]), .addOne(add2));
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

	logic	clk;

	logic  [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

	logic  [9:0] LEDR;

	logic   [3:0] KEY;

	logic   [9:0] SW;

	logic	[35:0] GPIO_0;

	

	DE1_SoC dut (clk, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW, GPIO_0);

	

	// Set up the clock.

	parameter CLOCK_PERIOD=100;

	initial clk=1;

	always begin

		#(CLOCK_PERIOD/2);

		clk = ~clk;

	end

	

	initial begin

		SW[9] <= 1;	KEY[0] <= 1;	@(posedge clk);

						KEY[0] <= 0;	@(posedge clk);

		SW[9] <= 0;						@(posedge clk);

						KEY[0] <= 1;	@(posedge clk);

											@(posedge clk);

						KEY[0] <= 0;	@(posedge clk);

						KEY[0] <= 1;	@(posedge clk);

						KEY[0] <= 0;	@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

											@(posedge clk);

		$stop;

	end

endmodule 
