/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_nefelimet_updown_cntr (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    updown_counter cntr(.data_in(ui_in[2:0]), .rst_(ui_in[3]), .ld_cnt(ui_in[4]), .updn_cnt(ui_in[5]), .count_enb(ui_in[6]), .clk(clk), .data_out(uo_out[2:0]));
    
  // All output pins must be assigned. If not used, assign to 0.
  assign uio_out = 0;
  assign uio_oe  = 0;
  assign uo_out[7:3] = 5'b0;

  // List all unused inputs to prevent warnings
    wire _unused = &{ena, clk, rst_n, ui_in[7], &uio_in, 1'b0};

endmodule
