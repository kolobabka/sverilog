//-----------------------------------------------------------------------------
//
// Randomization with some constraints
//
//-----------------------------------------------------------------------------

module randomize;
  class Packet;
   logic [7:0] b;

/* unsupported in verilator, but pretty
    rand int a[];
    constraint a_c {
      a.size == 20;
      foreach (a[i]) a[i] inside {1, 2, 3};
      a.sum() with ((item == 1) ? 1 : 0) == 10;
      a.sum() with ((item == 2) ? 1 : 0) == 5;
      a.sum() with ((item == 3) ? 1 : 0) == 5;
    }
*/
  endclass
   
  initial
    begin
      Packet p1;
      p1 = new();
      if (!1'(p1.randomize())) begin
        $display("Randomization Error");
      end
      // $display("Value of p1.a is %p", p1.a); 
      $display("Value of p1.b is %b", p1.b);
    end
endmodule