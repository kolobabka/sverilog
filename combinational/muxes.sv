// Harris and Harris example 4.5
module mux2(input logic[3:0] d0, d1,
            input logic s,
            output logic[3:0] y);
  assign y = s ? d0 : d1;
endmodule;

// Harris and Harris example 4.6
// behavioral approach
module mux4(input logic[3:0] d0, d1, d2, d3,
            input logic[1:0] s,
            output logic[3:0] y);
  assign y = s[1] ? (s[0] ? d2 : d3) : (s[0] ? d0 : d1);
endmodule;

// Harris and Harris example 4.10
module tristate(input logic[3:0] a,
                input logic en,
                output logic[3:0] y);
  assign y = en ? a : 4'bz;
endmodule;

// Harris and Harris example 4.14
// structural approach
module mux4s(input logic[3:0] d0, d1, d2, d3,
             input logic[1:0] s,
             output logic[3:0] y);
  logic[3:0] low, high;
  mux2 lowmux(d0, d1, s[0], low);
  mux2 highmux(d2, d3, s[0], high);
  mux2 finalmux(low, high, s[1], y);
endmodule;

// Harris and Harris example 4.15
module mux2s(input logic[3:0] d0, d1,
            input logic s,
            output logic[3:0] y);
  tristate t0(d0, ~s, y);
  tristate t1(d1, s, y);
endmodule;

// even more structural approach
module mux4ss(input logic[3:0] d0, d1, d2, d3,
              input logic[1:0] s,
              output logic[3:0] y);
  logic[3:0] low, high;
  mux2s lowmux(d0, d1, s[0], low);
  mux2s highmux(d2, d3, s[0], high);
  mux2s finalmux(low, high, s[1], y);
endmodule;
