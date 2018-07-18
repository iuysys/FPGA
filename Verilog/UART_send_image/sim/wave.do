onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /UART_Txd_tb/SYS_CLK
add wave -noupdate /UART_Txd_tb/RST_N
add wave -noupdate -divider UART_CTRL
add wave -noupdate /UART_Txd_tb/rd_clk
add wave -noupdate /UART_Txd_tb/rd_empty
add wave -noupdate /UART_Txd_tb/rd_req
add wave -noupdate -radix unsigned /UART_Txd_tb/UART_CTRL_inst/data_out
add wave -noupdate /UART_Txd_tb/UART_CTRL_inst/tx_req
add wave -noupdate /UART_Txd_tb/UART_CTRL_inst/tx_busy
add wave -noupdate -radix unsigned /UART_Txd_tb/UART_CTRL_inst/state
add wave -noupdate -radix unsigned /UART_Txd_tb/UART_CTRL_inst/step_cnt
add wave -noupdate -radix unsigned /UART_Txd_tb/UART_CTRL_inst/send_cnt
add wave -noupdate /UART_Txd_tb/Txd
add wave -noupdate -divider UART_Txd
add wave -noupdate -radix unsigned /UART_Txd_tb/UART_Txd_inst/bit_cnt
add wave -noupdate -divider uart_tx_fifo
add wave -noupdate -radix unsigned /UART_Txd_tb/uart_tx_fifo_inst/data
add wave -noupdate -radix unsigned /UART_Txd_tb/uart_tx_fifo_inst/wrusedw
add wave -noupdate /UART_Txd_tb/uart_tx_fifo_inst/rdreq
add wave -noupdate /UART_Txd_tb/uart_tx_fifo_inst/rdempty
add wave -noupdate -radix unsigned /UART_Txd_tb/uart_tx_fifo_inst/q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {297 ns} 0}
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
WaveRestoreZoom {0 ns} {3282 ns}
