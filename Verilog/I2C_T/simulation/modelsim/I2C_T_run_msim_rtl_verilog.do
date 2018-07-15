transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/I2C_T {F:/FPGA/Verilog/I2C_T/I2C_T.v}

vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/I2C_T {F:/FPGA/Verilog/I2C_T/I2C.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  I2C_vlg_tst

add wave *
view structure
view signals
run -all
