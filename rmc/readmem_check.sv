//-----------------------------------------------------------------------------
//
// Simple testbench module: checking on how reading from file works
//
//-----------------------------------------------------------------------------

module readmem_check;

logic [3:0] data [10:0];

initial
  begin
    $readmemb("sillyvectors.txt", data);
  end

integer i;

initial
  begin
    for (i = 0; i < 10; i = i + 1)
      $display("%d: %b", i, data[i]);
  end

endmodule
