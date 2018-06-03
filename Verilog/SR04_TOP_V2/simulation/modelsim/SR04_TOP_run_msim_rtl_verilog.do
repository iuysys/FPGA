transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/SR04_TOP_V2/CLK_DIV_EVEN {F:/FPGA/Verilog/SR04_TOP_V2/CLK_DIV_EVEN/CLK_DIV_EVEN.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/SR04_TOP_V2/SR04 {F:/FPGA/Verilog/SR04_TOP_V2/SR04/SR04.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/SR04_TOP_V2/SMG {F:/FPGA/Verilog/SR04_TOP_V2/SMG/SMG.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/SR04_TOP_V2/SR04 {F:/FPGA/Verilog/SR04_TOP_V2/SR04/SR04_TOP.v}

vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/SR04_TOP_V2/simulation/modelsim {F:/FPGA/Verilog/SR04_TOP_V2/simulation/modelsim/SR04_TOP.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  SR04_TOP_vlg_tst

add wave *
view structure
view signals
run -all
