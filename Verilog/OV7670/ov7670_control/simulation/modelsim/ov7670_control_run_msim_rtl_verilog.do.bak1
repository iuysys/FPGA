transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/OV7670/ov7670_control {F:/FPGA/Verilog/OV7670/ov7670_control/ov7670_control.v}

vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/OV7670/ov7670_control/simulation/modelsim {F:/FPGA/Verilog/OV7670/ov7670_control/simulation/modelsim/ov7670_control.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  ov7670_control_vlg_tst

add wave *
view structure
view signals
run -all
