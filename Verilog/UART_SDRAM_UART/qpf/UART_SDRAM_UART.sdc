## Generated SDC file "UART_SDRAM_UART.sdc"

## Copyright (C) 1991-2013 Altera Corporation
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, Altera MegaCore Function License 
## Agreement, or other applicable license agreement, including, 
## without limitation, that your use is for the sole purpose of 
## programming logic devices manufactured by Altera and sold by 
## Altera or its authorized distributors.  Please refer to the 
## applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Full Version"

## DATE    "Mon Aug 06 20:27:04 2018"

##
## DEVICE  "EP2C8Q208C8"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {SYS_CLK} -period 50.000 -waveform { 0.000 25.000 } [get_ports {SYS_CLK}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {sdram_ctrl_clk} -source [get_ports {SYS_CLK}] -multiply_by 5 -master_clock {SYS_CLK} [get_pins {sdram_pll_inst|altpll_component|pll|clk[0]}] 
create_generated_clock -name {sdram_clk} -source [get_ports {SYS_CLK}] -multiply_by 5 -phase 180.000 -master_clock {SYS_CLK} [get_pins {sdram_pll_inst|altpll_component|pll|clk[1]}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************



#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************

set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_d09:dffpipe21|dffe22a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_c09:dffpipe18|dffe19a*}]


#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

