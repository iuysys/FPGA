transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/UART/UART_RX {F:/FPGA/Verilog/UART/UART_RX/UART_RX.v}

vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/UART/UART_RX/simulation/modelsim {F:/FPGA/Verilog/UART/UART_RX/simulation/modelsim/UART_RX.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiv_hssi_ver -L cycloneiv_pcie_hip_ver -L cycloneiv_ver -L rtl_work -L work -voptargs="+acc"  UART_RX_vlg_tst

add wave *
add wave -position end  sim:/UART_RX_vlg_tst/i1/STATE
add wave -position end  sim:/UART_RX_vlg_tst/i1/bit_cnt
add wave -position end  sim:/UART_RX_vlg_tst/i1/baud_count
view structure
view signals
run -all
