module top;
  readmem_check rmc();
  randomize rnd();

  // finish on max counter
  initial
    begin
      #10000;
      $finish;
    end
endmodule