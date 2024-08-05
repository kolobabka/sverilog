module silllyfunction_bench();

  logic clk, reset;
  logic a, b, c, y, yeta;
  logic [3:0] testvectors[10:0];
  integer vn;

  sillyfunction dut(a, b, c, y);

  // clock for bench
  always
    begin
      clk = 0; #5; clk = 1; #5;
    end

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
      if (y !== yeta) begin
        $display("vn = %d, test failed %b: %b, expected %b", vn, {a, b, c}, y, yeta);
        $finish;
      end

      if (testvectors[vn] === 4'b1110) begin
        $display("All %d tests passed!", vn);
        $finish;
      end
      vn = vn + 1;
    end

endmodule
