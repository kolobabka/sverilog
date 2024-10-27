//-----------------------------------------------------------------------------
//
// checker function
//
//-----------------------------------------------------------------------------

program automatic util#(parameter int W = 3)();
  // check function for tests
  function void check(integer vn, logic [W:0] y, logic [W:0] yeta);
    if (y !== yeta) begin
      $display("vn = %d, test failed: %b, expected %b", vn, y, yeta);
      $finish;
    end
  endfunction
endprogram
