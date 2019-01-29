module pipeGenerator(Clock, Reset, gameStart, gameOver, num, pipe);

	input logic Clock, Reset, gameStart, gameOver;
	input logic [2:0] num;
	logic [1:0] gap;
	logic [7:0] ps, ns;
	logic [7:0] count;
	output logic [7:0] pipe;
	

	always_comb
		if (gameOver)
			ns = ps;
		else begin
			if (gap == 0)
				case(num)
					3'b000: ns = 8'b10011111;
					3'b001: ns = 8'b11000111;
					3'b010: ns = 8'b11100011;
					3'b011: ns = 8'b10000001;
					3'b100: ns = 8'b11000011;
					3'b101: ns = 8'b10011111;
					3'b110: ns = 8'b00001111;
					3'b111: ns = 8'b10000011;
					default: ns = 8'b00000000;
				endcase
			else
				ns = 8'b00000000;
		end
	assign pipe = ps;
	always_ff @(posedge Clock)
		if (Reset | ~gameStart) begin 
			gap <= 0;
			ps <= 8'b00000000;
			count <= 8'b00000000;
		end
		else begin
			if	(count == 0) begin 
				
				ps <= ns;
				gap <= gap + 2'b01;
			end
			count <= count + 8'b00000001;
		end		
		
endmodule

module pipeGenerator_testbench();

	logic Clock, Reset, gameStart, gameOver;

	logic [2:0] num;

	logic [7:0] pipe;

	

	pipeGenerator dut(Clock, Reset, gameStart, gameOver, num, pipe);

	

	// Set up the clock

	parameter CLOCK_PERIOD=100;

	initial Clock=1;

	always begin

		#(CLOCK_PERIOD/2);

		Clock = ~Clock;

	end

	

	initial begin

		Reset <= 1;	gameStart <= 0;	num <= 3'b010;	@(posedge Clock);

		Reset <= 0;											@(posedge Clock);

						gameStart <= 1;						@(posedge Clock);

											num <= 3'b000;	@(posedge Clock);

																@(posedge Clock);

																@(posedge Clock);

																@(posedge Clock);

											num <= 3'b001;	@(posedge Clock);

																@(posedge Clock);

																@(posedge Clock);

																@(posedge Clock);

																@(posedge Clock);

											num <= 3'b010;	@(posedge Clock);

																@(posedge Clock);

																@(posedge Clock);

																@(posedge Clock);

																@(posedge Clock);

											num <= 3'b011;	@(posedge Clock);

																@(posedge Clock);

																@(posedge Clock);

																@(posedge Clock);

																@(posedge Clock);

											num <= 3'b100;	@(posedge Clock);

																@(posedge Clock);

																@(posedge Clock);

																@(posedge Clock);

																@(posedge Clock);

											num <= 3'b101;	@(posedge Clock);

																@(posedge Clock);

																@(posedge Clock);

																@(posedge Clock);

																@(posedge Clock);

											num <= 3'b110;	@(posedge Clock);

																@(posedge Clock);

																@(posedge Clock);

																@(posedge Clock);

																@(posedge Clock);

											num <= 3'b111;	@(posedge Clock);

																@(posedge Clock);

																@(posedge Clock);

																@(posedge Clock);

						gameOver <= 1;		num <= 3'b110;	@(posedge Clock);

																@(posedge Clock);

																@(posedge Clock);

																@(posedge Clock);

																@(posedge Clock);

		$stop;

	end

endmodule