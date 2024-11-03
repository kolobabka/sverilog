//-----------------------------------------------------------------------------
//
// counter bench with clocking
//
//-----------------------------------------------------------------------------

program automatic test_counter(input logic Clock, output logic Reset, output logic Enable, Load, UpDn, logic [7:0] Data, input logic [7:0] Q);
  clocking cb @(posedge Clock);
    default input #0 output #0; // skew: input -- #0 -- posedge -- #0 -- output
    output Reset;
    output Enable, Load, UpDn, Data;
    input Q;
  endclocking

  initial begin    
    cb.Enable <= 1; cb.Load <= 0; cb.UpDn <= 1; cb.Reset <= 0;
    @(cb);
    repeat (3) @(cb);
    cb.Reset <= 1;
    @(cb);
    cb.Reset <= 0; cb.UpDn <= 0;
    repeat (3) @(cb);
    cb.UpDn <= 1;
  end

  initial begin
    logic[7:0] Qe = 8'b00000000;

    // inputs sampled #1 before clock
    repeat (1) @(cb);    
    @(cb); Qe = 0; test_counter_top.u.scheck("t1:", cb.Q, Qe);
    repeat (3) begin @(cb); Qe = Qe + 1; test_counter_top.u.scheck("t2:", cb.Q, Qe); end
    @(cb); Qe = 0; test_counter_top.u.scheck("t3:", cb.Q, Qe);
    repeat (3) begin @(cb); Qe = Qe - 1; test_counter_top.u.scheck("t4:", cb.Q, Qe); end
    repeat (3) begin @(cb); Qe = Qe + 1; test_counter_top.u.scheck("t5:", cb.Q, Qe); end
    $display("All tests passed");
    $finish;
   end
endprogram

module test_counter_top;
  logic Clock = 0, Reset, Enable, Load, UpDn;
  reg [7:0] Data;
  wire [7:0] Q;

  always
  begin
    #5 Clock = 1;
    #5 Clock = 0;
  end

  util#(7) u();
  counter G1(Clock, Reset, Enable, Load, UpDn, Data, Q);
  test_counter tc(Clock, Reset, Enable, Load, UpDn, Data, Q);
endmodule
