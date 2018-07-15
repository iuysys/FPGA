transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/FIFO_T {F:/FPGA/Verilog/FIFO_T/FIFO_T.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/FIFO_T {F:/FPGA/Verilog/FIFO_T/FIFO_IP.v}

vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/FIFO_T/simulation/modelsim {F:/FPGA/Verilog/FIFO_T/simulation/modelsim/FIFO_T.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  FIFO_T_vlg_tst

add wave *
view structure
view signals
run -all