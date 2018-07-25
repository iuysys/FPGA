onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /OV7670_UART_tb/SYS_CLK
add wave -noupdate /OV7670_UART_tb/RST_N
add wave -noupdate /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/S_CLK
add wave -noupdate -divider OV7670_Capture
add wave -noupdate -group OV7670_Capture /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV_vsync
add wave -noupdate -group OV7670_Capture -radix hexadecimal /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/OV_data
add wave -noupdate -group OV7670_Capture /OV7670_UART_tb/OV_rclk
add wave -noupdate -group OV7670_Capture -radix unsigned /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/w_usedw
add wave -noupdate -group OV7670_Capture /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/w_req
add wave -noupdate -group OV7670_Capture /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/w_clk
add wave -noupdate -group OV7670_Capture -radix hexadecimal /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/w_data
add wave -noupdate -group OV7670_Capture -radix unsigned /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/state
add wave -noupdate -group OV7670_Capture -radix unsigned /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/pixel_cnt
add wave -noupdate -group OV7670_Capture -radix unsigned /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/step_cnt
add wave -noupdate -group OV7670_Capture /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/w_full
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
add wave -noupdate -expand -group I2C_Write /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/I2C_Write_inst/SCCB_req
add wave -noupdate -expand -group I2C_Write /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/I2C_Write_inst/SCCB_SDA
add wave -noupdate -expand -group I2C_Write /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/I2C_Write_inst/SCCB_SCL
add wave -noupdate -expand -group I2C_Write /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/I2C_Write_inst/SCCB_busy
add wave -noupdate -expand -group I2C_Write /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/I2C_Write_inst/STATE
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {199999195 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {210 us}
