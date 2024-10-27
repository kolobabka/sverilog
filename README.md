# System Verilog samples

Personal system verilog examples and small projects

Using verilator 5.020

Build line:

    cmake -DCMAKE_BUILD_TYPE=Release -S . -B build && cmake --build ./build

Contents (in order of teaching):

* rmc -- simple tests with system verilog, like readmemb
* util -- some handy utils, like result checker
* combinational -- different comb logic examples and testbench
* muxes -- experiments with multiplexors
* latches -- experiments with latches

