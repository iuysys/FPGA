transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/UART/UART_TX {F:/FPGA/Verilog/UART/UART_TX/UART_TOP.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/UART/UART_TX {F:/FPGA/Verilog/UART/UART_TX/UART_TXD.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/UART/UART_TX {F:/FPGA/Verilog/UART/UART_TX/FIFO_IP.v}

vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/UART/UART_TX/simulation/modelsim {F:/FPGA/Verilog/UART/UART_TX/simulation/modelsim/UART_TOP.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  UART_TOP_vlg_tst

add wave *
add wave -position end  sim:/UART_TOP_vlg_tst/i1/UART_TXD_inst/step_cnt
add wave -position end  sim:/UART_TOP_vlg_tst/i1/UART_TXD_inst/tx_data
view structure
view signals
run -all
