//-----------------------------------------------------------------------------
//
// Checking always_comb vs assign
//
//-----------------------------------------------------------------------------

module alwayscomb();
  logic in = 1'b0, out1, out2;
  function f();
    return in;
  endfunction

  assign out1 = f();
  always_comb out2 = f();

  initial begin
    $display("-- alwayscomb check --");
    #1 $display(out1, , out2);
    force in = 1'b1;
    #1 $display(out1, , out2);
    force in = 1'b0;
    #1 $display(out1, , out2);
  end
endmodule

