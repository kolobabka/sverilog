//-----------------------------------------------------------------------------
//
// checker function
//
//-----------------------------------------------------------------------------

program automatic util#(parameter int W = 3)();
  // ncheck function for non-numbered tests
  function void ncheck(logic [W:0] y, logic [W:0] yeta);
    if (y !== yeta) begin
      $display("test failed: %b, expected %b", y, yeta);
      $finish;
    end
  endfunction

  // scheck function for string messages
  function void scheck(string s, logic [W:0] y, logic [W:0] yeta);
    if (y !== yeta) begin
      $display("%s test failed: %b, expected %b", s, y, yeta);
      $finish;
    end
  endfunction

  // check function for numbered tests
  function void check(integer vn, logic [W:0] y, logic [W:0] yeta);
    if (y !== yeta) begin
      $display("vn = %d, test failed: %b, expected %b", vn, y, yeta);
      $finish;
    end
  endfunction
endprogram
