transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/VGA_TOP {F:/FPGA/Verilog/VGA_TOP/VGA.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/VGA_TOP {F:/FPGA/Verilog/VGA_TOP/VGA_TOP.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/VGA_TOP {F:/FPGA/Verilog/VGA_TOP/PLL_IP.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/VGA_TOP {F:/FPGA/Verilog/VGA_TOP/ROM_IP.v}

vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/VGA_TOP/simulation/modelsim {F:/FPGA/Verilog/VGA_TOP/simulation/modelsim/VGA_TOP.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  VGA_TOP_vlg_tst

add wave *
view structure
view signals
run -all