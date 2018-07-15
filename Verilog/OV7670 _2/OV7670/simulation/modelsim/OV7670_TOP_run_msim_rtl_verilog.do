transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/OV7670\ _2/OV7670/UART_TX_IMAGE {F:/FPGA/Verilog/OV7670 _2/OV7670/UART_TX_IMAGE/UART_TXD.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/OV7670\ _2/OV7670/UART_TX_IMAGE {F:/FPGA/Verilog/OV7670 _2/OV7670/UART_TX_IMAGE/UART_TOP.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/OV7670\ _2/OV7670/UART_TX_IMAGE {F:/FPGA/Verilog/OV7670 _2/OV7670/UART_TX_IMAGE/FIFO_IP.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/OV7670\ _2/OV7670/ov7670_run {F:/FPGA/Verilog/OV7670 _2/OV7670/ov7670_run/ov7670_run.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/OV7670\ _2/OV7670/ov7670_read {F:/FPGA/Verilog/OV7670 _2/OV7670/ov7670_read/ov7670_read.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/OV7670\ _2/OV7670/ov7670_init {F:/FPGA/Verilog/OV7670 _2/OV7670/ov7670_init/I2C_T.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/OV7670\ _2/OV7670/ov7670_init {F:/FPGA/Verilog/OV7670 _2/OV7670/ov7670_init/I2C_OV7670_Config.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/OV7670\ _2/OV7670/ov7670_init {F:/FPGA/Verilog/OV7670 _2/OV7670/ov7670_init/I2C_control.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/OV7670\ _2/OV7670/ov7670_init {F:/FPGA/Verilog/OV7670 _2/OV7670/ov7670_init/CLK_DIV_EVEN.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/OV7670\ _2/OV7670/ov7670_control {F:/FPGA/Verilog/OV7670 _2/OV7670/ov7670_control/ov7670_control.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/OV7670\ _2/OV7670 {F:/FPGA/Verilog/OV7670 _2/OV7670/PLL_IP.v}
vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/OV7670\ _2/OV7670 {F:/FPGA/Verilog/OV7670 _2/OV7670/OV7670_TOP.v}

vlog -vlog01compat -work work +incdir+F:/FPGA/Verilog/OV7670\ _2/OV7670/simulation/modelsim {F:/FPGA/Verilog/OV7670 _2/OV7670/simulation/modelsim/OV7670_TOP.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  OV7670_TOP_vlg_tst

add wave *
view structure
view signals
run -all
