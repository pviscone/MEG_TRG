`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04.05.2018 10:07:28
// Design Name:
// Module Name: NGENTRG
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


module NGENTRG(
    input CLK,
    input START,
    input [COUNTSIZE-1:0] DLY,
    input [COUNTSIZE-1:0] WIDTH,
    output reg TRG
    );

    parameter COUNTSIZE = 15;

    parameter WAIT_STATE = 2'b00;
    parameter TRIGGED_STATE = 2'b01;
    parameter SHAPING_STATE = 2'b10;


    reg [COUNTSIZE-1:0] COUNTER;
    reg START_OLD;
    reg [1:0] STATE;

    always @(posedge CLK) begin
        //register START signal
        START_OLD <= START;

        //logic
        case (STATE)
            WAIT_STATE: begin
                COUNTER <= 0;
                TRG <= 1'b0;
                if(~START & START_OLD) begin
                    STATE <= TRIGGED_STATE;
                end
            end
            TRIGGED_STATE: begin
                if(COUNTER+1 >= DLY) begin
                    STATE <= SHAPING_STATE;
                    COUNTER <= 0;
                    TRG <= 1'b1;
                end else begin
                    COUNTER <= COUNTER+1;
                end
            end
            SHAPING_STATE: begin
                if(COUNTER+1 >= WIDTH) begin
                    STATE <= WAIT_STATE;
                    COUNTER <= 0;
                    TRG <= 1'b0;
                end else begin
                    COUNTER <= COUNTER+1;
                end
            end
            default: begin
                STATE <= WAIT_STATE;
                COUNTER <= 0;
                TRG <= 1'b0;
            end
        endcase
    end

endmodule
