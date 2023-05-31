//2.Vivado根据模块设计，自动生成的主程序main_wrapper.v

//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
//Date        : Wed Jun 12 20:43:49 2019
//Host        : Precision3510 running 64-bit major release  (build 9200)
//Command     : generate_target main_wrapper.bd
//Design      : main_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module main_wrapper
   (btn_pin,
    seg_cs_pin,
    seg_data_0_pin,
    seg_data_1_pin,
    sw_pin,
    sys_clk_in);
  input [4:0]btn_pin;
  output [7:0]seg_cs_pin;
  output [7:0]seg_data_0_pin;
  output [7:0]seg_data_1_pin;
  input [3:0]sw_pin;
  input sys_clk_in;

  wire [4:0]btn_pin;
  wire [7:0]seg_cs_pin;
  wire [7:0]seg_data_0_pin;
  wire [7:0]seg_data_1_pin;
  wire [3:0]sw_pin;
  wire sys_clk_in;

  main main_i
       (.btn_pin(btn_pin),
        .seg_cs_pin(seg_cs_pin),
        .seg_data_0_pin(seg_data_0_pin),
        .seg_data_1_pin(seg_data_1_pin),
        .sw_pin(sw_pin),
        .sys_clk_in(sys_clk_in));
endmodule
