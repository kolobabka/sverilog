//-----------------------------------------------------------------------------
//
// Different verilog experiments, top module
//
//-----------------------------------------------------------------------------

module top;
  readmem_check rmc();
  randomize rnd();
  forloop_check frl();
  dynarr_check dac();

  // finish on max counter
  initial
    begin
      #10000;
      $finish;
    end
endmodule