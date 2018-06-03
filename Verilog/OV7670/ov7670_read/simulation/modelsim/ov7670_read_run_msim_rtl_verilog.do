transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/OV7670/ov7670_read {F:/FPGA/Verilog/OV7670/ov7670_read/ov7670_read.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/OV7670/ov7670_read {F:/FPGA/Verilog/OV7670/ov7670_read/FIFO_IP.v}

vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/OV7670/ov7670_read/simulation/modelsim {F:/FPGA/Verilog/OV7670/ov7670_read/simulation/modelsim/ov7670_read.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  ov7670_read_vlg_tst

add wave *
add wave -position end  sim:/ov7670_read_vlg_tst/i1/FIFO_IP_inst/rdempty
add wave -position end  sim:/ov7670_read_vlg_tst/i1/FIFO_IP_inst/wrfull

view structure
view signals
run -all
