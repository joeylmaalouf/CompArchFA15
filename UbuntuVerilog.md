# Using Verilog on Ubuntu


### INSTALLATION

`sudo apt-get install verilog iverilog gtkwave`

* `verilog` is the language
* `iverilog` is the compiler
* `gtkwave` is a graphical wave viewer... I'm not sure exactly what it does, but `iverilog` recommends it and I think we might need it later in the course


### USAGE

Compile a `.v` file to an executable:

`iverilog hw1.v -o hw1`

Run the executable:

`vvp hw1` or `./hw1`

Pipe the output of the executable to a `.txt` file instead of `STDOUT`:

`vvp hw1 > results.txt`

I have not yet figured out `.do` files.