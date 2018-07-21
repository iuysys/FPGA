#==============================================
# exit the current simulation
quit	-sim

#==============================================
# clear the console message
.main	clear

#==============================================
# make the phyical library
vlib	work

#==============================================
# mapping the logic library and phyical library
vmap	work work

#==============================================
# complie the design file
vlog	../core/*.v
vlog	../sim/OV7670_UART_tb.v
vlog	../src/*.v

#==============================================
# simulate the design file by optimization
vsim  -t ps -novopt -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver work.OV7670_UART_tb
#==============================================
# add signal to wave window
add wave -noupdate /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/S_CLK
add wave -noupdate -divider OV7670_Capture
add wave -noupdate /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV_vsync
add wave -noupdate -radix hexadecimal /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/OV_data
add wave -noupdate -radix unsigned /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/w_usedw
add wave -noupdate /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/w_req
add wave -noupdate /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/w_clk
add wave -noupdate -radix hexadecimal /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/w_data
add wave -noupdate -radix unsigned /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/state
add wave -noupdate -radix unsigned /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/pixel_cnt
add wave -noupdate -radix unsigned /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/step_cnt
add wave -noupdate /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/w_full
#==============================================
# run the simulation
run 160us
