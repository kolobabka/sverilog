//-----------------------------------------------------------------------------
//
// Muxes testbench
//
// playing with program. Note: no artificial $finish.
//
//-----------------------------------------------------------------------------

program automatic mux_testbench(input logic[3:0] y, ys, yss,
                                output logic[1:0] s,
                                output logic[3:0] d0, d1, d2, d3);
  integer vn;
  initial
    begin
      d0 = 4'h0; d1 = 4'h1; d2 = 4'h2; d3 = 4'h3;

      vn = 0;
      repeat(4) begin
        s = 2'(vn & 'h3); // 00, 01, 10, 11
        #10
        mux_top.u.check(vn, y, ys);
        mux_top.u.check(vn, y, yss);
        vn = vn + 1;
      end
      $display("mux: all %d tests passed!", vn);
    end
endprogram

module mux_top;
  logic[3:0] d0, d1, d2, d3;
  logic[3:0] y, ys, yss;
  logic[1:0] s;
  util#(3) u();
  mux4 dut(d0, d1, d2, d3, s, y);
  mux4structural duts(d0, d1, d2, d3, s, ys);
  mux4tristate dutt(d0, d1, d2, d3, s, yss);
  mux_testbench mt(y, ys, yss, s, d0, d1, d2, d3);
endmodule