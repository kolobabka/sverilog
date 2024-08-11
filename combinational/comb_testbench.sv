//-----------------------------------------------------------------------------
//
// Combinatorial logic testbench
//
// top module: comb_testbench
//
//-----------------------------------------------------------------------------

// the only way I found to make generic function
// is to make generic module and function inside it
module util#(parameter int W = 3)();
  // check function for tests
  function void check(integer vn, logic [W:0] y, logic [W:0] yeta);
    if (y !== yeta) begin
      $display("vn = %d, test failed: %b, expected %b", vn, y, yeta);
      $finish;
    end
  endfunction
endmodule

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
  always @(posedge clk)
    begin
      {a[3:0], yeta} = testvectors[vn];
    end

  // on negedge check results
  always @(negedge clk)
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

// ad-hoc testbench part for muxes
module mux4_check();
  logic[3:0] d0 = 4'h0, d1 = 4'h1, d2 = 4'h2, d3 = 4'h3;
  logic[3:0] y, ys, yss;
  logic[1:0] s;
  integer vn;

  mux4 dut(d0, d1, d2, d3, s, y);
  mux4s duts(d0, d1, d2, d3, s, ys);
  mux4ss dutss(d0, d1, d2, d3, s, yss);

  util#(3) u();

  initial
    begin
      vn = 0;
      repeat(4) begin
        s = 2'(vn & 'h3); // 00, 01, 10, 11
        #10
        u.check(vn, y, ys);
        u.check(vn, y, yss);
        vn = vn + 1;
      end
      $display("mux: all %d tests passed!", vn);
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
  mux4_check mc();

  // finish on max counter
  initial
    begin
      #10000;
      $finish;
    end
endmodule