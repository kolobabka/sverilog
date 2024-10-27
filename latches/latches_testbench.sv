//-----------------------------------------------------------------------------
//
// latches testbench
//
//-----------------------------------------------------------------------------

program automatic latches_testbench(output logic s, r, q, q_not, ql, ql_not);
  initial
    begin
      q = 1'bx; q_not = 1'bx;

/*
      // verilator is bad with X's
      // initial: S = 0, R = 0
      s = 1'b0; r = 1'b0;
      #10
      latches_top.u.scheck("q-initial", q, 1'bx);
      latches_top.u.scheck("qnot-initial", q_not, 1'bx);
*/

      // reset: S = 0, R = 1
      s = 1'b0; r = 1'b1;
      #10 
      latches_top.u.scheck("q-reset", q, 1'b0);
      latches_top.u.scheck("qnot-reset", q_not, 1'b1);
      latches_top.u.scheck("ql-reset", ql, 1'b0);
      latches_top.u.scheck("qlnot-reset", ql_not, 1'b1);

      // keep 0: S = 0, R = 0
      s = 1'b0; r = 1'b0;
      #10
      latches_top.u.scheck("q-keep", q, 1'b0);
      latches_top.u.scheck("qnot-keep", q_not, 1'b1);
      latches_top.u.scheck("ql-keep", ql, 1'b0);
      latches_top.u.scheck("qlnot-keep", ql_not, 1'b1);

      // set: S = 1, R = 0
      s = 1'b1; r = 1'b0;
      #10
      latches_top.u.scheck("q-set", q, 1'b1);
      latches_top.u.scheck("qnot-set", q_not, 1'b0);
      latches_top.u.scheck("ql-set", ql, 1'b1);
      latches_top.u.scheck("qlnot-set", ql_not, 1'b0);

      // keep 1: S = 0, R = 0
      s = 1'b0; r = 1'b0;
      #10
      latches_top.u.scheck("q-keep", q, 1'b1);
      latches_top.u.scheck("qnot-keep", q_not, 1'b0);
      latches_top.u.scheck("ql-keep", ql, 1'b1);
      latches_top.u.scheck("qlnot-keep", ql_not, 1'b0);

      $display("latches: all tests passed!");

      // need finsh because signals still coming from incorrect naive latch
      $finish;
    end
endprogram

module latches_top;
  logic s, r, q, q_not, ql, ql_not;
  util#(0) u();
  sr_latch_naive srnaive(s, r, q, q_not);
  sr_latch sr(s, r, ql, ql_not);
  latches_testbench tb(s, r, q, q_not, ql, ql_not);
endmodule