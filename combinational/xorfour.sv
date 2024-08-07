// Harris and Harris excercise 4.3
module xorfour(input logic a[3:0],
               output logic y);
  assign y = (a[0] ^ a[1]) ^ (a[2] ^ a[3]);
endmodule;
