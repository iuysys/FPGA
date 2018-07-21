onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/S_CLK
add wave -noupdate -divider OV7670_Capture
add wave -noupdate /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV_vsync
add wave -noupdate -radix hexadecimal /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/OV_data
add wave -noupdate -radix unsigned /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/w_usedw
add wave -noupdate /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/w_req
add wave -noupdate /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/w_clk
add wave -noupdate -radix hexadecimal /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/w_data
add wave -noupdate -radix unsigned /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/state
add wave -noupdate -radix unsigned /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/pixel_cnt
add wave -noupdate -radix unsigned /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/step_cnt
add wave -noupdate /OV7670_UART_tb/OV7670_UART_inst/OV7670_top_inst/OV7670_Capture_inst/w_full
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {83962500 ps} 0}
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
WaveRestoreZoom {83256939 ps} {84569439 ps}
