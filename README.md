# Forward & Backward Clarke Transformation Digital IP-Cores

Attention! This Clarke Transformation Digital IP-Cores works in case when A + B + C = 0 only !!! (where A,B,C - input vectors).

* Project structure
	* README.md - current file
	* LICENSE - file with license description
  * forw_clarke_module.sv - Synthesizable Digital IP-Core of the Forward Clarke Transformation
  * inv_clarke_module.sv  - Synthesizable Digital IP-Core of the Backward (Inverse) Clarke Transformation

# Forward Clarke Transformation IP-Core

* User constants
  * DATA_WIDTH - input and output signals bus bit resolution
* Inputs
  * clk_i - clock signal (rising edge is active)
  * rst_i - reset signal (high level is active)
  * a_i   - input vector A
  * b_i   - input vector B
* Outputs
  * al_o  - output vector Alpha
  * be_o  - output vector Beta

# Backward Clarke Transformation IP-Core

* User constants
	* DATA_WIDTH - input and output data bus resolution
* Inputs
	* clk_i - clock signal (rising edge is active)
	* rst_i - reset signal (high level is active)
 	* al_i  - input vector Alpha
 	* be_i  - input vector Beta
* Outputs
 	* a_o   - output vector A
 	* b_o   - output vector B
  
# License
  
[MIT](./LICENSE "License Description")
