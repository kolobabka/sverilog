//-----------------------------------------------------------------------------
//
// simple RAM with some interfaces
//
//-----------------------------------------------------------------------------

interface DataBus();
  logic [7:0] Addr, Data;
  modport TestR (inout Addr, inout Data);
  modport Ram (inout Addr, inout Data);
endinterface

interface CtrlBus();
  logic RWn;
  modport TestR (output RWn);
  modport Ram (input RWn);
endinterface

module ram(input Clk, DataBus.Ram DataInt, CtrlBus.Ram CtrlInt);
  reg [7:0] mem[0:255];

  always @ (posedge Clk) 
    if (CtrlInt.RWn)
      DataInt.Data = mem[DataInt.Addr];

  always @ (posedge Clk) 
    if (!CtrlInt.RWn)
      mem[DataInt.Addr] = DataInt.Data;
endmodule