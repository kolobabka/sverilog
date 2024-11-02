//-----------------------------------------------------------------------------
//
// Harris and Harris style testbench (rather questionable)
//
//-----------------------------------------------------------------------------

module xorfour_tb(input logic clk, y, output logic [3:0] a);
  logic yeta;
  logic [4:0] testvectors[15:0];
  integer vn; 

  initial
    begin
      $readmemb("xor4vectors.txt", testvectors);
      vn = 0;
    end

  // on posedge load test vector and wires
  always_ff @(posedge clk)
    begin
      {a[3:0], yeta} = testvectors[vn];
    end

  // on negedge check results
  always_ff @(negedge clk)
    begin
      u.check(vn, y, yeta);
      if (vn == 16) begin
        $display("Xor4: all %d tests passed!", vn);
      end
      vn = vn + 1;
    end
endmodule


module xorfour_top();
  logic clk;
  logic y, yeta;
  logic [3:0] a;

  // clock for bench
  always
    begin
      clk = 0; #5; clk = 1; #5;
    end

  util#(0) u();
  xorfour dut(a, y);
  xorfour_tb xc(clk, y, a);

  // finish on max counter
  initial
    begin
      #10000;
      $finish;
    end
endmodule
