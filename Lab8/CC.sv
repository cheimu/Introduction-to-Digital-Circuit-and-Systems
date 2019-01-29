module CC(Clock, Reset, Input, gameOver, gameStart, beginningPosition, nu, nd, light, limit);
	input logic Clock, Reset, Input, gameOver, gameStart, beginningPosition, nu, nd, limit;
	logic ns;
	output logic light;
	logic [6:0] count;
	always_comb	
		if (gameOver) 
			ns = light;
		else begin
			case(light)
				1'b0: if ((Input & nd) | (~Input & nu)) ns = 1'b1;
						else ns = 1'b0;
				1'b1: if (limit & Input) ns = 1'b1;
						else ns = 1'b0;
			endcase
		end
		
	always_ff @(posedge Clock)
		if (Reset | !gameStart) begin
			light <= beginningPosition;
			count <= 6'b000000;
		end
		else begin 
			if (count == 0) light <= ns;
			count <= count + 6'b000001;
	   end
		
			
endmodule

module CC_testbench();

	logic Clock, Reset, Input, gameOver, gameStart, beginningPosition, nu, nd, limit;



	logic light;

	

	CC dut(Clock, Reset, Input, gameOver, gameStart, beginningPosition, nu, nd, light, limit);

	

	// Set up the clock.

	parameter CLOCK_PERIOD=100;

	initial Clock=1;

	always begin

		#(CLOCK_PERIOD/2);

		Clock = ~Clock;

	end

	

	initial begin

		Reset <= 1;	gameStart <= 0;

		limit <= 0;	gameOver <= 0;		nu <= 0;	nd <= 0;

						beginningPosition <= 1;								@(posedge Clock);

						beginningPosition <= 0;								@(posedge Clock);

						Input <= 1;				nd <= 1;	@(posedge Clock);

		

		Reset <= 0;											@(posedge Clock);

						Input <= 0;							@(posedge Clock);

						Input <= 1;							@(posedge Clock);

		gameStart <= 1;										@(posedge Clock);

													nd <= 0;	@(posedge Clock);

										nu <= 1;				@(posedge Clock);

						Input <= 0;							@(posedge Clock);

										nu <= 0;				@(posedge Clock);

													nd <= 1;	@(posedge Clock);

													

			limit <= 1; Input <= 1;							@(posedge Clock);

													nd <= 0;	@(posedge Clock);

			gameOver <= 1;										@(posedge Clock);

						Input <= 0;							@(posedge Clock);

																@(posedge Clock);

		$stop;

	end

endmodule			