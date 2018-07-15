transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/ROM {F:/FPGA/Verilog/ROM/ROM_MOD.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/ROM {F:/FPGA/Verilog/ROM/ROM_IP.v}

vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/ROM/simulation/modelsim {F:/FPGA/Verilog/ROM/simulation/modelsim/ROM_MOD.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  ROM_MOD_vlg_tst

add wave *
view structure
view signals
run -all
