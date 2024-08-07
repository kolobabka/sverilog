module xorfour(input logic a[3:0],
               output logic y);
  assign y = ^a;
endmodule;

module bench();
  logic clk;
  logic a[3:0];
  logic yeta = 0;
  logic y;
  integer vn;

  xorfour xc(a, y);

  always
    begin
      clk = 0; #5; clk = 1; #5;
    end

  initial
    begin
      vn = 0;
    end

  always @(posedge clk)
    begin
      a[3:0] = {0, 0, 0, 0};
      yeta = 0;
    end

  // on negedge check results
  always @(negedge clk)
    begin
      if (y !== yeta) begin
        $display("test failed: %b, expected %b", y, yeta);
        $finish;
      end

      if (vn == 8) begin
        $display("All %d tests passed!", vn);
      end
      vn = vn + 1;
    end
endmodule