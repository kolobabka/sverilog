//-----------------------------------------------------------------------------
//
// simple RAM testbench with some interfaces
//
//-----------------------------------------------------------------------------

program ram_test(input logic Clock, DataBus.TestR DataInt,
                 CtrlBus.TestR CtrlInt);
  default clocking cb @(posedge Clock);
    default input #0 output #0; // skew: input -- #0 -- posedge -- #0 -- output
  endclocking

  initial begin
    CtrlInt.RWn = 0; // write
    DataInt.Addr = 1;
    DataInt.Data = 1;
    repeat(3) ##1;
    CtrlInt.RWn = 1; // read
    DataInt.Addr = 1;
    repeat(3) ##1;
    CtrlInt.RWn = 0; // write
    DataInt.Addr = 1;
    DataInt.Data = 0;
    repeat(3) ##1;
  end

  initial begin
    repeat(10) begin
      ##1;
      $display("RWn: %b, Addr: %b, Data: %b", CtrlInt.RWn, DataInt.Addr, DataInt.Data);
      $display("RAM: %b", TheRAM.mem[1]);
    end
    $finish;
  end

endprogram

module ram_top;
  logic clock = 0;

  always
  begin
    #5 clock = 1;
    #5 clock = 0;
  end

  // instance interfaces
  DataBus TheDataBus();
  CtrlBus TheCtrlBus();

  // connect these
  ram TheRAM(.Clk(clock),
             .DataInt(TheDataBus.Ram),
             .CtrlInt(TheCtrlBus.Ram));
  ram_test TheTest(.Clock(clock),
                   .DataInt(TheDataBus.TestR),
                   .CtrlInt(TheCtrlBus.TestR));
  util#(7) u();
endmodule