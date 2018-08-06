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
vlog	../core/sdram_pll.v
vlog	../sim/*.v
vlog	../src/*.v
vlog	../src/sdram_v2/*.v
vlog 	../src/uart/*.v
#==============================================
# simulate the design file by optimization
vsim  -t ns -novopt -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver  work.UART_SDRAM_UART_tb
#==============================================
# add signal to wave window
add wave -noupdate -radix unsigned /UART_SDRAM_UART_tb/UART_SDRAM_UART_inst/UART_Rxd_inst/rx_data
add wave -noupdate -radix unsigned /UART_SDRAM_UART_tb/UART_SDRAM_UART_inst/UART_Rxd_CTRL_inst/rx_data_out
add wave -noupdate -radix unsigned /UART_SDRAM_UART_tb/UART_SDRAM_UART_inst/sdram_2port_top_inst/sdram_fifo_write/wrreq
add wave -noupdate -radix unsigned /UART_SDRAM_UART_tb/UART_SDRAM_UART_inst/sdram_2port_top_inst/sdram_fifo_write/data
add wave -noupdate -radix unsigned /UART_SDRAM_UART_tb/UART_SDRAM_UART_inst/sdram_2port_top_inst/sdram_fifo_write/q
add wave -noupdate -radix unsigned /UART_SDRAM_UART_tb/UART_SDRAM_UART_inst/sdram_2port_top_inst/sdram_fifo_write/rdreq
add wave -noupdate /UART_SDRAM_UART_tb/UART_SDRAM_UART_inst/sdram_2port_top_inst/clk
add wave -noupdate /UART_SDRAM_UART_tb/SDRAM_CLK
add wave -noupdate -radix unsigned /UART_SDRAM_UART_tb/SDRAM_DQ
add wave -noupdate /UART_SDRAM_UART_tb/UART_SDRAM_UART_inst/sdram_2port_top_inst/sdram_fifo_read/wrclk
add wave -noupdate /UART_SDRAM_UART_tb/UART_SDRAM_UART_inst/sdram_2port_top_inst/sdram_fifo_read/wrreq
add wave -noupdate -radix unsigned /UART_SDRAM_UART_tb/UART_SDRAM_UART_inst/sdram_2port_top_inst/sdram_fifo_read/data
add wave -noupdate -radix unsigned /UART_SDRAM_UART_tb/UART_SDRAM_UART_inst/sdram_2port_top_inst/sdram_fifo_read/wrusedw
#==============================================
# run the simulation
run		320us
