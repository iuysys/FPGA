## Generated SDC file "OV7670_SDRAM_VGA.sdc"

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

## DATE    "Mon Aug 13 12:28:44 2018"

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

#create_clock -name {altera_reserved_tck} -period 100.000 -waveform { 0.000 50.000 } [get_ports {altera_reserved_tck}]
create_clock -name {sys_clk} -period 50.000 -waveform { 0.000 25.000 } [get_ports {sys_clk}]


#**************************************************************
# Create Generated Clock
#**************************************************************

#create_generated_clock -name {sdram_pll_inst|altpll_component|pll|clk[0]} -source [get_pins {sdram_pll_inst|altpll_component|pll|inclk[0]}] -duty_cycle 50.000 -multiply_by 5 -master_clock {sys_clk} [get_pins {sdram_pll_inst|altpll_component|pll|clk[0]}] 
#create_generated_clock -name {sdram_pll_inst|altpll_component|pll|clk[1]} -source [get_pins {sdram_pll_inst|altpll_component|pll|inclk[0]}] -duty_cycle 50.000 -multiply_by 5 -offset 180.000 -master_clock {sys_clk} [get_pins { sdram_pll_inst|altpll_component|pll|clk[1] }] 
#create_generated_clock -name {sdram_pll_inst|altpll_component|pll|clk[2]} -source [get_pins {sdram_pll_inst|altpll_component|pll|inclk[0]}] -duty_cycle 50.000 -multiply_by 2 -master_clock {sys_clk} [get_pins {sdram_pll_inst|altpll_component|pll|clk[2]}] 
create_generated_clock -name {clk_div} -source [get_ports {sys_clk}] -divide_by 40 -master_clock {sys_clk} [get_pins {OV7670_top_inst|CLK_DIV_EVEN_inst|CLK_DIV|regout}] 
derive_pll_clocks -create_base_clocks

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

#set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
#set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 
#set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 


#**************************************************************
# Set False Path
#**************************************************************

#set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_ue9:dffpipe21|dffe22a*}]
#set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_te9:dffpipe18|dffe19a*}]


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

