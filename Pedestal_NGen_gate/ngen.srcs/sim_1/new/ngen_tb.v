`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/04/2022 09:05:59 AM
// Design Name:
// Module Name: ngen_tb
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////


module ngen_tb;
  reg gate;
  wire trg;
  reg clk;
  wire trg_ref;

  parameter dly = 15;
  parameter width = 8;

  ngen  c0  ( .CLK(clk),
              .GATE (gate),
              .DLY(dly),
              .WIDTH(width),
              .TRG (trg));

  NGENTRG  c1  ( .CLK(clk),
              .START (gate),
              .DLY(dly),
              .WIDTH(width),
              .TRG (trg_ref));


  initial
  fork
    gate <= 0;
    clk <= 0;

    forever
    begin
      #1 clk <= ~clk;
    end

    forever begin
      #50 gate <= 1;
      #8 gate <= 0;
    end
    #200 $finish;
  join
endmodule
