//-----------------------------------------------------------------------------
//
// Experiments with latches
//
//-----------------------------------------------------------------------------

// most naive barely working sr-latch
// tool complaining on linter, so switching linter off
/* verilator lint_off UNOPTFLAT */
module sr_latch_naive(input logic S, R, output logic Q, Q_not);
  logic Q_int, Q_not_int;

  // note: delay required, so logic is not so combinational
  assign #1 Q_int     = ~(R | Q_not);
  assign #1 Q_not_int = ~(S | Q);

  // note we need this to propagate, this is really inefficient
  assign Q = Q_int;
  assign Q_not = Q_not_int;
endmodule
/* verilator lint_on UNOPTFLAT */

// less naive sr-latch with latch logic
module sr_latch(input logic S, R, output logic Q, Q_not);
  always_latch @(R, S, Q, Q_not)
    begin
      if (R | S)
        begin
          Q <= ~(R | Q_not);
          Q_not <= ~(S | Q);
        end
    end
endmodule
