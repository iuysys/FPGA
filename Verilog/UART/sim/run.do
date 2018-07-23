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
vlog	../core/uart_tx_fifo.v
vlog	../sim/*.v
vlog	../src/*.v

#==============================================
# simulate the design file by optimization
vsim  -t ns -novopt -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver work.UART_Txd_Rxd_tb
#==============================================
# add signal to wave window
add wave -noupdate /UART_Txd_Rxd_tb/SYS_CLK
add wave -noupdate -divider UART_Txd
add wave -noupdate -radix unsigned /UART_Txd_Rxd_tb/UART_Txd_inst/data_in
add wave -noupdate /UART_Txd_Rxd_tb/UART_Txd_inst/tx_req
add wave -noupdate /UART_Txd_Rxd_tb/UART_Txd_inst/Txd
add wave -noupdate /UART_Txd_Rxd_tb/UART_Txd_inst/tx_busy
add wave -noupdate -radix unsigned /UART_Txd_Rxd_tb/UART_Txd_inst/bit_cnt
add wave -noupdate -radix unsigned /UART_Txd_Rxd_tb/UART_Txd_inst/STATE
add wave -noupdate -divider UART_Txd_CTRL
add wave -noupdate -radix unsigned /UART_Txd_Rxd_tb/UART_Txd_CTRL_inst/state
add wave -noupdate -radix unsigned /UART_Txd_Rxd_tb/UART_Txd_CTRL_inst/step_cnt
add wave -noupdate /UART_Txd_Rxd_tb/UART_Txd_CTRL_inst/rd_req
add wave -noupdate -divider UART_Rxd
add wave -noupdate -radix unsigned /UART_Txd_Rxd_tb/UART_Rxd_inst/rx_data
add wave -noupdate /UART_Txd_Rxd_tb/UART_Rxd_inst/rx_busy
add wave -noupdate -radix unsigned /UART_Txd_Rxd_tb/UART_Rxd_inst/state
add wave -noupdate -radix unsigned /UART_Txd_Rxd_tb/UART_Rxd_inst/bit_cnt
add wave -noupdate -radix unsigned /UART_Txd_Rxd_tb/UART_Rxd_inst/shift_data
add wave -noupdate -radix unsigned /UART_Txd_Rxd_tb/UART_Rxd_inst/shift_data_n
add wave -noupdate /UART_Txd_Rxd_tb/UART_Rxd_inst/rx_start
add wave -noupdate /UART_Txd_Rxd_tb/UART_Rxd_inst/Rxd
add wave -noupdate -divider UART_fifo
add wave -noupdate -radix unsigned /UART_Txd_Rxd_tb/uart_tx_fifo_inst/data
add wave -noupdate -radix unsigned /UART_Txd_Rxd_tb/uart_tx_fifo_inst/q
add wave -noupdate /UART_Txd_Rxd_tb/uart_tx_fifo_inst/rdempty
add wave -noupdate -radix unsigned /UART_Txd_Rxd_tb/uart_tx_fifo_inst/wrusedw
#==============================================
# run the simulation
#$display("Start Simulation !")
run 800us
