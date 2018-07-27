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
# File: F:\FPGA\Verilog\OV7670_UART\qpf\OV7670_UART.tcl
# Generated on: Wed Jul 25 21:49:45 2018

package require ::quartus::project

set_location_assignment PIN_28 -to SYS_CLK
set_location_assignment PIN_23 -to RST_N
set_location_assignment PIN_56 -to SCCB_SCL
set_location_assignment PIN_47 -to SCCB_SDA
set_location_assignment PIN_144 -to Txd
set_location_assignment PIN_57 -to OV_wrst
set_location_assignment PIN_48 -to OV_rrst
set_location_assignment PIN_46 -to OV_oe
set_location_assignment PIN_45 -to OV_data[0]
set_location_assignment PIN_44 -to OV_data[1]
set_location_assignment PIN_43 -to OV_data[2]
set_location_assignment PIN_41 -to OV_data[3]
set_location_assignment PIN_40 -to OV_data[4]
set_location_assignment PIN_39 -to OV_data[5]
set_location_assignment PIN_37 -to OV_data[6]
set_location_assignment PIN_35 -to OV_data[7]
set_location_assignment PIN_34 -to OV_rclk
set_location_assignment PIN_33 -to OV_vsync
set_location_assignment PIN_31 -to OV_wen
set_instance_assignment -name WEAK_PULL_UP_RESISTOR ON -to SCCB_SCL
set_instance_assignment -name WEAK_PULL_UP_RESISTOR ON -to SCCB_SDA
