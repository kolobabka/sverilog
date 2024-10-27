# System Verilog samples

Personal system verilog examples and small projects

Using verilator 5.020

Build line:

    cmake -DCMAKE_BUILD_TYPE=Release -S . -B build && cmake --build ./build

Contents:

* util -- some handy utils, like result checker
* rmc -- simple tests with system verilog, like readmemb
* combinational -- different comb logic examples and testbench
* muxes -- multiplexors and program-atic testbench

