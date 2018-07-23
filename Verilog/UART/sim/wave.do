onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /UART_Txd_Rxd_tb/SYS_CLK
add wave -noupdate -divider UART_Txd
add wave -noupdate -radix unsigned /UART_Txd_Rxd_tb/UART_Txd_inst/data_in
add wave -noupdate /UART_Txd_Rxd_tb/UART_Txd_inst/tx_req
add wave -noupdate /UART_Txd_Rxd_tb/UART_Txd_inst/Txd
add wave -noupdate /UART_Txd_Rxd_tb/UART_Txd_inst/tx_busy
add wave -noupdate -radix unsigned /UART_Txd_Rxd_tb/UART_Txd_inst/bit_cnt
add wave -noupdate -radix unsigned /UART_Txd_Rxd_tb/UART_Txd_inst/STATE
add wave -noupdate -divider UART_Txd_CTRL
add wave -noupdate -radix unsigned /UART_Txd_Rxd_tb/UART_Txd_CTRL_inst/state
add wave -noupdate -radix unsigned /UART_Txd_Rxd_tb/UART_Txd_CTRL_inst/step_cnt
add wave -noupdate /UART_Txd_Rxd_tb/UART_Txd_CTRL_inst/rd_req
add wave -noupdate -divider UART_Rxd
add wave -noupdate -radix unsigned /UART_Txd_Rxd_tb/UART_Rxd_inst/rx_data
add wave -noupdate /UART_Txd_Rxd_tb/UART_Rxd_inst/rx_busy
add wave -noupdate -radix unsigned /UART_Txd_Rxd_tb/UART_Rxd_inst/state
add wave -noupdate -radix unsigned /UART_Txd_Rxd_tb/UART_Rxd_inst/bit_cnt
add wave -noupdate -radix unsigned /UART_Txd_Rxd_tb/UART_Rxd_inst/shift_data
add wave -noupdate -radix unsigned /UART_Txd_Rxd_tb/UART_Rxd_inst/shift_data_n
add wave -noupdate /UART_Txd_Rxd_tb/UART_Rxd_inst/rx_start
add wave -noupdate /UART_Txd_Rxd_tb/UART_Rxd_inst/Rxd
add wave -noupdate -divider UART_fifo
add wave -noupdate -radix unsigned /UART_Txd_Rxd_tb/uart_tx_fifo_inst/data
add wave -noupdate -radix unsigned /UART_Txd_Rxd_tb/uart_tx_fifo_inst/q
add wave -noupdate /UART_Txd_Rxd_tb/uart_tx_fifo_inst/rdempty
add wave -noupdate -radix unsigned /UART_Txd_Rxd_tb/uart_tx_fifo_inst/wrusedw
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {150803 ns} 0}
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {840 us}
