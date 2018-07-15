transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/u16_smg {F:/FPGA/Verilog/u16_smg/clk_div.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/u16_smg {F:/FPGA/Verilog/u16_smg/u16_smg.v}

vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/u16_smg/simulation/modelsim {F:/FPGA/Verilog/u16_smg/simulation/modelsim/u16_smg.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc" u16_smg_vlg_tst

add wave *
view structure
view signals
run 100 us
