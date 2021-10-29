// file: CLK.v
// 
// (c) Copyright 2008 - 2011 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
//----------------------------------------------------------------------------
// User entered comments
//----------------------------------------------------------------------------
// None
//
//----------------------------------------------------------------------------
// "Output    Output      Phase     Duty      Pk-to-Pk        Phase"
// "Clock    Freq (MHz) (degrees) Cycle (%) Jitter (ps)  Error (ps)"
//----------------------------------------------------------------------------
// CLK_OUT1____66.667______0.000______50.0______306.616____267.927
// CLK_OUT2____66.667______0.000______50.0______306.616____267.927
//
//----------------------------------------------------------------------------
// "Input Clock   Freq (MHz)    Input Jitter (UI)"
//----------------------------------------------------------------------------
// __primary__________33.333___________0.010101

`timescale 1ps/1ps

(* CORE_GENERATION_INFO = "CLK,clk_wiz_v3_6,{component_name=CLK,use_phase_alignment=true,use_min_o_jitter=false,use_max_i_jitter=false,use_dyn_phase_shift=false,use_inclk_switchover=false,use_dyn_reconfig=false,feedback_source=FDBK_AUTO_OFFCHIP,primtype_sel=PLL_BASE,num_out_clk=2,clkin1_period=30.0,clkin2_period=30.0,use_power_down=false,use_reset=false,use_locked=false,use_inclk_stopped=false,use_status=false,use_freeze=false,use_clk_valid=false,feedback_type=SINGLE,clock_mgr_type=MANUAL,manual_override=false}" *)
module CLK
 (// Clock in ports
  input         CLKIN,
  input         CLKFB_IN,
  // Clock out ports
  output        FSBCLK,
  output        CPUCLK,
  output        CLKFB_OUT
 );

  // Input buffering
  //------------------------------------
  IBUFG clkin1_buf
   (.O (clkin1),
    .I (CLKIN));

  wire clkfb_ibuf2bufio2fb;
  wire clkfb_in_buf_out;

  // feedback clock input buffer
  IBUFG clkfb_ibufg
   (.O  (clkfb_ibuf2bufio2fb),
    .I  (CLKFB_IN));

  // bufio2fb instantiation
  BUFIO2FB #(.DIVIDE_BYPASS("TRUE")) clkfb_bufio2fb
   (.O(clkfb_in_buf_out),
    .I(clkfb_ibuf2bufio2fb));

  // Clocking primitive
  //------------------------------------
  // Instantiation of the PLL primitive
  //    * Unused inputs are tied off
  //    * Unused outputs are labeled unused
  wire [15:0] do_unused;
  wire        drdy_unused;
  wire        locked_unused;
  wire        clkfbout;
  wire        clkfbout_buf;
  wire        clkout2_unused;
  wire        clkout3_unused;
  wire        clkout4_unused;
  wire        clkout5_unused;

  PLL_BASE
  #(.BANDWIDTH              ("OPTIMIZED"),
    .CLK_FEEDBACK           ("CLKFBOUT"),
    .COMPENSATION           ("EXTERNAL"),
    .DIVCLK_DIVIDE          (1),
    .CLKFBOUT_MULT          (12),
    .CLKFBOUT_PHASE         (0.000),
    .CLKOUT0_DIVIDE         (6),
    .CLKOUT0_PHASE          (0.000),
    .CLKOUT0_DUTY_CYCLE     (0.500),
    .CLKOUT1_DIVIDE         (6),
    .CLKOUT1_PHASE          (0.000),
    .CLKOUT1_DUTY_CYCLE     (0.500),
    .CLKIN_PERIOD           (30.0),
    .REF_JITTER             (0.010))
  pll_base_inst
    // Output clocks
   (.CLKFBOUT              (clkfbout),
    .CLKOUT0               (clkout0),
    .CLKOUT1               (clkout1),
    .CLKOUT2               (clkout2_unused),
    .CLKOUT3               (clkout3_unused),
    .CLKOUT4               (clkout4_unused),
    .CLKOUT5               (clkout5_unused),
    .LOCKED                (locked_unused),
    .RST                   (1'b0),
     // Input clock control
    .CLKFBIN               (clkfb_in_buf_out),
    .CLKIN                 (clkin1));


  // Output buffering
  //-----------------------------------
  wire clkfb_bufg_out;
  wire clkfb_bufg_out_n;
  wire clkfb_oddr_out;
  // Instantiate bufg on fbout
  BUFG clkfbout_bufg
   (.O  (clkfb_bufg_out),
    .I  (clkfbout));
  // Locally invert clkfb_bufg_out for use in ODDR2
  assign clkfb_bufg_out_n = ~clkfb_bufg_out;

  // Forward the feedback clock off-chip
  ODDR2 clkfbout_oddr
   (.Q  (clkfb_oddr_out),
    .C0 (clkfb_bufg_out),
    .C1 (clkfb_bufg_out_n),
    .CE (1'b1),
    .D0 (1'b1),
    .D1 (1'b0),
    .R  (1'b0),
    .S  (1'b0));

  assign CLKFB_OUT = clkfb_oddr_out;
  BUFG clkout1_buf
   (.O   (FSBCLK),
    .I   (clkout0));


  BUFG clkout2_buf
   (.O   (CPUCLK),
    .I   (clkout1));



endmodule
