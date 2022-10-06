`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/04/2022 09:05:35 AM
// Design Name:
// Module Name: ngen
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



module ngen #(parameter COUNTSIZE=15)
              (    input CLK,
                   input GATE,
                   input [COUNTSIZE-1:0] DLY,
                   input [COUNTSIZE-1:0] WIDTH,
                   output TRG);



  reg [COUNTSIZE-1:0] COUNT_DLY;
  reg [COUNTSIZE-1:0] COUNT_WIDTH;
  reg START_COUNT_DLY;
  reg START_COUNT_WIDTH;
  reg OUT;
  reg GATE_REG;

  assign TRG = OUT;


  always @(posedge CLK)
  begin
    GATE_REG<= GATE;
    if(GATE_REG==1'b1 && GATE==1'b0 )
    begin
      START_COUNT_DLY <= 1'b1;
      COUNT_DLY<=1'b0;
    end

    case (START_COUNT_DLY)
      1'b1:
        COUNT_DLY <= COUNT_DLY + 1;
      1'b0:
        COUNT_DLY <= 0;
      default:
        COUNT_DLY <= 0;
    endcase

    case (START_COUNT_WIDTH)
      1'b1:
        COUNT_WIDTH <= COUNT_WIDTH + 1;
      1'b0:
        COUNT_WIDTH <= 0;
      default:
        COUNT_WIDTH <= 0;
    endcase


    if (COUNT_DLY+1 >= DLY && START_COUNT_DLY==1'b1)
    begin
      START_COUNT_DLY <= 1'b0;
      START_COUNT_WIDTH <= 1'b1;
      OUT <= 1'b1;
    end

    if (COUNT_WIDTH+1>=WIDTH && START_COUNT_WIDTH==1'b1)
    begin
      START_COUNT_WIDTH <= 1'b0;
      OUT <= 1'b0;
    end



  end

  initial begin
    OUT <= 1'b0;
    START_COUNT_DLY <= 1'b0;
    START_COUNT_WIDTH <= 1'b0;

  end
endmodule


//