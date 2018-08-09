# Copyright (C) 1991-2013 Altera Corporation
# Your use of Altera Corporation's design tools, logic functions 
# and other software and tools, and its AMPP partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License 
# Subscription Agreement, Altera MegaCore Function License 
# Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the 
# applicable agreement for further details.

# Quartus II 64-Bit Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Full Version
# File: F:\FPGA\Verilog\OV7670_SDRAM_VGA\qpf\OV7670_SDRAM_VGA.tcl
# Generated on: Wed Aug 08 10:20:11 2018

package require ::quartus::project

set_location_assignment PIN_28 -to sys_clk
set_location_assignment PIN_23 -to rst_n
set_location_assignment PIN_134 -to vga_clk
set_location_assignment PIN_135 -to vga_hsync
set_location_assignment PIN_128 -to vga_vsync
set_location_assignment PIN_116 -to vga_rgb_out[15]
set_location_assignment PIN_117 -to vga_rgb_out[14]
set_location_assignment PIN_127 -to vga_rgb_out[13]
set_location_assignment PIN_118 -to vga_rgb_out[12]
set_location_assignment PIN_133 -to vga_rgb_out[11]
set_location_assignment PIN_108 -to vga_rgb_out[10]
set_location_assignment PIN_110 -to vga_rgb_out[9]
set_location_assignment PIN_112 -to vga_rgb_out[8]
set_location_assignment PIN_113 -to vga_rgb_out[7]
set_location_assignment PIN_114 -to vga_rgb_out[6]
set_location_assignment PIN_115 -to vga_rgb_out[5]
set_location_assignment PIN_103 -to vga_rgb_out[4]
set_location_assignment PIN_104 -to vga_rgb_out[3]
set_location_assignment PIN_105 -to vga_rgb_out[2]
set_location_assignment PIN_106 -to vga_rgb_out[1]
set_location_assignment PIN_107 -to vga_rgb_out[0]
set_location_assignment PIN_200 -to SDRAM_ADDR[0]
set_location_assignment PIN_203 -to SDRAM_ADDR[1]
set_location_assignment PIN_205 -to SDRAM_ADDR[2]
set_location_assignment PIN_207 -to SDRAM_ADDR[3]
set_location_assignment PIN_208 -to SDRAM_ADDR[4]
set_location_assignment PIN_206 -to SDRAM_ADDR[5]
set_location_assignment PIN_201 -to SDRAM_ADDR[6]
set_location_assignment PIN_199 -to SDRAM_ADDR[7]
set_location_assignment PIN_197 -to SDRAM_ADDR[8]
set_location_assignment PIN_193 -to SDRAM_ADDR[9]
set_location_assignment PIN_198 -to SDRAM_ADDR[10]
set_location_assignment PIN_191 -to SDRAM_ADDR[11]
set_location_assignment PIN_150 -to SDRAM_DQ[0]
set_location_assignment PIN_151 -to SDRAM_DQ[1]
set_location_assignment PIN_152 -to SDRAM_DQ[2]
set_location_assignment PIN_163 -to SDRAM_DQ[3]
set_location_assignment PIN_165 -to SDRAM_DQ[4]
set_location_assignment PIN_169 -to SDRAM_DQ[5]
set_location_assignment PIN_171 -to SDRAM_DQ[6]
set_location_assignment PIN_173 -to SDRAM_DQ[7]
set_location_assignment PIN_179 -to SDRAM_DQ[8]
set_location_assignment PIN_175 -to SDRAM_DQ[9]
set_location_assignment PIN_170 -to SDRAM_DQ[10]
set_location_assignment PIN_168 -to SDRAM_DQ[11]
set_location_assignment PIN_164 -to SDRAM_DQ[12]
set_location_assignment PIN_162 -to SDRAM_DQ[13]
set_location_assignment PIN_161 -to SDRAM_DQ[14]
set_location_assignment PIN_160 -to SDRAM_DQ[15]
set_location_assignment PIN_187 -to SDRAM_CLK
set_location_assignment PIN_185 -to SDRAM_RAS
set_location_assignment PIN_180 -to SDRAM_WE
set_location_assignment PIN_176 -to SDRAM_DQM[0]
set_location_assignment PIN_181 -to SDRAM_DQM[1]
set_location_assignment PIN_188 -to SDRAM_CS
set_location_assignment PIN_189 -to SDRAM_CKE
set_location_assignment PIN_182 -to SDRAM_CAS
set_location_assignment PIN_192 -to SDRAM_BANK[0]
set_location_assignment PIN_195 -to SDRAM_BANK[1]
set_location_assignment PIN_45 -to SCCB_SCL
set_location_assignment PIN_43 -to SCCB_SDA
set_location_assignment PIN_46 -to OV_wrst
set_location_assignment PIN_44 -to OV_rrst
set_location_assignment PIN_41 -to OV_oe
set_location_assignment PIN_40 -to OV_data[0]
set_location_assignment PIN_39 -to OV_data[1]
set_location_assignment PIN_37 -to OV_data[2]
set_location_assignment PIN_35 -to OV_data[3]
set_location_assignment PIN_34 -to OV_data[4]
set_location_assignment PIN_33 -to OV_data[5]
set_location_assignment PIN_31 -to OV_data[6]
set_location_assignment PIN_30 -to OV_data[7]
set_location_assignment PIN_15 -to OV_rclk
set_location_assignment PIN_14 -to OV_vsync
set_location_assignment PIN_13 -to OV_wen
set_instance_assignment -name WEAK_PULL_UP_RESISTOR ON -to SCCB_SCL
set_instance_assignment -name WEAK_PULL_UP_RESISTOR ON -to SCCB_SDA
