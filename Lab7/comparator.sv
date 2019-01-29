module comparator(numA, numB, result);
	input logic [9:0] numA, numB;
	output logic result;
	
	always_comb 
		if (numA > numB) result = 1'b1;
		else result = 1'b0;
		
endmodule

module comparator_testbench();

	logic [9:0] numA, numB;
	logic result;

	comparator dut (.numA, .numB, .result);
	
	// Try all combinations of inputs.
	integer i;
	integer j;
	initial begin
		for(i = 0; i < 256; i++) begin
			numA[9:0] = i; #2;
			for(j = 0; j < 256; j++) begin
				numB[9:0] = j; #2;
			end
		end
	end
	
endmodule