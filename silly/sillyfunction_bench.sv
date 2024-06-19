module silllyfunction_bench();

  logic clk, reset;
  logic a, b, c, y, yeta;
  logic [3:0] testvectors[10:0];
  integer vn;

  sillyfunction dut(a, b, c, y);

  // clock for bench
  always
    begin
      clk = 1; #5; clk = 0; #5;
    end

  initial
    begin
      $readmemb("sillyvectors.txt", testvectors);
      vn = 0;
      reset = 1; #22; reset = 0;
    end

  // on posedge load test vector and wires
  always @(posedge clk)
    begin
      #1;
      {a, b, c, yeta} = testvectors[vn];
    end

  // on negedge check results
  always @(negedge clk)
    if (~reset) begin
      if (y !== yeta) begin
        $display("Test failed %b: %b, expected %b", {a, b, c}, y, yeta);
        $finish;
      end
      vn = vn + 1;

      // xxxx marks end of file
      if (testvectors[vn] === 4'bx) begin
        $display("All %d tests passed!", vn);
        $finish;
      end
    end

endmodule
