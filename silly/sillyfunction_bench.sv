module silllyfunction_check(input logic clk);
  logic a, b, c, y, yeta;
  logic [3:0] testvectors[10:0];
  integer vn;

  sillyfunction dut(a, b, c, y);

  initial
    begin
      $readmemb("sillyvectors.txt", testvectors);
      vn = 0;
    end

  // on posedge load test vector and wires
  always @(posedge clk)
    begin
      {a, b, c, yeta} = testvectors[vn];
    end

  // on negedge check results
  always @(negedge clk)
    begin
      if ((y !== yeta) && (vn < 8)) begin
        $display("silly: vn = %d, test failed: %b, expected %b", vn, y, yeta);
        $finish;
      end

      if (vn == 8) begin
        $display("All %d tests passed!", vn);
      end
      vn = vn + 1;
    end
endmodule

module xorfour_check(input logic clk);
  logic y, yeta;
  logic a[3:0];
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
      {a[3], a[2], a[1], a[0], yeta} = testvectors[vn];
    end

  // on negedge check results
  always @(negedge clk)
    begin
      if (y !== yeta) begin
        $display("xor4: vn = %d, test failed: %b, expected %b", vn, y, yeta);
        $finish;
      end

      if (vn == 16) begin
        $display("All %d tests passed!", vn);
        $finish;
      end
      vn = vn + 1;
    end
endmodule

module silllyfunction_bench();
  logic clk;

  // clock for bench
  always
    begin
      clk = 0; #5; clk = 1; #5;
    end

  silllyfunction_check sc(clk);
  xorfour_check xc(clk);

endmodule