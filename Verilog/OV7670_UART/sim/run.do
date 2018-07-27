#==============================================
# exit the current simulation
quit	-sim

#==============================================
# clear the console message
.main	clear

#==============================================
# make the phyical library
vlib	work

#==============================================
# mapping the logic library and phyical library
vmap	work work

#==============================================
# complie the design file
vlog	../core/*.v
vlog	../sim/OV7670_UART_tb.v
vlog	../src/*.v

#==============================================
# simulate the design file by optimization
vsim  -t ps -novopt -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver work.OV7670_UART_tb
#==============================================
# add signal to wave window
add wave -noupdate /OV7670_UART_tb/SYS_CLK
add wave -noupdate /OV7670_UART_tb/RST_N
add wave -noupdate /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/S_CLK
add wave -noupdate -divider OV7670_Capture
add wave -noupdate -expand -group OV7670_Capture /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV_vsync
add wave -noupdate -expand -group OV7670_Capture -radix hexadecimal /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/OV_data
add wave -noupdate -expand -group OV7670_Capture /OV7670_UART_tb/OV_rclk
add wave -noupdate -expand -group OV7670_Capture -radix unsigned /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/w_usedw
add wave -noupdate -expand -group OV7670_Capture /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/w_req
add wave -noupdate -expand -group OV7670_Capture /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/w_clk
add wave -noupdate -expand -group OV7670_Capture -radix hexadecimal /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/w_data
add wave -noupdate -expand -group OV7670_Capture -radix unsigned /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/state
add wave -noupdate -expand -group OV7670_Capture -radix unsigned /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/pixel_cnt
add wave -noupdate -expand -group OV7670_Capture -radix unsigned /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/step_cnt
add wave -noupdate -expand -group OV7670_Capture /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/flag_pose_edge_vs
add wave -noupdate -expand -group OV7670_Capture -radix unsigned /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/vsync_cnt
add wave -noupdate -expand -group OV7670_Capture /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/almost_full
add wave -noupdate -expand -group OV7670_Capture /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/almost_empty
add wave -noupdate -radix unsigned /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/I2C_OV7670_conf_inst/LUT_INDEX
add wave -noupdate /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/flag_wait
add wave -noupdate /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/start_init
add wave -noupdate -radix unsigned /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/wait_cnt
add wave -noupdate -divider I2C_conf
add wave -noupdate -expand -group I2C_conf /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/I2C_OV7670_conf_inst/state
add wave -noupdate -expand -group I2C_conf -radix unsigned /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/I2C_OV7670_conf_inst/LUT_INDEX
add wave -noupdate -expand -group I2C_conf /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/I2C_OV7670_conf_inst/SCCB_busy
add wave -noupdate -expand -group I2C_conf /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/I2C_OV7670_conf_inst/SCCB_req
add wave -noupdate -expand -group I2C_conf /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/I2C_OV7670_conf_inst/start_init
add wave -noupdate -expand -group I2C_conf /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/I2C_OV7670_conf_inst/init_done
add wave -noupdate -divider I2C_Write
add wave -noupdate /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/I2C_Write_inst/SCCB_req
add wave -noupdate /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/I2C_Write_inst/SCCB_SCL
add wave -noupdate /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/I2C_Write_inst/SCCB_SDA
add wave -noupdate /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/I2C_Write_inst/SCCB_busy
add wave -noupdate -radix unsigned /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/I2C_Write_inst/state
add wave -noupdate -radix unsigned /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/I2C_Write_inst/step_cnt
add wave -noupdate -radix unsigned /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/I2C_Write_inst/scl_cnt
add wave -noupdate -radix unsigned /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/I2C_Write_inst/latch_data
#==============================================
# run the simulation
run 400us
