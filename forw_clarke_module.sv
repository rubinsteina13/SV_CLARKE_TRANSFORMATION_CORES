/**
  ***********************************************************************************
  * @file    forw_clarke_module.sv
  * @author  Serhii Yatsenko [royalroad1995@gmail.com]
  * @version V1.0
  * @date    May-2020
  * @brief   Synthesizable Digital Core of the Forward Clarke Transformation.
  *	     Pseudocode:
  *		al_o = a_i;
  *		be_o = (a_i+2*b_i)/sqrt(3);
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

module forw_clarke_module #(
	parameter DATA_WIDTH = 10
)(
	input	logic				clk_i, rst_i,
	input	logic signed [DATA_WIDTH-1:0]	a_i, b_i,
	output	logic signed [DATA_WIDTH-1:0]	al_o, be_o
);
	const	logic signed [DATA_WIDTH-1:0]	one_div_sqrt3 = 
						0.577350269 * (2**(DATA_WIDTH-1)-1);
		logic signed [DATA_WIDTH-1:0]	a_latched, b_latched;
		logic signed [DATA_WIDTH:0]	a_plus_2b;
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
		be		= a_plus_2b * one_div_sqrt3,
		be_o		= signed'(be[DATA_WIDTH*2-2:DATA_WIDTH-1]);
			
endmodule: forw_clarke_module
