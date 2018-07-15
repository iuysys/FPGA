transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/led_test {F:/FPGA/Verilog/led_test/clk_div.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/led_test {F:/FPGA/Verilog/led_test/led.v}

vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/led_test/simulation/modelsim {F:/FPGA/Verilog/led_test/simulation/modelsim/led.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  led_vlg_tst

add wave *
view structure
view signals
run -all
