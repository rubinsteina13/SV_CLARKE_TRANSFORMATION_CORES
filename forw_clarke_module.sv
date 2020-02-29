//********************************************************************************
// SystemVerilog module of the
// Forward Clarke Transformation (Synthesizable Digital Core)
// Pseudocode: al_o = a_i; be_o = (a_i+2*b_i)/sqrt(3);
//********************************************************************************
module forw_clarke_module #(
	parameter DATA_WIDTH = 16
)(
	input	logic							clk_i, rst_i,
	input	logic signed [DATA_WIDTH-1:0]	a_i, b_i,
	output	logic signed [DATA_WIDTH-1:0]	al_o, be_o
);
	const	logic signed [DATA_WIDTH-1:0]	one_div_sqrt3 = 0.577350269 * (2**(DATA_WIDTH-1)-1);
			logic signed [DATA_WIDTH-1:0]	a_latched, b_latched;
			logic signed [DATA_WIDTH:0]		a_plus_2b;
			logic signed [DATA_WIDTH*2-2:0]	be;

	always_ff @(posedge clk_i, posedge rst_i) begin
		if(rst_i) begin
			a_latched <= 0;
			b_latched <= 0;
		end else begin
			a_latched <= a_i;
			b_latched <= b_i;
		end
	end

	assign	al_o		= a_latched,
			a_plus_2b	= a_latched + signed'({b_latched, 1'b0}),
			be			= a_plus_2b * one_div_sqrt3,
			be_o		= be[DATA_WIDTH*2-2:DATA_WIDTH-1];
			
endmodule: forw_clarke_module
