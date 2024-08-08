// Harris and Harris example 4.4
module and8(input logic[7:0] a,
            output logic y);
  assign y = &a;
endmodule;
