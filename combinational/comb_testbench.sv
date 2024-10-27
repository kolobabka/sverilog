//-----------------------------------------------------------------------------
//
// Combinatorial logic testbench
//
// top module: comb_testbench
//
//-----------------------------------------------------------------------------

// first approach to testbench: repeat with #10 wait
module silllyfunction_check();
  logic a, b, c, y, yeta;
  logic [3:0] testvectors[7:0];
  integer vn;

  sillyfunction dut(a, b, c, y);  
  util#(0) u();

  initial
    begin
      $readmemb("sillyvectors.txt", testvectors);
      vn = 0;
      repeat(8) begin
        {a, b, c, yeta} = testvectors[vn];
        #10;
        u.check(vn, y, yeta);
        vn = vn + 1;
      end
      $display("Silly: all %d tests passed!", vn);
    end
endmodule

// second approach to testbench: external clock
module xorfour_check(input logic clk);
  logic y, yeta;
  logic [3:0] a;
  logic [4:0] testvectors[15:0];
  integer vn;

  xorfour dut(a, y);
  util#(0) u();

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

module gates_check();
  logic [3:0] a, b;
  logic [3:0] yinv, yand, yor, yxor, ynand, ynor;
  logic [3:0] einv, eand, eor, exor, enand, enor;
  logic [31:0] testvectors[255:0];
  integer vn;

  gates dut(a, b, yinv, yand, yor, yxor, ynand, ynor);
  util#(3) u();

  initial
    begin
      $readmemb("gatevectors.txt", testvectors);
      vn = 0;
      repeat(256) begin
        {a, b, einv, eand, eor, exor, enand, enor} = testvectors[vn];
        #10;
        u.check(vn, yinv, einv);
        u.check(vn, yand, eand);
        u.check(vn, yor, eor);
        u.check(vn, yxor, exor);
        u.check(vn, ynand, enand);
        u.check(vn, ynor, enor);
        vn = vn + 1;
      end
      $display("Gates: all %d tests passed!", vn);
    end
endmodule

module and8_check();
  logic [7:0] a; 
  logic y, yeta;
  logic [8:0] testvectors[255:0];
  integer vn;

  and8 dut(a, y);
  util#(0) u();

  initial
    begin
      $readmemb("and8vectors.txt", testvectors);
      vn = 0;
      repeat(256) begin
        {a[7:0], yeta} = testvectors[vn];
        #10;
        u.check(vn, y, yeta);
        vn = vn + 1;
      end
      $display("And8: all %d tests passed!", vn);
    end
endmodule

module comb_testbench();
  logic clk;

  // clock for bench
  always
    begin
      clk = 0; #5; clk = 1; #5;
    end

  silllyfunction_check sc();
  xorfour_check xc(clk);
  and8_check a8c();
  gates_check gc();

  // finish on max counter
  initial
    begin
      #10000;
      $finish;
    end
endmodule