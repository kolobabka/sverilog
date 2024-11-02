//-----------------------------------------------------------------------------
//
// Combinatorial logic testbench
//
// simplest testbench based on modules
//
//-----------------------------------------------------------------------------

module silllyfunction_check(output logic a, b, c, input logic y);
  logic yeta;
  logic [3:0] testvectors[7:0];
  integer vn;

  initial
    begin
      $readmemb("sillyvectors.txt", testvectors);
      vn = 0;
      repeat(8) begin
        {a, b, c, yeta} = testvectors[vn];
        #10;
        comb_testbench.u.check(vn, y, yeta);
        vn = vn + 1;
      end
      $display("Silly: all %d tests passed!", vn);
    end
endmodule

module gates_check(output logic [3:0] a, b, input logic [3:0] yinv, yand, yor, yxor, ynand, ynor);
  logic [3:0] einv, eand, eor, exor, enand, enor;
  logic [31:0] testvectors[255:0];
  integer vn;

  initial
    begin
      $readmemb("gatevectors.txt", testvectors);
      vn = 0;
      repeat(256) begin
        {a, b, einv, eand, eor, exor, enand, enor} = testvectors[vn];
        #10;
        comb_testbench.u3.check(vn, yinv, einv);
        comb_testbench.u3.check(vn, yand, eand);
        comb_testbench.u3.check(vn, yor, eor);
        comb_testbench.u3.check(vn, yxor, exor);
        comb_testbench.u3.check(vn, ynand, enand);
        comb_testbench.u3.check(vn, ynor, enor);
        vn = vn + 1;
      end
      $display("Gates: all %d tests passed!", vn);
    end
endmodule

module and8_check(output logic [7:0] a, input logic y);
  logic yeta;
  logic [8:0] testvectors[255:0];
  integer vn;

  initial
    begin
      $readmemb("and8vectors.txt", testvectors);
      vn = 0;
      repeat(256) begin
        {a[7:0], yeta} = testvectors[vn];
        #10;
        comb_testbench.u.check(vn, y, yeta);
        vn = vn + 1;
      end
      $display("And8: all %d tests passed!", vn);
    end
endmodule

module comb_testbench();
  logic sa, sb, sc, sy;
  logic [3:0] ga, gb, gyinv, gyand, gyor, gyxor, gynand, gynor;
  logic [7:0] aa;
  logic ay;

  util#(0) u();
  sillyfunction sfdut(sa, sb, sc, sy);
  silllyfunction_check sfc(sa, sb, sc, sy);

  util#(3) u3();
  gates gdut(ga, gb, gyinv, gyand, gyor, gyxor, gynand, gynor);
  gates_check gac(ga, gb, gyinv, gyand, gyor, gyxor, gynand, gynor);

  and8 adut(aa, ay);
  and8_check a8c(aa, ay);

  // finish on max counter
  initial
    begin
      #10000;
      $finish;
    end
endmodule