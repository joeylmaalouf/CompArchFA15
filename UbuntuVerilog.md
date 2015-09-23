# Using Verilog on Ubuntu


### INSTALLATION

`sudo apt-get install verilog iverilog gtkwave`

* `verilog` is the language
* `iverilog` is the compiler
* `gtkwave` is a graphical wave viewer


### USAGE

Compile a `.v` file to an executable:

`iverilog hw1.v -o hw1`

Run the executable:

`vvp hw1` or `./hw1`

Pipe the output of the executable to a `.txt` file instead of `STDOUT`:

`vvp hw1 > results.txt`

View waves of a given module:

* Insert the following code after the module's `initial begin`:
```
    $dumpfile("wavefile.vcd");
    $dumpvars(0, moduleName);
```
* `gtkwave wavefile.vcd`
* Add wires from the left side of the screen and zoom to the timescale you want

`.do` files are ModelSim's particular style of batch file for automating things, which we can replicate with `.sh` scripts.
