// Harris and Harris excercise 4.3
module xorfour(input logic[3:0] a,
               output logic y);
  assign y = ^a;
endmodule;
