//-----------------------------------------------------------------------------
//
// Checking on how reading from file works
//
//-----------------------------------------------------------------------------

module readmem_check;
  logic [3:0] data [10:0];
  integer i;
  initial
    begin
      $readmemb("sillyvectors.txt", data);
      for (i = 0; i < 10; i = i + 1)
        $display("%d: %b", i, data[i]);
    end
endmodule
