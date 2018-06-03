transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/UART/UART_RX_TOP {F:/FPGA/Verilog/UART/UART_RX_TOP/UART_RX.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/UART/UART_RX_TOP {F:/FPGA/Verilog/UART/UART_RX_TOP/UART_RX_TOP.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/UART/UART_RX_TOP {F:/FPGA/Verilog/UART/UART_RX_TOP/UART_RX_FIFO.v}

vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/UART/UART_RX_TOP/simulation/modelsim {F:/FPGA/Verilog/UART/UART_RX_TOP/simulation/modelsim/UART_RX_TOP.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  UART_RX_TOP_vlg_tst

add wave *
view structure
view signals
run -all
