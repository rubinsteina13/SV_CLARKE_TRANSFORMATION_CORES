/**
  ***********************************************************************************
  * @file    inv_clarke_module.sv
  * @author  Serhii Yatsenko [royalroad1995@gmail.com]
  * @version V1.0
  * @date    May-2020
  * @brief   Synthesizable Digital Core of the Backward Clarke Transformation.
  *	     Pseudocode:
  *		a_o = al_i;
  *		b_o = (sqrt(3)*be_i-al_i)/2;
  ***********************************************************************************
  * @license
  *
  * MIT License
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
  * in the Software without restriction, including without limitation the rights
  * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  * copies of the Software, and to permit persons to whom the Software is
  * furnished to do so, subject to the following conditions:
  *
  * The above copyright notice and this permission notice shall be included in all
  * copies or substantial portions of the Software.
  *
  * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  *
  ***********************************************************************************
  */

module inv_clarke_module #(
	parameter DATA_WIDTH = 10
)(
	input	logic				clk_i, rst_i,
	input	logic signed [DATA_WIDTH-1:0]	al_i, be_i,
	output	logic signed [DATA_WIDTH-1:0]	a_o, b_o
);
	const	logic signed [DATA_WIDTH:0]	sqrt3 = 
						1.732050807 * (2**(DATA_WIDTH-1)-1);
		logic signed [DATA_WIDTH-1:0]	al_latched, be_latched;
		logic signed [DATA_WIDTH:0]	b;
		logic signed [DATA_WIDTH*2-1:0]	be_mullby_sqrt3;

	always_ff @(posedge clk_i, posedge rst_i) begin
		if(rst_i) begin
			al_latched <= 0;
			be_latched <= 0;
		end else begin
			al_latched <= al_i;
			be_latched <= be_i;
		end
	end

	assign	a_o		= al_latched,
		be_mullby_sqrt3	= sqrt3 * be_latched,
		b 		= signed'(be_mullby_sqrt3[DATA_WIDTH*2-1:DATA_WIDTH-1]) - al_latched,
		b_o		= signed'(b[DATA_WIDTH:1]);

endmodule: inv_clarke_module
