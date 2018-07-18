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
vsim  -t ns -novopt -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver work.UART_Txd_tb
#==============================================
# add signal to wave window
add wave -noupdate /UART_Txd_tb/SYS_CLK
add wave -noupdate /UART_Txd_tb/RST_N
add wave -noupdate -divider UART_CTRL
add wave -noupdate /UART_Txd_tb/rd_clk
add wave -noupdate /UART_Txd_tb/rd_empty
add wave -noupdate /UART_Txd_tb/rd_req
add wave -noupdate -radix unsigned /UART_Txd_tb/UART_CTRL_inst/data_out
add wave -noupdate /UART_Txd_tb/UART_CTRL_inst/tx_req
add wave -noupdate /UART_Txd_tb/UART_CTRL_inst/tx_busy
add wave -noupdate -radix unsigned /UART_Txd_tb/UART_CTRL_inst/state
add wave -noupdate -radix unsigned /UART_Txd_tb/UART_CTRL_inst/step_cnt
add wave -noupdate -radix unsigned /UART_Txd_tb/UART_CTRL_inst/send_cnt
add wave -noupdate /UART_Txd_tb/Txd
add wave -noupdate -divider UART_Txd
add wave -noupdate -radix unsigned /UART_Txd_tb/UART_Txd_inst/bit_cnt
add wave -noupdate -divider uart_tx_fifo
add wave -noupdate -radix unsigned /UART_Txd_tb/uart_tx_fifo_inst/data
add wave -noupdate -radix unsigned /UART_Txd_tb/uart_tx_fifo_inst/wrusedw
add wave -noupdate /UART_Txd_tb/uart_tx_fifo_inst/rdreq
add wave -noupdate /UART_Txd_tb/uart_tx_fifo_inst/rdempty
add wave -noupdate -radix unsigned /UART_Txd_tb/uart_tx_fifo_inst/q
#==============================================
# run the simulation
#$display("Start Simulation !")
run 800us
