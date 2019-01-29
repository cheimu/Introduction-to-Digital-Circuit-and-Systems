module gameOver(Clock, Reset, cc, pipe, gameStart, point, over);

	input logic Clock, Reset, gameStart;
	input logic [7:0] cc, pipe;
	
	logic nscc, pscc;
	logic [7:0] nsp, psp;
	output logic over, point;
	
	always_comb begin
		nscc = cc[0] 
					| (cc[7] & pipe[7])
					| (cc[6] & pipe[6])
					| (cc[5] & pipe[5])
					| (cc[4] & pipe[4])
					| (cc[3] & pipe[3])
					| (cc[2] & pipe[2])
					| (cc[1] & pipe[1]);
		nsp = pipe;
	end
	
	assign over = pscc;
	assign point = ~(psp == 8'b00000000) & (pipe == 8'b00000000);
	
	always_ff @(posedge Clock)
		if (Reset | !gameStart) begin
			pscc <= 1'b0;
			psp <= 8'b00000000;
	   end
		else begin
			pscc <= nscc;
			psp <= nsp;
		end
endmodule

module gameOver_testbench();

	logic	Clock, Reset, cc, pipe, gameStart, point;

	logic over;


	

	gameOver dut (Clock, Reset, cc, pipe, gameStart, point, over);

	

	// Set up the clock.

	parameter CLOCK_PERIOD=100;

	initial Clock=1;

	always begin

		#(CLOCK_PERIOD/2);

		Clock = ~Clock;

	end

	

	initial begin

		Reset <= 1; gameStart <= 0;

			cc <= 8'b00010000;	pipe <= 8'b1111111; 	@(posedge Clock);

		Reset <= 0;														@(posedge Clock);

						gameStart <= 1;									@(posedge Clock);

											pipe <= 8'b11001111;	@(posedge Clock);

											pipe <= 8'b00000000;	@(posedge Clock);

											pipe <= 8'b11111001;	@(posedge Clock);

			cc <= 8'b00000001;									@(posedge Clock);

		Reset <= 1;														@(posedge Clock);

																			@(posedge Clock);

		$stop;

	end

endmodule 