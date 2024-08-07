// first approach to testbench: repeat with #10 wait
module silllyfunction_check();
  logic a, b, c, y, yeta;
  logic [3:0] testvectors[7:0];
  integer vn;

  sillyfunction dut(a, b, c, y);

  initial
    begin
      $readmemb("sillyvectors.txt", testvectors);
      vn = 0;
      repeat(8) begin
        {a, b, c, yeta} = testvectors[vn];
        #10;
        if ((y !== yeta) && (vn < 8)) begin
          $display("silly: vn = %d, test failed: %b, expected %b", vn, y, yeta);
          $finish;
        end
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

  xorfour xf(a, y);

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
      if (y !== yeta) begin
        $display("xor4: vn = %d, test failed: %b, expected %b", vn, y, yeta);
        $finish;
      end

      if (vn == 16) begin
        $display("Xor4: all %d tests passed!", vn);
        $finish;
      end
      vn = vn + 1;
    end
endmodule

module gates_check(input logic clk);
  logic [3:0] a, b;
  logic [3:0] yinv, yand, yor, yxor, ynand, ynor;
  logic [3:0] einv, eand, eor, exor, enand, enor;
  logic [31:0] testvectors[255:0];
  integer vn;

  gates dut(a, b, yinv, yand, yor, yxor, ynand, ynor);

  initial
    begin
      $readmemb("gatevectors.txt", testvectors);
      vn = 0;
      repeat(8) begin
        {a, b, einv, eand, eor, exor, enand, enor} = testvectors[vn];
        #10;
        if (yinv !== einv) begin
          $display("gates: vn = %d, test failed: %b, expected %b", vn, yinv, einv);
          $finish;
        end
        vn = vn + 1;
      end
      $display("Gates: all %d tests passed!", vn);
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
  gates_check gc(clk);

endmodule