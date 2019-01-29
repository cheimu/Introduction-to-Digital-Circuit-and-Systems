module pipeShifter(Clock, Reset, rightPipe, gameStart, gameOver, pipe);
	input logic Clock, Reset, gameStart, gameOver;
	input logic [7:0] rightPipe;
	logic [7:0] count;
	logic [7:0] ps, ns;
	
	output logic [7:0] pipe;
	
	always_comb
		if (gameOver)
			ns = ps;
		else
			ns = rightPipe;
	assign pipe = ps;
	always_ff @(posedge Clock)
		if (Reset | !gameStart) begin
			ps <= 8'b00000000;
			count <= 0;
		end
		else begin
		
			if (count == 0) ps <= ns;
			
			count <= count + 8'b00000001;
		end
endmodule

module pipeShifter_testbench();

	logic Clock, Reset,gameStart, gameOver;

	logic [7:0] rightPipe;

	logic [7:0] pipe;

	

	pipeShifter dut(Clock, Reset, rightPipe, gameStart, gameOver, pipe);

	

	// Set up the clock.

	parameter CLOCK_PERIOD=100;

	initial Clock=1;

	always begin

		#(CLOCK_PERIOD/2);

		Clock = ~Clock;

	end

	

	initial begin

		Reset <= 1;	gameStart <= 0;	rightPipe <= 8'b10100110;	@(posedge Clock);

		Reset <= 0;													@(posedge Clock);

						gameStart <= 1;								@(posedge Clock);

											rightPipe <= 8'b11010101;	@(posedge Clock);

						gameOver <= 1;		rightPipe <= 8'b11010111;	@(posedge Clock);

																		@(posedge Clock);

		$stop;

	end

endmodule